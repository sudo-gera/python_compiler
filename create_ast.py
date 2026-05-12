from __future__ import annotations
import ast
import argparse
import sys
import re
import bisect
import traceback
import operator
import functools
from typing import Any, Optional
import unicodedata
import tokenize
import pegen.parser
import os.path
import json
import token as token_module
import argparse
import typing

import python_parser
from pegen.tokenizer import Tokenizer

checking_cast_t = typing.TypeVar('checking_cast_t')

def checking_cast(t: type[checking_cast_t], val: Any) -> checking_cast_t:
    assert isinstance(val, t)
    return val

def to_char_parser(parser: python_parser.GeneratedParser) -> char_parser:
    return checking_cast(char_parser, parser)

make_true_t = typing.TypeVar('make_true_t')

class make_true(typing.Generic[make_true_t]):
    def __init__(self, value: make_true_t) -> Any:
        self.value = value
    def __pos__(self) -> make_true_t:
        return self.value
    def __repr__(self) -> str:
        return repr(self.value)
    def __call__(self) -> make_true_t:
        return self.value

class token(tokenize.TokenInfo):
    def __init__(self, s: str, tokenizer: char_tokenizer, filename: str, pos: int, length: int) -> None:
        self.s = s
        self.tokenizer = tokenizer
        self.filename = filename
        self.pos = pos
        self.length = length
    @property
    def coord(self) -> Any:
        return self.tokenizer.get_coordinates(self.pos)
    def __pos__(self) -> str:
        return self.s
    def __repr__(self) -> str:
        # return f'\x1b[32m{self.s!r} at {self.filename}:{self.coord[0]}:{self.coord[1]}\x1b[0m'
        return f'{self.s!r} at {self.filename}:{self.coord[0]}:{self.coord[1]}'
        # return f'{self.s!r}'
    def __add__(self, t) -> Any:
        assert isinstance(t, token)
        return self(self.s + +t)
    def __call__(self, s: token | str | None = None) -> str | token:
        if s is None:
            return +self
        if isinstance(s, token):
            s=+s
        return token(
            s,
            self.tokenizer,
            self.filename,
            self.pos,
            self.length,
        )
    def error(self, msg: str) -> None:
        raise SyntaxError(msg, (
            os.path.realpath(self.filename),
            *self.coord,
            (self.tokenizer.text[self.tokenizer.index_of_prev_new_line[self.coord[0]-1]+1:]+'\n').split('\n',1)[0]
        ))


class state:
    def __init__(self, parser: char_parser) -> Any:
        self.parser = parser
    def append_str(self, s) -> Any:
        self.parser._str_level.append(s)
        return True
    def pop_str(self, s) -> Any:
        assert s == self.parser._str_level.pop()
        return True
    def str(self, s: str) -> Any:
        return all([
            (c.lower() in self.parser._str_level[-1]) ^ (c.isupper())
        for c in s])
    def append_indent(self, s) -> Any:
        self = self.parser
        self._indent_levels.append(None)
        self._update_indent()
        return True
    def pop_indent(self, s) -> Any:
        self = self.parser
        self._indent_levels.pop()
        self._update_indent()
        return True
    def if_in_brackets(self, s) -> Any:
        return self.parser._bracket_level
        
def memoize(method) -> Any:
    """Memoize a symbol method."""
    cache = {}

    def memoize_wrapper(self) -> Any:
        key = self._mark(), self._indent_num
        val = cache.get(key, None)
        if val:
            tree, endmark = val
            self._reset(endmark)
            return tree
        else:
            tree = method(self)
            endmark = self._mark()
            cache[key] = tree, endmark
        return tree

    return memoize_wrapper



