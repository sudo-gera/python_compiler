import llvmlite.ir as ir
import llvmlite.binding
import pathlib
import ast
import subprocess
from collections import defaultdict as dd
import functools
import operator
from copy import copy
import builtins

import sys

import closure

default_int = ir.IntType(64)

def cast(builder: ir.IRBuilder, val, t:ir.Type=None, name=''):
    if t is None:
        if isinstance(val.type, ir.IntType):
            t = default_int
        else:
            return val
            # assert False
    # if t is not None and not isinstance(t, ir.Type):
    #     t = ir.IntType(8).as_pointer()
    if isinstance(t, ir.IntType) and t.width == 1:
        if isinstance(val.type, ir.IntType):
            return builder.icmp_signed('!=', val, val.type(0), name=name)
        if isinstance(val.type, ir.DoubleType):
            return builder.fcmp_unordered('!=', val, val.type(0), name=name)
    if isinstance(val.type, ir.IntType) and val.type.width == 1:
        val = builder.zext(val, ir.IntType(2), name=name)
    if isinstance(val.type, ir.IntType) and isinstance(t, ir.IntType):
        if val.type.width > t.width:
            return builder.trunc(val, t, name=name)
        if val.type.width < t.width:
            return builder.sext(val, t, name=name)
        return val
    if isinstance(val.type, ir.PointerType) and isinstance(t, ir.PointerType):
        return builder.bitcast(val, t, name=name)
    if isinstance(val.type, ir.DoubleType) and isinstance(t, ir.IntType):
        return builder.fptosi(val, t, name=name)
    if isinstance(val.type, ir.IntType) and isinstance(t, ir.DoubleType):
        return builder.sitofp(val, t, name=name)
    if isinstance(val.type, ir.DoubleType) and isinstance(t, ir.DoubleType):
        return val
    print(val.type, t)
    assert False

class variable:
    def __init__(self, **a):
        self.location: object|None = None
        self.type: ir.Type|None = None
        self.__dict__.update(a)
    def __repr__(self):
        return repr(self.__dict__)

class function_frame:
    def __init__(self, **a):
        self.builder: ir.IRBuilder
        self.func: ir.Function
        self.vars: dict[str, variable]
        self.__dict__.update(a)
    def __repr__(self):
        return repr(self.__dict__)

class function_info:
    def __init__(self, **a):
        self.node: ast.FunctionDef
        self.__dict__.update(a)
    def __repr__(self):
        return repr(self.__dict__)
    def make_func(self, *a):
        node = self.node
        aa = tuple([frozenset(s) if isinstance(s, set) else s for s in a])
        if aa in functions[node].instances:
            return functions[node].instances[aa].func
        func_type = ir.FunctionType(
            ir.VoidType(),
            [ir.IntType(8).as_pointer()] + [ir.IntType(8).as_pointer() if isinstance(s, set) else s for s in a]
        )
        functions[node].instances[aa] = func_instance()
        func = ir.Function(
            m,
            func_type,
            name=f'{functions[node].name}_{unique_int()}',
        )
        functions[node].instances[aa].func = func
        new_py_func = func.args[0]
        new_builder = ir.IRBuilder(func.append_basic_block())
        new_vars = {}
        tmp_vars = functions[node].tmp_vars
        for name in tmp_vars:
            index = tmp_vars[name].location
            new_vars[name] = variable(type=tmp_vars[name].type)
            if index is None:
                new_vars[name].location = new_builder.call(external_functions['create_py_object'], [])
            else:
                new_vars[name].location = new_builder.call(external_functions['get_cell_from_function'], [new_py_func, default_int(index)], name=name)
        # print(tmp_vars)
        assert len(self.node.args.args) + 1 == len(func.args)
        source_functions.append(function_frame(builder=new_builder, vars=new_vars))
        for ir_arg, ast_arg, a_arg in zip(func.args[1:], self.node.args.args, a):
            if isinstance(a_arg, set):
                ir_arg.magic_type = a_arg
            compile(
                ast.Name(
                    id=ast_arg.arg,
                    ctx=ast.Store(),
                ),
                value_for_storing=ir_arg,
            )
        compile(node.body)
        new_builder.ret_void()
        source_functions.pop()
        return func



class func_instance:
    def __init__(self, **a):
        self.__dict__.update(a)
    def __repr__(self):
        return repr(self.__dict__)


f=0
def unique_int():
    global f
    f+=1
    return f

m = ir.Module()
m.triple = ''
source_functions : list[function_frame] = []
external_functions : dict[str, ir.Function] = {}
functions : dict[ast.AST, function_info] = {}
type_sizes = {}

def call_func(builder, func, args):
    ft : ir.FunctionType = func.ftype
    return cast(builder, builder.call(
        func,
        [cast(builder, arg, t) for arg, t in zip(args, ft.args)]
    ))

