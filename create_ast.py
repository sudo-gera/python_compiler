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

import python_parser

sys.setrecursionlimit(2**30)

class make_true:
    def __init__(self, value):
        self.value = value
    def __pos__(self):
        return self.value
    def __repr__(self) -> str:
        return repr(self.value)

class token:
    def __init__(self, s, coord, filename, pos, length):
        self.s = s
        self.coord = coord
        self.filename = filename
        self.pos = pos
        self.length = length
    def __pos__(self):
        return self.s
    def __repr__(self):
        # return f'\x1b[32m{self.s!r} at {self.filename}:{self.coord[0]}:{self.coord[1]}\x1b[0m'
        return f'{self.s!r} at {self.filename}:{self.coord[0]}:{self.coord[1]}'
        # return f'{self.s!r}'
    def __add__(self, t):
        assert isinstance(t, token)
        return self(self.s + +t)
    def __call__(self, s=None):
        if s is None:
            return +self
        if isinstance(s, token):
            s=+s
        return token(
            s,
            self.coord,
            self.filename,
            self.pos,
            self.length,
        )

re_cache={}
class char_tokenizer:
    def __init__(self, text, filename):
        self.text = text
        self.filename = filename
        self.pos = 0
        self.max_pos = 0
        self.index_of_prev_new_line = [-1]
    def mark(self):
        return self.pos
    def reset(self, mark):
        self.pos = mark
        if self.pos > self.max_pos:
            self.max_pos = self.pos
    def get_coordinates(self):
        line_num = bisect.bisect_right(self.index_of_prev_new_line, self.pos)-1
        pos_in_line = self.pos - self.index_of_prev_new_line[line_num]
        return line_num+1, pos_in_line
    def peek(self):
        buffer = self.text[self.pos:self.pos+64]
        line_num, pos_in_line = self.get_coordinates()
        return tokenize.TokenInfo(token_module.OP, buffer, (line_num, pos_in_line), (line_num, pos_in_line+64), repr(buffer))
    def diagnose(self):
        return self.peek()
    def expect(self, reg: str):
        tmp = re_cache.get(reg, None)
        if tmp is None:
            tmp = re.compile(reg, re.S)
            re_cache[reg] = tmp
        buffer = self.text
        match = tmp.match(buffer, self.pos)
        if match is None:
            return None
        length = match.regs[0][1] - match.regs[0][0]
        res = self.text[self.pos:self.pos+length]
        for q,w in enumerate(res):
            if w=='\n':
                if bisect.bisect_left(self.index_of_prev_new_line, self.pos + q)\
                == bisect.bisect_right(self.index_of_prev_new_line, self.pos + q):
                    self.index_of_prev_new_line.append(self.pos + q)
                    # self.line_starts_set.add(self.pos + q)
                    # assert self.line_starts_list == sorted(self.line_starts_list)
        coord = self.get_coordinates()
        self.pos += length
        return token(res, coord, self.filename, self.pos-length, length)

indent_cache = {}

class char_parser(python_parser.GeneratedParser):
    @property
    def _cache(self):
        return self._caches[self._indent_num]
    @_cache.setter
    def _cache(self, value):
        pass
    def __init__(self, *a, **s):
        super().__init__(*a, **s)
        self._indent_levels = ['']
        self._caches = {}
        self._update_indent()
        self._bracket_level = []
        self._func_level = [0]
        self._loop_level = [0]
        self._ctx = ast.Load()
        self._functools = functools
        self._make_true = make_true
        self._token = token
        self._args_level = []
        self._stre_level = []
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
    # @pegen.parser.memoize
    def expect(self, type: str):
        return self._tokenizer.expect(type)
    def _unicode_lookup(self, query):
        try:
            return unicodedata.lookup(query)
        except KeyError:
            return None
    def start_indent(self) -> Any | None:
        return super().start_indent.__wrapped__(self)
    def stop_indent(self) -> Any | None:
        return super().stop_indent.__wrapped__(self)
    def _error(self):
        raise TabError
    def _update_indent(self):
        key = tuple(self._indent_levels)
        if key not in indent_cache:
            indent_cache[key] = len(indent_cache)
        self._indent_num = indent_cache[key]
        if self._indent_num not in self._caches:
            self._caches[self._indent_num] = {}
    def _join_str(self, tokens):
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




def create_ast(text, filename, verbose=0):
    tokenizer = char_tokenizer(text, filename)
    parser = char_parser(tokenizer, verbose=verbose)
    try:
        tree = parser.start()
    except TabError:
        tree = None

    if not tree:
        tokenizer.reset(tokenizer.max_pos)
        coord = tokenizer.get_coordinates()
        raise SyntaxError('invalid syntax', (
            os.path.realpath(filename),
            *coord,
            (text[tokenizer.index_of_prev_new_line[coord[0]-1]+1:]+'\n').split('\n',1)[0]
        ))
    return tree

def ast_equal(ast1, ast2):
    return (
        type(ast1) == type(ast2)
            and
        (
            (
                ast1._fields == ast2._fields
                    and
                all([
                    ast_equal(getattr(ast1, field), getattr(ast2, field))
                    for field in ast1._fields
                ])
            ) if isinstance(ast1, ast.AST) else (
                len(ast1) == len(ast2)
                    and
                all([
                    ast_equal(item1, item2)
                    for item1, item2 in zip(ast1, ast2)
                ])
            ) if isinstance(ast1, list) else (
                ast1 == ast2
            )
        )
    )

def all_have_tokens(root):
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
    parser = argparse.ArgumentParser()
    parser.add_argument('filename')
    parser.add_argument('--verbose', action='store_true')
    args = parser.parse_args()
    filename = args.filename
    verbose = bool(args.verbose)
    with open(filename) as file:
        text=file.read()
    ast2 = ast.parse(text, filename)
    if re.search(r'\bMatch\b', ast.dump(ast2)):
        exit()
    if verbose:
        print(ast.dump(ast2, indent=4))
    ast1 = create_ast(text, filename, verbose)
    if verbose:
        print(ast.dump(ast1, indent=4))
    assert all_have_tokens(ast1)
    assert ast_equal(ast1, ast2)
