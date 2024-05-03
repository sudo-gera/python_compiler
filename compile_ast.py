import llvmlite.ir as ir
import llvmlite.binding
import pathlib
import ast
import subprocess
from collections import defaultdict as dd
import functools
import sys
import closure

m = ir.Module()
m.triple = ''

external_functions : dict[str, ir.Function] = {}
type_sizes = {}

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
    assert False

def call_external_func(builder: ir.IRBuilder, name: str, *args):
    func = external_functions[name]
    ft : ir.FunctionType = func.ftype
    return cast(builder, builder.call(
        func,
        [cast(builder, arg, t) for arg, t in zip(args, ft.args)]
    ))


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

def compile(node: ast.AST|list):
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
            global py_none
            call_external_func(builder, 'start_module', func.args)
            py_none = call_external_func(builder, 'constant_none')
            py_ellipsis = call_external_func(builder, 'constant_none')
            compile(body)
            call_external_func(builder, 'stop_module', [])
            return str(m)
        case list():
            return [*map(compile, node)]
        case ast.Expr(value):
            compile(value)
        case ast.Constant(value):
            assert isinstance(value, int|float|None|ellipsis|bool|bytes|str|complex)
            if isinstance(value, int):
                return call_external_func(builder, 'constant_int', default_int(value))
            if isinstance(value, float):
                return call_external_func(builder, 'constant_float', ir.DoubleType()(value))
            if isinstance(value, complex):
                return call_external_func(builder, 'constant_complex', ir.DoubleType()(value))
            if isinstance(value, bool):
                return call_external_func(builder, 'constant_bool', ir.IntType(1)(value))
            if isinstance(value, str):
                value = constant(value)
                return call_external_func(builder, 'constant_str', value, value.value_type.count)
            if isinstance(value, bytes):
                value = constant(value)
                return call_external_func(builder, 'constant_bytes', value, value.value_type.count)
            if value is None:
                return call_external_func(builder, 'constant_none')
            if value is ...:
                return call_external_func(builder, 'constant_ellipsis')
            assert False
        case _:
            print(ast.dump(node, indent=4))
            assert False

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




