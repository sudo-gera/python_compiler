import argparse

def main() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument('filename')
    parser.add_argument('--verbose', action='store_true')
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--indent')
    parser.add_argument('--output', '-o')
    args = parser.parse_args()
    filename = args.filename
    args.verbose = bool(args.verbose)
    args.check = bool(args.check)
    with open(filename) as file:
        args.text=file.read()
    return args