# types = [
#     dict(name='type'),
#     dict(name='int'),
#     dict(name='function'),
#     dict(name='cell'),
# ]
# default_types = {v['name']:k for k,v in enumerate(types)}
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

def compile(node: ast.AST|list, *, value_for_storing = None):
    match node:
        case ast.Module(body):
            assert subprocess.run(['clang++', '-std=c++20', '-g', '-fsanitize=address,undefined', pathlib.Path(__file__).with_name('platform.cpp')]).returncode == 0
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
            vars = {}
            for name, mode in cl.vars.items():
                # if mode & 1:
                    # frame[name] = builder.call(external_functions['create_py_object'], [])
                # else:
                #     frame[name] = builder.alloca(ir.DoubleType())
                vars[name] = variable()
                vars[name].location = builder.call(external_functions['create_py_object'], [], name=name)
            source_functions.append(function_frame(builder=builder, vars = vars))
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
            builder = source_functions[-1].builder
            vars = source_functions[-1].vars
            if isinstance(ctx, ast.Load):
                if id not in vars or vars[id].type is None:
                    node.token.error(f'unknown variable {id!r}')
                t = vars[id].type
                if not isinstance(t, ir.Type):
                    t = ir.IntType(8).as_pointer()
                value = builder.load(cast(builder, vars[id].location, t.as_pointer()), name=id)
                value.magic_type = vars[id].type
                return value
            if isinstance(ctx, ast.Store):
                if vars[id].type is None:
                    vars[id].type = value_for_storing.type
                    if hasattr(value_for_storing, 'magic_type'):
                        vars[id].type = value_for_storing.magic_type
                else:
                    if isinstance(vars[id].type, set) and isinstance(value_for_storing.magic_type, set):
                        vars[id].type |= value_for_storing.magic_type
                t = vars[id].type
                if not isinstance(t, ir.Type):
                    t = ir.IntType(8).as_pointer()
                assert value_for_storing is not None
                assert vars[id].location is not None
                builder.store(cast(builder, value_for_storing, t, name=id), cast(builder, vars[id].location, t.as_pointer(), name=id), 8)
            if isinstance(ctx, ast.Del):
                assert False
                # if source_functions[-1]['types'].get('id', value.type) != value.type:
                #     node.token.error(f'cannot assign')
        case ast.AugAssign(target, op, value):
            target1 = copy(target)
            target1.ctx = ast.Load()
            return compile(
                ast.Assign(
                    token=node.token,
                    targets=[target],
                    value=ast.BinOp(
                        token=node.token,
                        left=target1,
                        op=op,
                        right=value,
                    )
                )
            )
        case ast.Assign(targets, value):
            value = compile(value)
            assert value is not None
            targets = compile(targets, value_for_storing=value)
        case list():
            return [*map(lambda a: compile(a, value_for_storing=value_for_storing), node)]
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
            builder = source_functions[-1].builder
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
            left = cast(builder, left, default_int)
            right = cast(builder, right, default_int)
            if isinstance(op, ast.Mod):
                return builder.srem(builder.add(builder.srem(left, right), right), right)
            if isinstance(op, ast.FloorDiv):
                return builder.sdiv(builder.sub(left, builder.srem(builder.add(builder.srem(left, right), right), right)), right)
            return {
                ast.Add: builder.add,
                ast.Sub: builder.sub,
                ast.Mult: builder.mul,
            }[type(op)](left, right)
        case ast.UnaryOp(op, operand):
            builder = source_functions[-1].builder
            operand = compile(operand)
            if isinstance(operand.type, ir.DoubleType):
                if isinstance(op, ast.USub):
                    return builder.fneg(operand)
                if isinstance(op, ast.UAdd):
                    return operand
            if isinstance(operand.type, ir.IntType):
                if isinstance(op, ast.USub):
                    return builder.neg(operand)
                if isinstance(op, ast.UAdd):
                    return operand
            assert False
        case ast.Compare(left, ops, comparators):
            builder = source_functions[-1].builder
            left = compile(left)
            comparators = compile(comparators)
            res = []
            for op, right in zip(ops, comparators):
                match op:
                    case ast.Eq():
                        reducer, sign = [builder.and_, '==']
                    case ast.NotEq():
                        reducer, sign = [builder.or_, '!=']
                    case ast.Lt():
                        reducer, sign = [builder.or_, '<']
                    case ast.Gt():
                        reducer, sign = [builder.or_, '>']
                    case ast.LtE():
                        reducer, sign = [builder.and_, '<=']
                    case ast.GtE():
                        reducer, sign = [builder.and_, '>=']
                cast_types = [(builder.icmp_signed, default_int), (builder.fcmp_unordered, ir.DoubleType())]
                if isinstance(left.type, ir.IntType) and isinstance(right.type, ir.IntType):
                    cast_types = cast_types[0:1]
                if isinstance(left.type, ir.DoubleType) and isinstance(right.type, ir.DoubleType):
                    cast_types = cast_types[1:2]
                res.append(functools.reduce(reducer, [f(sign, *[cast(builder, val, t) for val in [left, right]]) for f,t in cast_types]))
                left = right
            return functools.reduce(builder.and_, res)
        case ast.Call(func, args, keywords):
            builder = source_functions[-1].builder
            match func:
                case ast.Attribute(ast.Tuple([]), attr):
                    if attr in external_functions:
                        return call_func(builder, external_functions[attr], compile(args))
            func_type = ir.FunctionType(
                ir.VoidType(),
                [ir.IntType(8).as_pointer()]
            )
            py_func = compile(func)
            args = compile(args)
            arg_types = [arg.magic_type if hasattr(arg, 'magic_type') else arg.type for arg in args]
            func_id = call_func(builder, external_functions['get_code_from_function'], [py_func])
            end_block = builder.append_basic_block()
            default_block = builder.append_basic_block()
            with builder.goto_block(default_block):
                call_func(builder, external_functions['putchar'], [default_int(63)])
                call_func(builder, external_functions['putchar'], [default_int(63)])
                call_func(builder, external_functions['putchar'], [default_int(63)])
                call_func(builder, external_functions['print_int'], [func_id])
                builder.branch(end_block)
            switch = builder.switch(func_id, default_block)
            # print(ast.dump(node.func), py_func.magic_type)
            for node in py_func.magic_type:
                # print(node.name)
                func = functions[node].make_func(*arg_types)
                block = builder.append_basic_block()
                switch.add_case(default_int(builtins.id(node)), block)
                with builder.goto_block(block):
                    builder.call(func, [py_func] + args)
                    builder.branch(end_block)
            builder.position_at_end(end_block)

                # with builder.if_then(builder.icmp_signed('==', default_int(builtins.id(node)), func_id)):
                #     builder.call(func, [py_func] + args)
        case ast.FunctionDef(name, args, body, decorator_list, returns):
            # print(f'{name} <-> {builtins.id(node)}')
            functions[node] = function_info()
            functions[node].name = name
            functions[node].node = node
            functions[node].instances = {}
            old_builder = source_functions[-1].builder
            old_vars = source_functions[-1].vars
            if not isinstance(old_vars[name].type, set):
                old_vars[name].type = set()
            old_vars[name].type |= {node}
            old_py_func = old_builder.call(external_functions['create_py_function'], [default_int(builtins.id(node))], name=name)
            old_builder.store(old_py_func, cast(old_builder, old_vars[name].location, old_py_func.type.as_pointer()), 8)
            functions[node].cl = closure.internal_closure(node)
            index = 0
            functions[node].tmp_vars = {}
            for name, mode in functions[node].cl.vars.items():
                functions[node].tmp_vars[name] = variable()
                if mode ^ closure.mode_local < 2:
                    functions[node].tmp_vars[name].location = None
                else:
                    if mode ^ closure.mode_global_ < 2:
                        source_functions_index = 0
                    if mode ^ closure.mode_nonlocal_ < 2:
                        source_functions_index = -1
                    if mode ^ closure.mode_external < 2:
                        source_functions_index = -1
                    old_builder.call(external_functions['add_cell_to_function'], [old_py_func, source_functions[source_functions_index].vars[name].location], name=name)
                    functions[node].tmp_vars[name].location = index
                    functions[node].tmp_vars[name].type = source_functions[source_functions_index].vars[name].type
                    index += 1
        case ast.If(test, body, orelse):
            builder = source_functions[-1].builder
            with builder.if_else(cast(builder, compile(test), ir.IntType(1))) as (then, otherwise):
                with then:
                    compile(body)
                with otherwise:
                    compile(orelse)
        case ast.Global():
            pass
        case ast.Nonlocal():
            pass
        case ast.Pass():
            pass
        case ast.While(test, body, orelse):
            builder = source_functions[-1].builder
            block = builder.append_basic_block()
            builder.branch(block)
            builder.position_at_end(block)
            with builder.if_else(cast(builder, compile(test), ir.IntType(1))) as (then, otherwise):
                with then:
                    compile(body)
                    builder.branch(block)
                with otherwise:
                    compile(orelse)
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
    assert subprocess.run(['clang++', '-std=c++20', '-g', '-fsanitize=address,undefined', pathlib.Path(__file__).with_name('lib.cpp'), ll_filename]).returncode == 0
    exit(subprocess.run(['./a.out']).returncode)




