import pytest
import os
import ast
import re
import time

import create_ast

def walk(path: str):
    for (dirpath, dirnames, filenames) in os.walk(path):
        for name in filenames:
            if name.endswith('.py'):
                yield os.path.join(dirpath, name)



tty = open('/dev/tty','w')

@pytest.mark.parametrize('filepath', walk(os.path.dirname(os.path.realpath(__file__))))
def test_ast(filepath):
    t = time.monotonic()
    with open(filepath) as file:
        text = file.read()
    ast2 = ast.parse(text, filepath)
    if re.search(r'\bMatch\b', ast.dump(ast2)):
        return
    try:
        ast1 = create_ast.create_ast(text, filepath)
    except Exception:
        ast1 = None
    t = time.monotonic() - t
    result = create_ast.ast_equal(ast1, ast2) and create_ast.all_have_tokens(ast1)
    if not result:
        print(filepath, file=tty)
        tty.flush()
    assert result

