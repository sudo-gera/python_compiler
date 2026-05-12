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

# walked_files = ['test.py']

random.Random(time.time_ns() // 10**9 // 8).shuffle(walked_files)

files: dict[str, dict[typing.Any, typing.Any]] = dict(
    [
        *zip(
            walked_files,
            map(
                dict,
                itertools.repeat({})
            )
        )
    ][:10]
)

@pytest.mark.parametrize('filepath', files)
def test_ast(filepath):
    try:
        with open(filepath) as file:
            text = file.read()
        try:
            ast2 = ast.parse(text, filepath)
        except SyntaxError:
            ast2 = None
        if ast2 is not None and re.search(r'\bMatch\b', ast.dump(ast2)):
            return
        try:
            ast1 = create_ast.create_ast(text, filepath)
        except Exception:
            ast1 = None
        files[filepath]['ast'] = ast1
        assert create_ast.ast_equal(ast1, ast2) and create_ast.all_have_tokens(ast1)
    except Exception:
        with open(filepath) as rfile:
            data = rfile.read()
        with open('test.py', 'w') as wfile:
            wfile.write(data)

@pytest.mark.parametrize('filepath', files)
def test_dump(filepath):
    if 'ast' in files[filepath]:
        tree = files[filepath]['ast']
        assert dump_ast.dump_ast(tree) == ast.dump(tree)
