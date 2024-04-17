import ast
import sys
import operator
import io
import functools

# def add_lineno_and_col_offset(root: ast.AST | list):
#     if isinstance(root, ast.AST):
#         root.lineno, root.col_offset = root.token.coord
#         for f in root._fields:
#             add_lineno_and_col_offset(getattr(root, f))
#     if isinstance(root, list):
#         for f in root:
#             add_lineno_and_col_offset(root[f])

class frame(dict):
    def __init__(self, prev, *a, **s):
        super().__init__(*a, **s)
        self.prev = prev

class function:
    def __init__(self, **a):
        self.__dict__.update(a)

def exec_ast_with_locals():
    top_of_stack = frame(None)

    def exec_ast(root: ast.AST | list[ast.AST]):
        nonlocal top_of_stack
        match root:
            # statements
            case ast.Module(body):
                exec_ast(body)
            case ast.Expr(value):
                return exec_ast(value)
            case ast.ImportFrom(module, names, level):
                if module in '__future__'.split() and level == 0:
                    return
                print(module, level, names)
                assert False
            case ast.If(test, body, orelse):
                test = exec_ast(test)
                return exec_ast(body if test else orelse)
            case ast.Pass():
                pass
            case ast.Assign(targets, value):
                value = exec_ast(value)
                targets = [exec_ast(target)(value) for target in targets]
            case ast.AugAssign(target, op, value):
                value = exec_ast(value)
                target.ctx = ast.Load()
                before = exec_ast(target)
                target.ctx = ast.Store()
                exec_ast(target)({
                    ast.Add:        operator.iadd,
                    ast.Mult:       operator.imul,
                    ast.Sub:        operator.isub,
                    ast.Div:        operator.itruediv,
                    ast.FloorDiv:   operator.ifloordiv,
                    ast.Mod:        operator.imod,
                }[type(op)](before, value))
            case ast.AnnAssign(target, value=value):
                exec_ast(target)(exec_ast(value))
            case ast.Break():
                return root
            case ast.Continue():
                return root
            case ast.Return(value):
                root.value = exec_ast(value)
                return root
            case ast.While(test, body, orelse):
                while exec_ast(test):
                    res = exec_ast(body)
                    if not isinstance(res, ast.Continue):
                        return res
                return exec_ast(orelse)
            case ast.FunctionDef(name, args, body, decorator_list): #TODO
                assert not decorator_list # TODO
                if name not in top_of_stack:
                    top_of_stack[name] = [None]
                top_of_stack[name][0] = function(
                    args=args,
                    body=body,
                    top_of_stack=top_of_stack
                )
            case ast.Delete(targets):
                for target in targets:
                    exec_ast(target)
            # expressions
            case ast.Constant(value):
                return value
            case ast.Call(func, args, keywords):
                args = [exec_ast(arg) for arg in args]
                keywords = {arg.arg : exec_ast(arg.value) for arg in keywords}
                match func:
                    case ast.Name(id='print', ctx=ast.Load()):
                        print(*args, **keywords)
                        return
                func = exec_ast(func)
                assert False
            case ast.BinOp(left, op, right):
                left = exec_ast(left)
                right = exec_ast(right)
                return {
                    ast.Add:        operator.add,
                    ast.Mult:       operator.mul,
                    ast.Sub:        operator.sub,
                    ast.Div:        operator.truediv,
                    ast.FloorDiv:   operator.floordiv,
                    ast.Mod:        operator.mod,
                }[type(op)](left, right)
            case ast.Name(id, ctx):
                match ctx:
                    case ast.Load():
                        frame = top_of_stack
                        while frame is not None:
                            if id in frame:
                                return frame[id][0]
                            frame = frame.prev
                        root.token.error(f'name {id!r} is not defined')
                    case ast.Store():
                        if id not in top_of_stack:
                            return lambda value: operator.setitem(top_of_stack, id, [value])
                        else:
                            return lambda value: operator.setitem(top_of_stack[id], 0, value)
                    case ast.Del():
                        del top_of_stack[id]
            case ast.Compare(left, ops, comparators):
                left = exec_ast(left)
                comparators = [*map(exec_ast, comparators)]
                return functools.reduce(lambda left, op_right: {
                    ast.Lt:     operator.lt,
                    ast.LtE:    operator.le,
                    ast.Gt:     operator.gt,
                    ast.GtE:    operator.ge,
                    ast.Eq:     operator.eq,
                    ast.NotEq:  operator.ne,
                    ast.In:     lambda a,s: a in s,
                    ast.NotIn:  lambda a,s: a not in s,
                    ast.Is:     lambda a,s: a is s,
                    ast.IsNot:  lambda a,s: a is not s,
                }[type(op_right[0])](left, op_right[1]), zip(ops, comparators), left)
            case ast.List(elts, ctx):
                match ctx:
                    case ast.Load():
                        return list(map(exec_ast, elts))
                    case ast.Del():
                        return list(map(exec_ast, elts))
                    case ast.Store():
                        def work(values):
                            values = list(values)
                            assert len(values) == len(elts)
                            for elt, value in zip(elts, values):
                                exec_ast(elt)(value)
                        return work
            case ast.Tuple(elts, ctx, token=token):
                res = exec_ast(ast.List(token=token, elts=elts, ctx=ctx))
                if isinstance(res, list):
                    return tuple(res)
                return res
            case ast.Set(elts):
                return set(map(exec_ast, elts))
            case ast.Dict(keys, values):
                return dict(zip(map(exec_ast, keys), map(exec_ast, values)))
            case ast.Subscript(value, slice, ctx):
                match ctx:
                    case ast.Load():
                        return exec_ast(value)[exec_ast(slice)]
                    case ast.Del():
                        del exec_ast(value)[exec_ast(slice)]
                    case ast.Store():
                        return lambda val: operator.setitem(exec_ast(value), exec_ast(slice), val)
            case ast.Attribute(value, attr, ctx):
                match ctx:
                    case ast.Load():
                        return getattr(exec_ast(value), attr)
                    case ast.Del():
                        delattr(exec_ast(value), attr)
                    case ast.Store():
                        return lambda val: setattr(exec_ast(value), attr, val)
            case ast.BoolOp(op, values):
                return functools.reduce({
                    ast.And: lambda a,s: a and s,
                    ast.Or:  lambda a,s: a or s,
                }[type(op)], map(exec_ast, values))
            case ast.UnaryOp(op, operand):
                return {
                    ast.Not:    lambda a: not a,
                    ast.USub:   lambda a: -a,
                    ast.Invert: lambda a: ~a,
                }[type(op)](exec_ast(operand))
            # others
            case list():
                for stmt in root:
                    res = exec_ast(stmt)
                    if res is not None:
                        return res
            case _:
                print(type(root))
                assert False

    return exec_ast

def exec_ast(root: ast.AST):
    return exec_ast_with_locals()(root)

if __name__ == '__main__':
    import main
    args = main.main()
    import create_ast
    root = create_ast.create_ast(args.text, args.filename, args.verbose)
    # root = add_lineno_and_col_offset(root)
    exec_ast(root)

    # d1 = exec_ast(root, indent=args.indent)
    # if args.verbose or not args.check:
    #     print(d1)
    # if args.check:
    #     d2 = (root)
    #     if args.verbose:
    #         print(d2)
    #     assert d1 == d2



