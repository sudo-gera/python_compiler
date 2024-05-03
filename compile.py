import llvmlite.ir as ir
import llvmlite.binding
import pathlib
import ast
import subprocess
from collections import defaultdict as dd
import functools

import sys

import closure

default_int = ir.IntType(640000)

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
    assert False

m = ir.Module()
m.triple = ''
source_functions : list[tuple[ir.Function, ir.IRBuilder]] = []
external_functions : dict[str, ir.Function] = {}
functions = []
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

def increment_shared_link(builder: ir.IRBuilder, ptr):
    ptr_i64 = builder.bitcast(
        ptr,
        ir.intType(64).as_pointer()
    )
    builder.store(
        builder.add(
            builder.load(ptr_i64),
            ir.IntType(64)(1)
        ),
        ptr_i64
    )

def decrement_shared_link(builder: ir.IRBuilder, ptr):
    ptr_i64 = builder.bitcast(
        ptr,
        ir.intType(64).as_pointer()
    )
    builder.store(
        builder.sub(
            builder.load(ptr_i64),
            ir.IntType(64)(1)
        ),
        ptr_i64
    )

def setattr(builder: ir.IRBuilder, self, name, val):
    name = constant(name)
    builder.call(external_functions['setAttrOfPyObject'], [self, name, name.value_type.count, val])

def compile(node: ast.AST|list):
    match node:
        case ast.Module(body):
            assert subprocess.run(['clang++', '-std=c++20', pathlib.Path(__file__).with_name('platform.cpp')]).returncode == 0
            exec(subprocess.run(['./a.out'], encoding='utf-8', stdout=subprocess.PIPE).stdout)
            func = ir.Function(
                m,
                ir.FunctionType(
                    ir.IntType(32),
                    [ir.IntType(32)]
                ),
                name="main"
            )
            builder = ir.IRBuilder(func.append_basic_block())
            global builtins_
            global globals_
            builtins_ = builder.call(external_functions['createPyObject'])
            globals_ = builder.call(external_functions['createPyObject'])
            type_ = builder.call(external_functions['createPyObject'])
            setattr(builder, type_, '__class__', type_)
            setattr(builder, builtins_, 'type', type_)
            int_ = builder.call(external_functions['createPyObject'])
            setattr(builder, int_, '__class__', type_)
            setattr(builder, builtins_, 'int', int_)

            
            


            # TODO: builtins, type, ...
            cl = closure.internal_closure(node)
            frame = {}
            for name, mode in cl.vars.items():
                frame[name] = builder.call(external_functions['createPyObject'], [])
                # increment_shared_link(frame[name])
            source_functions.append((func, builder, frame))
            compile(body)
            builder.ret(ir.IntType(32)(0))
            return str(m)
        case ast.Name(id, ctx):
            if isinstance(ctx, ast.Load):
                builder = source_functions[-1][1]
                frame = source_functions[-1][2]
                return builder.load(frame[id])
            assert False
        case ast.Assign(targets, value):
            map(compile(targets), value)

            
        case list():
            return [*map(compile, node)]
        case ast.Expr(value):
            compile(value)
        case ast.Constant(value):
            if isinstance(value, int):
                return {
                    int: default_int
                }[type(value)](value)
            if isinstance(value, str):
                value = value.encode()
            if isinstance(value, bytes|bytearray):
                return constant(value)
            assert False
        case ast.BinOp(left, op, right):
            builder = source_functions[-1][1]
            return {
                ast.Add: builder.add,
                ast.Sub: builder.sub,
                ast.Mult: builder.mul,
            }[type(op)](compile(left), compile(right))
        case ast.Call(func, args, keywords):
            if isinstance(func, ast.Name) and func.id in external_functions:
                assert not keywords
                builder = source_functions[-1][1]
                func = external_functions[func.id]
                ft : ir.FunctionType = func.ftype
                return cast(builder, builder.call(
                    func,
                    [cast(builder, arg, t) for arg, t in zip(compile(args), ft.args)]
                ))
            else:
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




