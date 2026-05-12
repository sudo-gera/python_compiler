#!/usr/bin/env bash
set -xeuo pipefail

cd "$(
    dirname "$(
        realpath "$0"
    )"
)"

python3 -m coverage run --include=create_ast.py,python_parser.py -m pytest test_all.py
python3 -m coverage html
python3 -m coverage report
if python3 -m pegen --help
then
    python3 -m pegen python.gram -qo python_parser_new.py
    diff python_parser_new.py python_parser.py
    rm python_parser_new.py
fi