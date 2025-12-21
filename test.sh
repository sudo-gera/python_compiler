#!/usr/bin/env bash
set -xeuo pipefail

cd "$(
    dirname "$(
        realpath "$0"
    )"
)"

coverage run --include=create_ast.py,python_parser.py -m pytest test_all.py
coverage html
coverage report
python3 -m pegen python.gram -qo python_parser_new.py
diff python_parser_new.py python_parser.py
rm python_parser_new.py
