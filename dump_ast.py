import ast
import sys
import io
import typing

class indent_writer:
    def __init__(self, indent: str | None, file: typing.IO[str], level: int) -> None:
        self.indent = indent
        self.file = file
        self.is_first = [1]
        self.level = level
    def __call__(self) -> None:
        if self.is_first and self.is_first.pop():

            self.file.write('' if self.indent is None else '\n' + self.indent * self.level)
        else:
            self.file.write(', ' if self.indent is None else ',\n' + self.indent * self.level)

def print_ast(root: ast.AST, indent: str | int | None = None, file: typing.IO[str] = sys.stdout, level: int = -1) -> None:
    level += 1
    if isinstance(indent, int):
        indent *= ' '
    if isinstance(root, ast.AST):
        file.write(f'{type(root).__name__}(')
        fields = [f for f in root._fields if getattr(root, f) is not None or getattr(type(root), f, ...) is not None]
        ind = indent_writer(indent, file, level)
        for f in fields:
            ind()
            file.write(f'{f}=')
            print_ast(getattr(root, f), indent, file, level)
        file.write(')')
    elif isinstance(root, list):
        file.write('[')
        ind = indent_writer(indent, file, level)
        for q in root:
            ind()
            print_ast(q, indent, file, level)
        file.write(']')
    else:
        file.write(repr(root))

def dump_ast(root: ast.AST, indent: str | int | None = None) -> str:
    file = io.StringIO()
    print_ast(root, indent, file)
    return file.getvalue()    

if __name__ == '__main__':
    import main
    args = main.main()
    import create_ast
    root = create_ast.create_ast(args.text, args.filename, args.verbose)
    d1 = dump_ast(root, indent=args.indent)
    if args.verbose or not args.check:
        print(d1)
    if args.check:
        d2 = ast.dump(root)
        if args.verbose:
            print(d2)
        assert d1 == d2



