import pytest
import os
import ast
import re
import time
from collections import defaultdict as dd
import itertools

import create_ast
import dump_ast

def walk(path: str):
    for (dirpath, dirnames, filenames) in os.walk(path):
        for name in filenames:
            if name.endswith('.py'):
                yield os.path.join(dirpath, name)


files = dict([*zip(walk(os.path.dirname(os.path.realpath(__file__))), map(dict, itertools.repeat({})))][:])

@pytest.mark.parametrize('filepath', files)
def test_ast(filepath):
    with open(filepath) as file:
        text = file.read()
    ast2 = ast.parse(text, filepath)
    if re.search(r'\bMatch\b', ast.dump(ast2)):
        return
    try:
        ast1 = create_ast.create_ast(text, filepath)
    except Exception:
        ast1 = None
    files[filepath]['ast'] = ast1
    assert create_ast.ast_equal(ast1, ast2) and create_ast.all_have_tokens(ast1)

@pytest.mark.parametrize('filepath', files)
def test_dump(filepath):
    if 'ast' in files[filepath]:
        tree = files[filepath]['ast']
        assert dump_ast.dump_ast(tree) == ast.dump(tree)
