import llvmlite.ir as ir
import llvmlite.binding
import pathlib
import ast
import subprocess
from collections import defaultdict as dd
import functools

import sys

import closure

default_int = ir.IntType(64)

def cast(builder: ir.IRBuilder, val, t=None):
    if t is None:
        if isinstance(val.type, ir.IntType):
            t = default_int
        else:
            assert False
    if isinstance(val.type, ir.IntType) and isinstance(t, ir.IntType):
        if val.type.width > t.width:
            return builder.trunc(val, t)
        if val.type.width < t.width:
            return builder.sext(val, t)
        return val
    if isinstance(val.type, ir.PointerType) and isinstance(t, ir.PointerType):
        return builder.bitcast(val, t)
    if isinstance(val.type, ir.DoubleType) and isinstance(t, ir.IntType):
        return cast(builder, builder.call(external_functions['double_to_int64'], [val]), t)
    if isinstance(val.type, ir.IntType) and isinstance(t, ir.DoubleType):
        return builder.call(external_functions['int64_to_double'], [cast(builder, val, ir.IntType(64))])
    if isinstance(val.type, ir.DoubleType) and isinstance(t, ir.DoubleType):
        return val
    print(val.type, t)
    assert False

m = ir.Module()
m.triple = ''
source_functions : list[tuple[ir.Function, ir.IRBuilder]] = []
external_functions : dict[str, ir.Function] = {}
functions : dict[ast.AST, dict] = {}
type_sizes = {}
types = [
    dict(name='type'),
    dict(name='int'),
    dict(name='function'),
    dict(name='cell'),
]
default_types = {v['name']:k for k,v in enumerate(types)}
builtins_ = None
globals_ = None

@functools.cache
def constant(val, name=None):
    if name is None:
        name = f'python_compiler_constant_{id(val)}'
    if isinstance(val, str):
        val = val.encode()
    if isinstance(val, bytes|bytearray):
        con = ir.Constant(ir.ArrayType(ir.IntType(8), len(val)), bytearray(val))
        gvar = ir.GlobalVariable(m, con.type, name)
        gvar.linkage = 'internal'
        gvar.global_constant = True
        gvar.initializer = con
        return gvar
    assert False

def setattr(builder: ir.IRBuilder, self, name, val):
    name = constant(name)
    builder.call(external_functions['setAttrOfPyObject'], [self, name, name.value_type.count, val])

