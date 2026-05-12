#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]
then
    printf "usage:\n\t%q path_or_name_of_python_executable\n" "$0"
    exit 1
fi

set -x

py="$(
    realpath -- "$(
        which -- "$1"
    )"
)"

cd "$(
    dirname -- "$(
        realpath -- "$0"
    )"
)"

"${py}" -m venv ./venv
rm ./venv/bin/python
rm ./venv/bin/python3
ln -s "${py}" ./venv/bin/python
ln -s "${py}" ./venv/bin/python3

./venv/bin/python3 -m pip install pytest coverage pytest-xdist icecream

pegen_py="$(mktemp --suffix .py)"
trap 'rm -- "${pegen_py}"' EXIT

python3 -m pegen python.gram -qo "${pegen_py}"
diff "${pegen_py}" python_parser.py # returns 0 only if equal

echo "${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}" > ./test_seed.txt
./venv/bin/python3 -m pytest -n auto ./test_all.py