re_compiler = functools.cache(re.compile)
class char_tokenizer(Tokenizer):
    def __init__(self, text: str, filename: str, verbose: bool) -> None:
        self.text = text
        self.filename = filename
        self.pos = 0
        self.max_pos = -1
        self.index_of_prev_new_line = [-1]
        if not verbose: # works faster but no max_pos
            self.reset = functools.partial(self.__dict__.__setitem__, 'pos')
            self.mark = functools.partial(self.__dict__.__getitem__, 'pos')
    def mark(self) -> int:
        return self.pos
    def reset(self, mark: int) -> None:
        self.pos = mark
        if self.pos > self.max_pos:
            self.max_pos = self.pos
    def get_coordinates(self, pos: int | None = None) -> tuple[int, int]:
        if pos is None:
            pos = self.pos
        line_num = bisect.bisect_right(self.index_of_prev_new_line, pos)-1
        pos_in_line = pos - self.index_of_prev_new_line[line_num]
        return line_num+1, pos_in_line
    def peek(self) -> tokenize.TokenInfo:
        buffer = self.text[self.pos:self.pos+64]
        line_num, pos_in_line = self.get_coordinates()
        return tokenize.TokenInfo(token_module.OP, buffer, (line_num, pos_in_line), (line_num, pos_in_line+64), repr(buffer))
    def diagnose(self) -> tokenize.TokenInfo:
        return self.peek()
    def expect(self, reg: str) -> Any:
        compiled_re = re_compiler(reg, re.S)
        match = compiled_re.match(self.text, self.pos)
        if match is None:
            return None
        length = match.regs[0][1] - match.regs[0][0]
        res = self.text[self.pos:self.pos+length]
        for q in range(self.pos, self.pos+length):
            if self.text[q]=='\n' and self.index_of_prev_new_line[-1] < q:
                    self.index_of_prev_new_line.append(q)
        self.pos += length
        return token(res, self, self.filename, self.pos-length, length)

indent_cache: dict[Any, Any] = {}


class char_parser(python_parser.GeneratedParser):
    @property
    def _cache(self) -> Any:
        return self._caches[self._indent_num]
    @_cache.setter
    def _cache(self, value: Any) -> Any:
        pass
    def __init__(self, tokenizer: Tokenizer, *, verbose: bool = False) -> None:
        super().__init__(tokenizer, verbose=verbose)
        self._indent_levels = ['']
        self._caches : dict[int, Any] = {}
        self._update_indent()
        self._state = state(self)
        self._str_level: list[None] = []
        self._bracket_level: list[None] = []
        self._func_level: list[None] = [0]
        self._loop_level: list[None] = [0]
        self._functools = functools
        self._make_true = make_true
        self._token = token
        self._args_level: list[None] = []
        self._stre_level: list[str] = []
        self._bin_op_to_ast = {
            '+': ast.Add,
            '-': ast.Sub,
            '*': ast.Mult,
            '/': ast.Div,
            '//': ast.FloorDiv,
            '%': ast.Mod,
            '<<': ast.LShift,
            '>>': ast.RShift,
            '^': ast.BitXor,
            '&': ast.BitAnd,
            '|': ast.BitOr,
            '**': ast.Pow,
            '<': ast.Lt,
            '<=': ast.LtE,
            '>': ast.Gt,
            '>=': ast.GtE,
            '==': ast.Eq,
            '!=': ast.NotEq,
            '@': ast.MatMult,
        }
        self._un_op_to_ast = {
            '+': ast.UAdd,
            '-': ast.USub,
            '~': ast.Invert,
        }
        self._ic = __import__('icecream').ic
    def expect(self, reg: str) -> Any:
        if '\0' in reg:
            reg = reg.split('\0', 1)
            return getattr(self._state, reg[0])(reg[1])
        return self._tokenizer.expect(reg)
    def _unicode_lookup(self, query) -> Any:
        try:
            return unicodedata.lookup(query)
        except KeyError:
            return None
    def _error(self) -> Any:
        raise TabError
    def _update_indent(self) -> Any:
        key = tuple(self._indent_levels)
        if key not in indent_cache:
            indent_cache[key] = len(indent_cache)
        self._indent_num = indent_cache[key]
        if self._indent_num not in self._caches:
            self._caches[self._indent_num] = {}
    def _join_str(self, tokens) -> Any:
        values1 = []
        has_joined_str=0
        for q in tokens:
            if isinstance(q, ast.JoinedStr):
                values1.extend(q.values)
                has_joined_str=1
            else:
                values1.append(q)
        assert all([isinstance(w, ast.Constant|ast.FormattedValue) for w in values1])
        values2 = []
        for q in values1:
            if isinstance(q, ast.Constant) and values2 and isinstance(values2[-1], ast.Constant):
                if {type(values2[-1].value), type(q.value)} == {bytes, str}:
                    return None
                values2[-1].value += q.value
            else:
                values2.append(q)
        for value in values2:
            if isinstance(value, ast.FormattedValue):
                if value.format_spec:
                    value.format_spec = self._join_str([value.format_spec])
        if len(values2) == 1 and isinstance(values2[0], ast.Constant) and not has_joined_str:
            return values2[0]
        else:
            return ast.JoinedStr(token=tokens[0].token, values=values2)

