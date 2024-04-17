#grep -Irne '\bast\b\s*\.\s*[A-Z][A-Za-z_]*' --color=always | sed $'s/[^\x1b]*\x1b\\[01;31m\x1b\\[K\([^\x1b]*\)\x1b\\[m\x1b\\[K[^\x1b]*/\\1, /g' | sed -E 's/, ([^\n])/, \n\1/g' | sed -E 's/ast *\. */ast./g' | sed -E 's/, *//g' | sort | uniq | sed -E 's/(.*)/python3.12 -c '"$'"'import ast\\nprint("case \1\("+", ".join(\1._fields)+"\):\\\\n    assert False")'"'"'/g' | bash
import ast
def example(root: ast.AST):
    match root:
        case ast.AST():
            assert False
        case ast.Add():
            assert False
        case ast.And():
            assert False
        case ast.AnnAssign(target, annotation, value, simple):
            assert False
        case ast.Assert(test, msg):
            assert False
        case ast.Assign(targets, value, type_comment):
            assert False
        case ast.AsyncFor(target, iter, body, orelse, type_comment):
            assert False
        case ast.AsyncFunctionDef(name, args, body, decorator_list, returns, type_comment, type_params):
            assert False
        case ast.AsyncWith(items, body, type_comment):
            assert False
        case ast.Attribute(value, attr, ctx):
            assert False
        case ast.AugAssign(target, op, value):
            assert False
        case ast.Await(value):
            assert False
        case ast.BinOp(left, op, right):
            assert False
        case ast.BitAnd():
            assert False
        case ast.BitOr():
            assert False
        case ast.BitXor():
            assert False
        case ast.BoolOp(op, values):
            assert False
        case ast.Break():
            assert False
        case ast.Call(func, args, keywords):
            assert False
        case ast.ClassDef(name, bases, keywords, body, decorator_list, type_params):
            assert False
        case ast.Compare(left, ops, comparators):
            assert False
        case ast.Constant(value, kind):
            assert False
        case ast.Continue():
            assert False
        case ast.Del():
            assert False
        case ast.Delete(targets):
            assert False
        case ast.Dict(keys, values):
            assert False
        case ast.DictComp(key, value, generators):
            assert False
        case ast.Div():
            assert False
        case ast.Eq():
            assert False
        case ast.ExceptHandler(type, name, body):
            assert False
        case ast.Expr(value):
            assert False
        case ast.FloorDiv():
            assert False
        case ast.For(target, iter, body, orelse, type_comment):
            assert False
        case ast.FormattedValue(value, conversion, format_spec):
            assert False
        case ast.FunctionDef(name, args, body, decorator_list, returns, type_comment, type_params):
            assert False
        case ast.GeneratorExp(elt, generators):
            assert False
        case ast.Global(names):
            assert False
        case ast.Gt():
            assert False
        case ast.GtE():
            assert False
        case ast.If(test, body, orelse):
            assert False
        case ast.IfExp(test, body, orelse):
            assert False
        case ast.Import(names):
            assert False
        case ast.ImportFrom(module, names, level):
            assert False
        case ast.In():
            assert False
        case ast.Invert():
            assert False
        case ast.Is():
            assert False
        case ast.IsNot():
            assert False
        case ast.JoinedStr(values):
            assert False
        case ast.LShift():
            assert False
        case ast.Lambda(args, body):
            assert False
        case ast.List(elts, ctx):
            assert False
        case ast.ListComp(elt, generators):
            assert False
        case ast.Load():
            assert False
        case ast.Lt():
            assert False
        case ast.LtE():
            assert False
        case ast.MatMult():
            assert False
        case ast.Mod():
            assert False
        case ast.Module(body, type_ignores):
            assert False
        case ast.Mult():
            assert False
        case ast.Name(id, ctx):
            assert False
        case ast.NamedExpr(target, value):
            assert False
        case ast.Nonlocal(names):
            assert False
        case ast.Not():
            assert False
        case ast.NotEq():
            assert False
        case ast.NotIn():
            assert False
        case ast.Or():
            assert False
        case ast.ParamSpec(name):
            assert False
        case ast.Pass():
            assert False
        case ast.Pow():
            assert False
        case ast.RShift():
            assert False
        case ast.Raise(exc, cause):
            assert False
        case ast.Return(value):
            assert False
        case ast.Set(elts):
            assert False
        case ast.SetComp(elt, generators):
            assert False
        case ast.Slice(lower, upper, step):
            assert False
        case ast.Starred(value, ctx):
            assert False
        case ast.Store():
            assert False
        case ast.Sub():
            assert False
        case ast.Subscript(value, slice, ctx):
            assert False
        case ast.Try(body, handlers, orelse, finalbody):
            assert False
        case ast.TryStar(body, handlers, orelse, finalbody):
            assert False
        case ast.Tuple(elts, ctx):
            assert False
        case ast.TypeAlias(name, type_params, value):
            assert False
        case ast.TypeVar(name, bound):
            assert False
        case ast.TypeVarTuple(name):
            assert False
        case ast.UAdd():
            assert False
        case ast.USub():
            assert False
        case ast.UnaryOp(op, operand):
            assert False
        case ast.While(test, body, orelse):
            assert False
        case ast.With(items, body, type_comment):
            assert False
        case ast.Yield(value):
            assert False
        case ast.YieldFrom(value):
            assert False
        case _:
            assert False
