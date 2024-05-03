# compiler for python3.12

### requirements:
#### for running:
* python3 >= 3.10
#### for generating parser from grammar:
* python3 >= 3.10
* pegen
    ```
    python3 -m pip install pegen
    ```
#### for running tests:
* pytest
* coverage
    ```
    python3 -m pip install pytest coverage
    ```

### run ready-to-use ast-builder (will be printed using built-in python dump function):
1. Open text editor.
2. Put this example of lolcode:
    ```
    print('hello world')
    ```
3. Save it, for example, as `example.py`
4. Run with this command:
    ```
    python3 create_ast.py example.py
    ```
5. Happy coding!

### generate parser from the grammar:
1. run this command:
    ```
    python3 -m pegen python.gram -qo python_parser.py
    ```
### run tests:
    ```
    python -m pytest ./test_ast.py
    ```

### get coverage:
    ```
    coverage run --include=create_ast.py,python_parser.py -m pytest test_ast.py
    coverage html
    ```
