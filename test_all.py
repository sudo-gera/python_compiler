import pytest
import os
import ast
import re
import time
from collections import defaultdict as dd
import itertools
import random

import create_ast
import dump_ast

import typing

def walk(path: str) -> typing.Generator[str, None, None]:
    for (dirpath, dirnames, filenames) in os.walk(path):
        for name in filenames:
            if name.endswith('.py'):
                yield os.path.join(dirpath, name)

walked_files = [*walk(
    os.path.dirname(os.path.realpath(__file__))
)]

if os.path.exists('last_failed.py'):
    walked_files = ['last_failed.py']

with open('test_seed.txt') as file:
    test_random = random.Random(file.read())

test_random.shuffle(walked_files)

@pytest.mark.parametrize('filepath', walked_files)
def test_ast(filepath):
    try:
        with open(filepath) as file:
            text = file.read()

        try:
            lib_ast = ast.parse(text, filepath)
            lib_dump = ast.dump(lib_ast)
            lib_dump4 = ast.dump(lib_ast, indent=4)
        except SyntaxError:
            lib_ast = None
            lib_dump = None
            lib_dump4 = None

        if lib_ast is not None and re.search(r'\bMatch\b', lib_dump):
            return

        try:
            app_ast = create_ast.create_ast(text, filepath)
            app_dump = dump_ast.dump_ast(app_ast)
            app_dump4 = dump_ast.dump_ast(app_ast, indent=4)
        except Exception:
            app_ast = None
            app_dump = None
            app_dump4 = None

        assert app_dump == lib_dump
        assert app_dump4 == lib_dump4
        assert create_ast.ast_equal(app_ast, lib_ast)
        assert create_ast.all_have_tokens(app_ast)

    except Exception:
        with open('last_failed.py', 'w') as wfile:
            wfile.write(text)
        raise

def test_actual_tests_were_used():
    assert walked_files != ['last_failed.py']