def create_ast(text: str, filename: str, verbose: bool = False) -> Any:
    rec_lim = sys.getrecursionlimit()
    sys.setrecursionlimit(2**30)
    try:
        for v in range(int(verbose), 2):
            tokenizer = char_tokenizer(text, filename, bool(v))
            parser = char_parser(tokenizer, verbose=verbose)
            if not verbose:
                for name in dir(parser):
                    value = parser.__getattribute__(name)
                    if callable(value) and hasattr(value, '__wrapped__') and callable(value.__wrapped__):
                        assert 'memoize_left_rec' not in repr(value)
                        wrapper = functools.partial(memoize(value.__wrapped__), parser)
                        setattr(parser, name, wrapper)
            try:
                tree = parser.start()
            except TabError:
                tree = None
            if tree:
                break
        else:
            tokenizer.reset(tokenizer.max_pos)
            tokenizer.expect('').error('invalid syntax')
        return tree
    finally:
        sys.setrecursionlimit(rec_lim)


def _ast_equal(ast1: ast.AST | list[ast.AST] | Any, ast2: ast.AST | list[ast.AST] | Any) -> bool:
    if isinstance(ast1, ast.AST) and isinstance(ast2, ast.AST):
        if type(ast1) != type(ast2):
            print(ast.dump(ast1, indent=4))
            print(ast.dump(ast2, indent=4))
            return False
        if ast1._fields != ast2._fields:
            print(ast.dump(ast1, indent=4))
            print(ast.dump(ast2, indent=4))
            return False
        for field in ast1._fields:
            if not ast_equal(getattr(ast1, field), getattr(ast2, field)):
                return False
        return True
    if isinstance(ast1, list) and isinstance(ast2, list):
        if len(ast1) != len(ast2):
            print(ast1)
            print(ast2)
            return False
        for item1, item2 in zip(ast1, ast2):
            if not ast_equal(item1, item2):
                return False
        return True
    if type(ast1) != type(ast2):
        print(ast1)
        print(ast2)
        return False
    else:
        if ast1 != ast2:
            print(ast1)
            print(ast2)
            return False
        return True

def ast_equal(ast1: ast.AST, ast2: ast.AST) -> bool:
    return _ast_equal(ast1, ast2)

def all_have_tokens(root) -> Any:
    return (
        (1 if isinstance(root.token, token) else print(root)) and all([
            all_have_tokens(getattr(root, field))
            for field in root._fields
        ])
        if isinstance(root, ast.AST) else
        all([
            all_have_tokens(field)
            for field in root
        ])
        if isinstance(root, list) else
            True
        if type(root) in [int, type(None), bool, str, bytes, type(...), float, complex] else
            print(root)
    )

if __name__ == '__main__':
    import main
    args = main.main()
    ast1 = create_ast(typing.cast(str, args.text), typing.cast(str, args.filename), typing.cast(bool, args.verbose))
    if args.verbose or not args.check:
        print(ast.dump(ast1, indent=4))
    if args.check:
        ast2 = ast.parse(args.text, args.filename)
        if args.verbose:
            print(ast.dump(ast2, indent=4))
        assert all_have_tokens(ast1)
        assert ast_equal(ast1, ast2)
