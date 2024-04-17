import llvmlite.ir as ir
import llvmlite.binding
import pathlib
import ast

import closure

default_int = ir.IntType(640000)

def cast(builder, val, t=None):
    if t is None:
        if isinstance(val.type, ir.IntType):
            t = default_int
    if isinstance(val.type, ir.IntType) and isinstance(t, ir.IntType):
        if val.type.width > t.width:
            return builder.trunc(val, t)
        if val.type.width < t.width:
            return builder.sext(val, t)
        return val
    assert False


m = ir.Module()
m.triple = llvmlite.binding.get_default_triple()
source_functions : list[tuple[ir.Function, ir.IRBuilder]] = []
external_functions : dict[str, ir.Function] = {}
def compile(root: ast.AST|list):
    match root:
        case ast.Module(body):
            func = ir.Function(
                m,
                ir.FunctionType(
                    ir.IntType(32),
                    [ir.IntType(32)]
                ),
                name="main"
            )
            builder = ir.IRBuilder(func.append_basic_block())
            
            # cl = closure.get_closure(root)
            source_functions.append((func, builder))
            compile(body)
            builder.ret(ir.IntType(32)(0))
            return str(m)
        case list():
            return [*map(compile, root)]
        case ast.Expr(value):
            compile(value)
        case ast.Constant(value):
            return {
                int: default_int
            }[type(value)](value)
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
                    [cast(builder, arg, t) if isinstance(arg.type, ir.IntType) else arg for arg, t in zip(compile(args), ft.args)]
                ))
            else:
                print(ast.dump(root, indent=4))
                assert False
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
            print(ast.dump(root, indent=4))
            assert False

# if __name__ == "__main__":
#     main()

if __name__ == '__main__':
    import main
    args = main.main()
    import create_ast
    root = create_ast.create_ast(args.text, args.filename, args.verbose)
    d1 = compile(root)
    output = pathlib.Path(args.output or pathlib.Path(args.filename).resolve().with_suffix('.ll'))
    with output.open('w') as file:
        file.write(d1)