def compile(node: ast.AST|list, value_for_storing = None):
    match node:
        case ast.Module(body):
            assert subprocess.run(['clang++', '-std=c++20', pathlib.Path(__file__).with_name('platform.cpp')]).returncode == 0
            exec(subprocess.run(['./a.out'], encoding='utf-8', stdout=subprocess.PIPE).stdout)
            func = ir.Function(
                m,
                ir.FunctionType(
                    ir.IntType(32),
                    [ir.IntType(32), ir.IntType(8).as_pointer().as_pointer()]
                ),
                name="main"
            )
            builder = ir.IRBuilder(func.append_basic_block())
            # global globals_
            # global builtins_
            # builtins_ = builder.call(external_functions['createPyObject'])
            # globals_ = builder.call(external_functions['createPyObject'])
            # type_ = builder.call(external_functions['createPyObject'])
            # setattr(builder, type_, '__class__', type_)
            # setattr(builder, builtins_, 'type', type_)
            # int_ = builder.call(external_functions['createPyObject'])
            # setattr(builder, int_, '__class__', type_)
            # setattr(builder, builtins_, 'int', int_)
            cl = closure.internal_closure(node)
            # functions.setdefault(node, {})
            # functions[node].setdefault('closure', cl)
            # functions[node].setdefault('type_mappings', [])
            # functions[node]['type_mappings'].append([{name: None for name in cl.vars}, {}])
            # current_type_map_index = 0
            # while current_type_map_index < functions[node]['type_mappings']:
            #     current_type_map = functions[node]['type_mappings'][current_type_map_index]
            #     current_type_map_index += 1
            # # TODO: builtins, type, ...
            frame = {}
            for name, mode in cl.vars.items():
                # if mode & 1:
                    # frame[name] = builder.call(external_functions['create_py_object'], [])
                # else:
                #     frame[name] = builder.alloca(ir.DoubleType())
                frame[name] = builder.call(external_functions['create_py_object'], [])
            source_functions.append(dict(func=func, builder=builder, frame=frame, types={}))
            compile(body)
            # for name, mode in cl.vars.items():
            #     if mode & 1:
            #         frame[name] = builder.call(external_functions['create_py_object'], [])
            #     else:
            #         frame[name] = builder.alloca(ir.DoubleType())
            builder.ret(ir.IntType(32)(0))
            return str(m)
        case ast.Name(id, ctx):
            builder: ir.IRBuilder
            builder = source_functions[-1]['builder']
            types = source_functions[-1]['types']
            frame = source_functions[-1]['frame']
            if isinstance(ctx, ast.Load):
                if id not in types:
                    node.token.error(f'unknown variable {id:r}')
                return builder.load(cast(builder, frame[id], types[id].as_pointer()))
            if isinstance(ctx, ast.Store):
                if id not in types:
                    types[id] = value_for_storing.type
                builder.store(cast(builder, value_for_storing, types[id]), cast(builder, frame[id], types[id].as_pointer()), 8)
            if isinstance(ctx, ast.Del):
                assert False
                # if source_functions[-1]['types'].get('id', value.type) != value.type:
                #     node.token.error(f'cannot assign')
        case ast.Assign(targets, value):
            value_for_storing = compile(value)
            targets = compile(targets, value_for_storing)
        case list():
            return [*map(lambda a: compile(a, value_for_storing), node)]
        case ast.Expr(value):
            compile(value)
        case ast.Constant(value):
            if isinstance(value, int):
                return default_int(value)
            if isinstance(value, float):
                return ir.DoubleType()(value)
            if isinstance(value, str):
                value = value.encode()
            if isinstance(value, bytes|bytearray):
                return constant(value)
            assert False
        case ast.BinOp(left, op, right):
            builder = source_functions[-1]['builder']
            left = compile(left)
            right = compile(right)
            if isinstance(left.type, ir.DoubleType) or isinstance(right.type, ir.DoubleType) or isinstance(op, ast.Div):
                left = cast(builder, left, ir.DoubleType())
                right = cast(builder, right, ir.DoubleType())
                if isinstance(op, ast.Mod):
                    return builder.frem(builder.fadd(builder.frem(left, right), right), right)
                if isinstance(op, ast.FloorDiv):
                    return builder.fdiv(builder.fsub(left, builder.frem(builder.fadd(builder.frem(left, right), right), right)), right)
                return {
                    ast.Add: builder.fadd,
                    ast.Sub: builder.fsub,
                    ast.Mult: builder.fmul,
                    ast.Div: builder.fdiv,
                }[type(op)](left, right)
            if isinstance(op, ast.Mod):
                return builder.srem(builder.add(builder.srem(left, right), right), right)
            if isinstance(op, ast.FloorDiv):
                return builder.sdiv(builder.sub(left, builder.srem(builder.add(builder.srem(left, right), right), right)), right)
            return {
                ast.Add: builder.add,
                ast.Sub: builder.sub,
                ast.Mult: builder.mul,
            }[type(op)](left, right)
        case ast.Call(func, args, keywords):
            match func:
                case ast.Attribute(ast.Tuple([]), attr):
                    if attr in external_functions:
                        builder = source_functions[-1]['builder']
                        func = external_functions[attr]
                        ft : ir.FunctionType = func.ftype
                        return cast(builder, builder.call(
                            func,
                            [cast(builder, arg, t) for arg, t in zip(compile(args), ft.args)]
                        ))
            print(ast.dump(node, indent=4))
            assert False
        case ast.FunctionDef(name, args, body, decorator_list, returns):
            assert not decorator_list
            match args:
                case ast.arguments(posonlyargs, args, vararg, kwonlyargs, kw_defaults, kwarg, defaults):
                    assert not posonlyargs
                    assert not vararg
                    assert not kwonlyargs
                    assert not kw_defaults
                    assert not kwarg
                    assert not defaults
                case _: assert False
            modes = [closure.mode_external, closure.mode_nonlocal_]
            cl = closure.internal_closure(node)
            for name, mode in cl.vars.items():
                if min(map(mode.__xor__, modes)) < 2:
                    ...
            func_store = compile(ast.Name(token=node.token, id=name, ctx=ast.Store()))



        case ast.AsyncFunctionDef(name, args, body, decorator_list, returns):
            assert not decorator_list
            match args:
                case ast.arguments(posonlyargs, args, vararg, kwonlyargs, kw_defaults, kwarg, defaults):
                    assert not posonlyargs
                    assert not vararg
                    assert not kwonlyargs
                    assert not kw_defaults
                    assert not kwarg
                    assert not defaults
                case _: assert False
            external_functions[name]=ir.Function(m, ir.FunctionType(eval(returns.value), [eval(arg.annotation.value) for arg in args]), name=name)
        case _:
            print(ast.dump(node, indent=4))
            assert False

# if __name__ == "__main__":
#     main()

if __name__ == '__main__':
    import main
    args = main.main()
    import create_ast
    root = create_ast.create_ast(args.text, args.filename, args.verbose)
    d1 = compile(root)
    ll_filename = pathlib.Path(args.filename).resolve().with_suffix('.ll')
    output = pathlib.Path(args.output or ll_filename)
    with output.open('w') as file:
        file.write(d1)
    assert subprocess.run(['clang++', '-std=c++20', pathlib.Path(__file__).with_name('lib.cpp'), ll_filename]).returncode == 0
    exit(subprocess.run(['./a.out']).returncode)




