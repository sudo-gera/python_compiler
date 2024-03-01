import ast
import sys
import io

level = 0

class indent_writer:
    def __init__(self, indent, file):
        self.indent = indent
        self.file = file
        self.is_first = [1]
    def __call__(self):
        if self.is_first and self.is_first.pop():
            self.file.write('' if self.indent is None else '\n' + self.indent * level)
        else:
            self.file.write(', ' if self.indent is None else ',\n' + self.indent * level)

def print_ast(root: ast.AST, indent=None, file=sys.stdout):
    global level
    level += 1
    try:
        if isinstance(indent, int):
            indent *= ' '
        if isinstance(root, ast.AST):
            file.write(f'{type(root).__name__}(')
            fields = [f for f in root._fields if getattr(root, f) is not None or getattr(type(root), f, ...) is not None]
            ind = indent_writer(indent, file)
            for f in fields:
                ind()
                file.write(f'{f}=')
                print_ast(getattr(root, f), indent, file)
            file.write(')')
        elif isinstance(root, list):
            file.write('[')
            ind = indent_writer(indent, file)
            for q in root:
                ind()
                print_ast(q, indent, file)
            file.write(']')
        else:
            file.write(repr(root))
    finally:
        level -= 1

def dump_ast(root: ast.AST, indent=None):
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



