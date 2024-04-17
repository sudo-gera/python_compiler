from __future__ import annotations
#grep -Irne '\bast\b\s*\.\s*[A-Z][A-Za-z_]*' --color=always | sed $'s/[^\x1b]*\x1b\\[01;31m\x1b\\[K\([^\x1b]*\)\x1b\\[m\x1b\\[K[^\x1b]*/\\1, /g' | sed -E 's/, ([^\n])/, \n\1/g' | sed -E 's/ast *\. */ast./g' | sed -E 's/, *//g' | sort | uniq | sed -E 's/(.*)/python3.12 -c '"$'"'import ast\\nprint("case \1\("+", ".join(\1._fields)+"\):\\\\n    return functools.reduce(merge, map(get_closure, ["+", ".join(\1._fields)+"]), dd(lambda: undefined))")'"'"'/g' | bash
import ast
import sys
import operator
import io
import functools
import typing
from collections import defaultdict as dd

mode_undefined_owned   = 0b00000
mode_external_owned    = 0b00010
mode_local_owned       = 0b00110
mode_nonlocal_owned    = 0b01110
mode_global_owned      = 0b10110
mode_undefined         = 0b00001
mode_external          = 0b00011
mode_local             = 0b00111
mode_nonlocal_         = 0b01111
mode_global_           = 0b10111

class closure_info:
    def __init__(self, vars:dd[str,int]|dict[str,int]|None=None):
        vars = dd(int) if vars is None else vars
        self.vars : dd[str, int] = dd(int,vars)
        self.coro : bool = False
        self.subfuncs : list[closure_info] = []
    def __add__(self, oth: closure_info):
        res = closure_info()
        res.vars = merge(self.vars, oth.vars)
        res.coro = self.coro or oth.coro
        res.subfuncs = self.subfuncs + oth.subfuncs
        return res
    def __iadd__(self, oth: closure_info):
        return self + oth
    def __neg__(self):
        outer_map={}
        outer_map[mode_undefined_owned   ] = mode_undefined_owned
        outer_map[mode_external_owned    ] = mode_undefined
        outer_map[mode_local_owned       ] = mode_undefined_owned
        outer_map[mode_nonlocal_owned    ] = mode_undefined
        outer_map[mode_global_owned      ] = mode_undefined_owned
        outer_map[mode_undefined         ] = mode_undefined
        outer_map[mode_external          ] = mode_undefined
        outer_map[mode_local             ] = mode_undefined_owned
        outer_map[mode_nonlocal_         ] = mode_undefined
        outer_map[mode_global_           ] = mode_undefined_owned
        res = closure_info()
        res.vars = {k: outer_map[v] for k,v in self.vars.items()}
        res.subfuncs = [self]
        return res

def merge(d1: dd[str, int], d2: dd[str, int]) -> dd[str, int]:
    return dd(int, {
        k:d1[k]|d2[k]
    for k in d1 | d2})

# stack = []

def get_neg_closure(root: ast.AST|list) -> closure_info:
    return sum(get_closure_list(root), closure_info())

def get_closure_list(root: ast.AST|list) -> typing.Iterable[closure_info]:
    match root:
        case [*nodes]:
            return map(get_neg_closure, nodes)
        case int() | bool() | str() | None:
            return []

        case ast.Lambda(args, body) |\
             ast.FunctionDef(_, args, body) |\
             ast.AsyncFunctionDef(_, args, body) |\
             ast.Module(body, args):
            args = args if isinstance(args, ast.arguments) else ast.arguments(posonlyargs=[], args=[], kwonlyargs=[], defaults=[], kw_defaults=[])
            body = body if isinstance(body, list) else [body]
            res = -(
                closure_info({arg.arg: mode_local_owned for arg in (
                    args.posonlyargs +
                    args.args +
                    ([] if args.vararg is None else [args.vararg]) +
                    args.kwonlyargs +
                    ([] if args.kwarg is None else [args.kwarg])
                )}) +
                get_neg_closure(body)
            ) + get_neg_closure(args.defaults) + get_neg_closure(args.kw_defaults)
            match root:
                case ast.AsyncFunctionDef(name, args, body, decorator_list, returns) |\
                        ast.FunctionDef(name, args, body, decorator_list, returns):
                    res += closure_info({name: mode_local_owned})
                    res += get_neg_closure(decorator_list)
                    res += get_neg_closure(returns)
            return [res]

        case ast.ClassDef(name, bases, keywords, body, decorator_list):
            assert False
            return map(get_neg_closure, [name, bases, keywords, body, decorator_list])
        case ast.DictComp(key, value, generators):
            assert False
            return map(get_neg_closure, [key, value, generators])
        case ast.SetComp(elt, generators) |\
                ast.ListComp(elt, generators) |\
                ast.GeneratorExp(elt, generators):
            assert False
            return map(get_neg_closure, [elt, generators])
        case ast.ExceptHandler(type, name, body):
            assert False
            return map(get_neg_closure, [type, name, body])

        case ast.Import(names):
            return [closure_info({name.name if name.asname is None else name.asname: mode_local_owned for name in names})]
        case ast.ImportFrom(module, names, level):
            return [closure_info({name.name if name.asname is None else name.asname: mode_local_owned for name in names})]
        case ast.Name(id, ctx):
            return [closure_info({id: mode_external_owned if isinstance(ctx, ast.Load) else mode_local_owned})]
        case ast.Global(names):
            return [closure_info({name: mode_global_owned for name in names})]
        case ast.Nonlocal(names):
            return [closure_info({name: mode_nonlocal_owned for name in names})]

        # case ast.TypeAlias(name, value):
        #     assert False
        #     return map(get_neg_closure, [name, value])
        # case ast.TypeVar(name, bound):
        #     assert False
        #     return map(get_neg_closure, [name, bound])
        # case ast.TypeVarTuple(name):
        #     assert False
        #     return map(get_neg_closure, [name])
        # case ast.ParamSpec(name):
        #     assert False
        #     return map(get_neg_closure, [name])

        case ast.AST():
            return [get_neg_closure(getattr(root, f)) for f in root._fields]
        case _:
            assert isinstance(root, ast.AST)
            print(ast.dump(root, indent=4))
            assert False

def get_closure(root: ast.AST) -> closure_info:
    cl = get_neg_closure(root).subfuncs[0]
    if isinstance(root, ast.Module):
        a = [cl]
        for c in a:
            a += c.subfuncs
            for name, mode in c.vars.items():
                if mode ^ mode_global_ < 2:
                    cl.vars[name] |= 1
    return cl

            
