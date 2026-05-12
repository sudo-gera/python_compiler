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

from create_ast import *

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
