from __future__ import annotations
import ast
import typing
from dataclasses import dataclass
from abc import ABC, abstractmethod
from pprint import pprint
import functools
import itertools
import operator
import re

def wrap_name(name: str, prefix: str) -> str:
    if name.startswith('_'):
        return prefix + name
    return name

####################################################################################################

attribute_traversal_copy_t = typing.TypeVar('attribute_traversal_copy_t')

def attribute_traversal_copy(obj: attribute_traversal_copy_t, func: typing.Callable[[attribute_traversal_copy_t], attribute_traversal_copy_t], abc: type[typing.Any]) -> attribute_traversal_copy_t:
    # print(type(obj), func, abc, [(name, isinstance(attr, abc)) for name, attr in vars(obj).items()])
    def attr_traversal(attr: typing.Any) -> typing.Any:
        if isinstance(attr, abc):
            return func(attr)
        if isinstance(attr, list):
            return [
                attr_traversal(el)
                for el in attr
            ]
        if isinstance(attr, tuple):
            return tuple(attr_traversal(list(attr)))
        if isinstance(attr, set):
            return set(attr_traversal(list(attr)))
        return attr
        
    return type(obj)(
        **{
            name: attr_traversal(attr)
            for name, attr in [*vars(obj).items()]
        }
    )

####################################################################################################

class GrammarRule(ABC):

    @abstractmethod
    def to_grammar(self) -> str:
        ...

    @abstractmethod
    def _get_all_created_variables(self) -> list[str]:
        ...

    def _remove_separated_sequences(self, rules: Rules) -> GrammarRule:
        def remove_separated_sequences(obj: GrammarRule) -> GrammarRule:
            return obj._remove_separated_sequences(rules)
        return attribute_traversal_copy(self, remove_separated_sequences, GrammarRule)

    def _remove_embed_loops(self, rules: Rules) -> GrammarRule:
        def embed_loops(obj: GrammarRule) -> GrammarRule:
            return obj._remove_embed_loops(rules)
        return attribute_traversal_copy(self, embed_loops, GrammarRule)

    def _wrap_names(self, rules: Rules) -> GrammarRule:
        def wrap_names(obj: GrammarRule) -> GrammarRule:
            return obj._wrap_names(rules)
        return attribute_traversal_copy(self, wrap_names, GrammarRule)

class MultiLineRulePart(GrammarRule):

    def _remove_separated_sequences(self, rules: Rules) -> MultiLineRulePart:
        def _remove_separated_requences(obj: MultiLineRulePart) -> MultiLineRulePart:
            return obj._remove_separated_sequences(rules)
        return attribute_traversal_copy(self, _remove_separated_requences, MultiLineRulePart)

    def _remove_vars(self, rules: Rules) -> MultiLineRulePart:
        def _remove_vars(obj: MultiLineRulePart) -> MultiLineRulePart:
            return obj._remove_vars(rules)
        return attribute_traversal_copy(self, _remove_vars, MultiLineRulePart)

    def _remove_embed_loops(self, rules: Rules) -> MultiLineRulePart:
        def embed_loops(obj: MultiLineRulePart) -> MultiLineRulePart:
            return obj._remove_embed_loops(rules)
        return attribute_traversal_copy(self, embed_loops, MultiLineRulePart)

    def _wrap_names(self, rules: Rules) -> MultiLineRulePart:
        def wrap_names(obj: MultiLineRulePart) -> MultiLineRulePart:
            return obj._wrap_names(rules)
        return attribute_traversal_copy(self, wrap_names, MultiLineRulePart)

class SingleLineRulePart(MultiLineRulePart):

    def _remove_separated_sequences(self, rules: Rules) -> SingleLineRulePart:
        def _remove_separated_requences(obj: SingleLineRulePart) -> SingleLineRulePart:
            return obj._remove_separated_sequences(rules)
        return attribute_traversal_copy(self, _remove_separated_requences, SingleLineRulePart)

    def _remove_vars(self, rules: Rules) -> SingleLineRulePart:
        def remove_vars(obj: SingleLineRulePart) -> SingleLineRulePart:
            return obj._remove_vars(rules)
        return attribute_traversal_copy(self, remove_vars, SingleLineRulePart)

    def _remove_embed_loops(self, rules: Rules) -> SingleLineRulePart:
        def embed_loops(obj: SingleLineRulePart) -> SingleLineRulePart:
            return obj._remove_embed_loops(rules)
        return attribute_traversal_copy(self, embed_loops, SingleLineRulePart)

    def _wrap_names(self, rules: Rules) -> SingleLineRulePart:
        def wrap_names(obj: SingleLineRulePart) -> SingleLineRulePart:
            return obj._wrap_names(rules)
        return attribute_traversal_copy(self, wrap_names, SingleLineRulePart)

####################################################################################################

@dataclass(frozen=True)
class CallRule(SingleLineRulePart):
    rule_name: str

    def _wrap_names(self, rules: Rules) -> SingleLineRulePart:
        return CallRule(
            rule_name=wrap_name(self.rule_name, rules.unique_prefix),
        )

    def to_grammar(self) -> str:
        return self.rule_name

    def _get_all_created_variables(self) -> list[str]:
        return list()

    def _remove_embed_loops(self, rules: Rules) -> SingleLineRulePart:
        if re.fullmatch(r'^_loop0_.*', self.rule_name):
            called = rules.rules_dict[self.rule_name].rule
            if isinstance(called, SingleLineRulePart):
                return called._remove_vars(rules)
        return self

@dataclass(frozen=True)
class Expect(SingleLineRulePart):
    pattern: str

    def to_grammar(self) -> str:
        return f"{self.pattern!r}"

    def _get_all_created_variables(self) -> list[str]:
        return list()

####################################################################################################

@dataclass(frozen=True)
class FalseIsOk(SingleLineRulePart):
    rule: SingleLineRulePart

    def to_grammar(self) -> str:
        return f"({self.rule.to_grammar()})?"

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables()

    def _remove_embed_loops(self, rules: Rules) -> SingleLineRulePart:
        if isinstance(self.rule, VariableCreator):
            if (True
                and isinstance(self.rule.rule, CallRule)
                and re.fullmatch(r'^_loop0_.*', self.rule.rule.rule_name)
            ):
                return self.rule._remove_embed_loops(rules)
            else:
                return VariableCreator(
                    rule=FalseIsOk(
                        rule=self.rule.rule,
                    ),
                    var_name=self.rule.var_name,
                )
        return FalseIsOk(
            rule=self.rule._remove_embed_loops(rules),
        )

@dataclass(frozen=True)
class VariableCreator(SingleLineRulePart):
    rule: SingleLineRulePart
    var_name: str

    def to_grammar(self) -> str:
        if isinstance(self.rule, CallRule | Expect | FalseIsOk | Star):
            return f"{self.var_name}={self.rule.to_grammar()}"
        return f"{self.var_name}=({self.rule.to_grammar()})"

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables() + [self.var_name]

    def _remove_vars(self, rules: Rules) -> SingleLineRulePart:
        return self.rule._remove_vars(rules)

    def _remove_embed_loops(self, rules: Rules) -> SingleLineRulePart:
        return VariableCreator(
            rule=self.rule._remove_embed_loops(rules),
            var_name=self.var_name,
        )

    def _wrap_names(self, rules: Rules) -> SingleLineRulePart:
        return VariableCreator(
            rule=self.rule._wrap_names(rules),
            var_name=wrap_name(self.var_name, rules.unique_prefix),
        )

@dataclass(frozen=True)
class SeparatedSequence(SingleLineRulePart):
    rule: SingleLineRulePart
    separator: SingleLineRulePart

    def to_grammar(self) -> str:
        return f"({self.separator.to_grammar()}).({self.rule.to_grammar()})+"

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables() + self.separator._get_all_created_variables()

@dataclass(frozen=True)
class MatchIfNotNone(SingleLineRulePart):
    rule: SingleLineRulePart

    def to_grammar(self) -> str:
        assert False

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables()

@dataclass(frozen=True)
class Star(SingleLineRulePart):
    rule: SingleLineRulePart

    def to_grammar(self) -> str:
        return f"({self.rule.to_grammar()})*"

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables()

@dataclass(frozen=True)
class PosLookAhead(SingleLineRulePart):
    rule: SingleLineRulePart

    def to_grammar(self) -> str:
        return f"&({self.rule.to_grammar()})"

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables()

@dataclass(frozen=True)
class NegLookAhead(SingleLineRulePart):
    rule: SingleLineRulePart

    def to_grammar(self) -> str:
        return f"!({self.rule.to_grammar()})"

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables()

####################################################################################################

@dataclass(frozen=True)
class Concat(SingleLineRulePart):
    rules: tuple[SingleLineRulePart, ...]
    handler: ast.AST | None

    def to_grammar(self) -> str:
        result = ' '.join(
            [
                rule.to_grammar()
                for rule in self.rules
            ]
        )
        if self.handler is not None:
            result += f" {{ {ast.unparse(self.handler)} }}"
        return result

    def __handle_separated_seq(self, rules: Rules) -> SingleLineRulePart | None:
        if (True
            and  isinstance(self.handler, ast.BinOp)
            and  isinstance(self.handler.left, ast.List)
            and  isinstance(self.handler.left.ctx, ast.Load)
            and         len(self.handler.left.elts) == 1
            and  isinstance(self.handler.left.elts[0], ast.Name)
            and  isinstance(self.handler.left.elts[0].ctx, ast.Load)
            and  isinstance(self.handler.op, ast.Add)
            and  isinstance(self.handler.right, ast.Name)
            and  isinstance(self.handler.right.ctx, ast.Load)
            and         len(self.rules) == 2
        ):
            self_rules_0 = self.rules[0]
            self_rules_1 = self.rules[1]
            if (True
                and  isinstance(self_rules_0, MatchIfNotNone)
                and  isinstance(self_rules_0.rule, VariableCreator)
                and  self_rules_0.rule.var_name == self.handler.left.elts[0].id
                and  isinstance(self_rules_0.rule.rule, CallRule)
                and  isinstance(self_rules_1, MatchIfNotNone)
                and  isinstance(self_rules_1.rule, VariableCreator)
                and  self_rules_1.rule.var_name == self.handler.right.id
                and  isinstance(self_rules_1.rule.rule, CallRule)
                and  self_rules_1.rule.rule.rule_name in rules.rules_dict
            ):
                loop = rules.rules_dict[self_rules_1.rule.rule.rule_name]
                if (True
                    and  isinstance(loop, Rule)
                    and  isinstance(loop.rule, Star)
                    and  isinstance(loop.rule.rule, Concat)
                    and             loop.rule.rule.handler is None
                    and         len(loop.rule.rule.rules) == 2
                ):
                    loop_rule_rule_rules_0 = loop.rule.rule.rules[0]
                    loop_rule_rule_rules_1 = loop.rule.rule.rules[1]
                    if (True
                        and  isinstance(loop_rule_rule_rules_0, CallRule)
                        and  isinstance(loop_rule_rule_rules_1, VariableCreator)
                        and  isinstance(loop_rule_rule_rules_1.rule, CallRule)
                        and  loop_rule_rule_rules_1.rule.rule_name == self_rules_0.rule.rule.rule_name
                    ):
                        return SeparatedSequence(
                            rule=loop_rule_rule_rules_1.rule,
                            separator=loop_rule_rule_rules_0,
                        )
        return None

    def _remove_separated_sequences(self, rules: Rules) -> SingleLineRulePart:
        sep_result = self.__handle_separated_seq(rules)
        if sep_result is not None:
            return sep_result._remove_separated_sequences(rules)
        return Concat(
            rules=tuple(
                [
                    rule._remove_separated_sequences(rules) for rule in self.rules
                ]
            ),
            handler=self.handler,
        )

    def _get_all_created_variables(self) -> list[str]:
        return functools.reduce(
            operator.add,
            [
                rule._get_all_created_variables()
                for rule in self.rules
            ]
        )

    def _wrap_names(self, rules: Rules) -> SingleLineRulePart:
        old_names = self._get_all_created_variables()
        tmp = Concat(
            rules=tuple(
                [
                    rule._wrap_names(rules) for rule in self.rules
                ]
            ),
            handler=self.handler,
        )
        new_names = tmp._get_all_created_variables()
        return Concat(
            rules=tmp.rules,
            handler=None if self.handler is None else ast.Call(
                func=ast.Lambda(
                    args=ast.arguments(
                        posonlyargs=[],
                        args=[
                            ast.arg(arg=name)
                            for name in old_names
                        ],
                        vararg=None,
                        kwonlyargs=[],
                        kw_defaults=[],
                        kwarg=None,
                        defaults=[],
                    ),
                    body=self.handler,
                ),
                args=[
                    ast.Name(
                        id=name,
                        ctx=ast.Load(),
                    )
                    for name in new_names
                ],
                keywords=[],
            ),
        )

@dataclass(frozen=True)
class Alternatives(MultiLineRulePart):
    rules: tuple[SingleLineRulePart, ...]

    def to_grammar(self) -> str:
        result = ''.join(
            [
                '\n    | ' + rule.to_grammar()
                for rule in self.rules
            ]
        )
        return result

    def _get_all_created_variables(self) -> list[str]:
        return functools.reduce(
            operator.add,
            [
                rule._get_all_created_variables()
                for rule in self.rules
            ]
        )

####################################################################################################

@dataclass(frozen=True)
class Rule(GrammarRule):
    rule: MultiLineRulePart
    rule_name: str

    def to_grammar(self) -> str:
        return f"{self.rule_name}: {self.rule.to_grammar()}" + '\n\n'

    def _wrap_names(self, rules: Rules) -> Rule:
        return Rule(
            rule=self.rule._wrap_names(rules),
            rule_name=wrap_name(self.rule_name, rules.unique_prefix),
        )

    def _get_all_created_variables(self) -> list[str]:
        return self.rule._get_all_created_variables()

@dataclass(frozen=True)
class Rules(GrammarRule):
    rules: tuple[Rule, ...]

    @functools.cached_property
    def rules_dict(self) -> dict[str, Rule]:
        return dict(
            [
                (rule.rule_name, rule)
                for rule in self.rules
            ]
        )

    def to_grammar(self) -> str:
        result = ''.join(
            [
                rule.to_grammar()
                for rule in self.rules
            ]
        )
        return result
    
    def simplify(self) -> Rules:
        self = typing.cast(Rules, self._remove_separated_sequences(self))
        self = typing.cast(Rules, self._remove_embed_loops(self))
        assert '=_gather_1 ' in self.to_grammar()
        self = typing.cast(Rules, self._wrap_names(self))
        assert '=_gather_1 ' not in self.to_grammar()
        return self

    def _get_all_created_variables(self) -> list[str]:
        return functools.reduce(
            operator.add,
            [
                rule._get_all_created_variables()
                for rule in self.rules
            ]
        )

    @functools.cached_property
    def unique_prefix(self) -> str:
        names = list(self.rules_dict)
        for n in itertools.count(0):
            prefix = f'auto_generated_{n}_'
            if not any([
                name.startswith(prefix)
                for name in names
            ]):
                return prefix
        assert False

@dataclass(frozen=True)
class File:
    subheader: ast.Module
    rules: Rules

    def simplify(self) -> File:
        return File(
            subheader=self.subheader,
            rules=self.rules.simplify(),
        )

    def to_grammar(self) -> str:
        result = '@subheader '
        result += repr(
            ast.unparse(self.subheader)
        )
        result += '\n\n'
        result += self.rules.to_grammar()
        return result

####################################################################################################

def mark_self_mark(root: ast.AST) -> bool:

    return isinstance(root, ast.Assign) \
        and root.type_comment is None \
        and len(root.targets) == 1 \
        and isinstance(root.targets[0], ast.Name) \
        and isinstance(root.targets[0].ctx, ast.Store) \
        and root.targets[0].id == 'mark' \
        and isinstance(root.value, ast.Call) \
        and len(root.value.keywords) == 0 \
        and len(root.value.args) == 0 \
        and isinstance(root.value.func, ast.Attribute) \
        and isinstance(root.value.func.ctx, ast.Load) \
        and isinstance(root.value.func.attr, str) \
        and root.value.func.attr == '_mark' \
        and isinstance(root.value.func.value, ast.Name) \
        and root.value.func.value.id == 'self'

def children_empty(root: ast.AST) -> bool:

    return isinstance(root, ast.Assign) \
        and root.type_comment is None \
        and len(root.targets) == 1 \
        and isinstance(root.targets[0], ast.Name) \
        and isinstance(root.targets[0].ctx, ast.Store) \
        and root.targets[0].id == 'children' \
        and isinstance(root.value, ast.List) \
        and isinstance(root.value.ctx, ast.Load) \
        and len(root.value.elts) == 0

def self_reset_mark(root: ast.AST) -> bool:

    return isinstance(root, ast.Expr) \
        and isinstance(root.value, ast.Call) \
        and len(root.value.keywords) == 0 \
        and len(root.value.args) == 1 \
        and isinstance(root.value.args[0], ast.Name) \
        and root.value.args[0].id == 'mark' \
        and isinstance(root.value.func, ast.Attribute) \
        and isinstance(root.value.func, ast.Attribute) \
        and isinstance(root.value.func.ctx, ast.Load) \
        and root.value.func.attr == '_reset' \
        and isinstance(root.value.func.value, ast.Name) \
        and root.value.func.value.id == 'self' \

def return_none(root: ast.AST) -> bool:
    return  isinstance(root, ast.Return) \
        and isinstance(root.value, ast.Constant) \
        and root.value.kind is None \
        and root.value.value is None \

def return_children(root: ast.AST) -> bool:
    return  isinstance(root, ast.Return) \
        and isinstance(root.value, ast.Name) \
        and isinstance(root.value.ctx, ast.Load) \
        and root.value.id == 'children' \

def if_to_return(root: ast.AST) -> bool:
    return  isinstance(root, ast.If) \
        and len(root.body) == 1 \
        and isinstance(root.body[0], ast.Return)

def while_to_append_and_mark(root: ast.AST) -> bool:
    assert isinstance(root, ast.While)
    assert isinstance(root.test, ast.BoolOp | ast.NamedExpr | ast.Call)
    if         isinstance(root.test, ast.Call):
        assert        len(root.test.keywords) == 0
        assert        len(root.test.args) == 2
        assert isinstance(root.test.args[0], ast.Attribute)
        assert isinstance(root.test.args[0].ctx, ast.Load)
        assert root.test.args[0].attr == 'expect'
        assert isinstance(root.test.args[0].value, ast.Name)
        assert isinstance(root.test.func, ast.Attribute)
        assert isinstance(root.test.args[0].value.ctx, ast.Load)
        assert root.test.args[0].value.id == 'self'
        assert isinstance(root.test.args[1], ast.Constant)
        assert isinstance(root.test.func, ast.Attribute)
        assert isinstance(root.test.func.ctx, ast.Load)
        assert root.test.func.attr == 'negative_lookahead'
        assert isinstance(root.test.func.value, ast.Name)
        named_expr = None
    elif       isinstance(root.test, ast.BoolOp):
        assert isinstance(root.test.op, ast.And)
        assert        len(root.test.values) == 2
        assert isinstance(root.test.values[0], ast.Call)
        assert        len(root.test.values[0].keywords) == 0
        assert        len(root.test.values[0].args) == 0
        assert isinstance(root.test.values[0].func, ast.Attribute)
        assert isinstance(root.test.values[0].func.ctx, ast.Load)
        assert isinstance(root.test.values[0].func.value, ast.Name)
        assert root.test.values[0].func.value.id == 'self'
        assert isinstance(root.test.values[1], ast.NamedExpr)
        named_expr = root.test.values[1]
    elif       isinstance(root.test, ast.NamedExpr):
        assert isinstance(root.test, ast.NamedExpr)
        named_expr = root.test
    assert     isinstance(named_expr, ast.NamedExpr | None)
    if named_expr is not None:
        assert isinstance(named_expr.value, ast.Call)
        assert        len(named_expr.value.keywords) == 0
        assert        len(named_expr.value.args) == 0
        assert isinstance(named_expr.value.func, ast.Attribute)
        assert isinstance(named_expr.value.func.ctx, ast.Load)

    assert        len(root.orelse) == 0
    assert        len(root.body) == 2
    assert isinstance(root.body[0], ast.Expr)
    assert isinstance(root.body[0].value, ast.Call)
    assert        len(root.body[0].value.keywords) == 0
    assert        len(root.body[0].value.args) == 1
    if named_expr is not None:
        assert isinstance(root.body[0].value.args[0], ast.Name)
        assert named_expr.target.id == root.body[0].value.args[0].id
    else:
        assert isinstance(root.body[0].value.args[0], ast.List)
        assert isinstance(root.body[0].value.args[0].ctx, ast.Load)
        assert        len(root.body[0].value.args[0].elts) == 0
    assert isinstance(root.body[0].value.func, ast.Attribute)
    assert isinstance(root.body[0].value.func.ctx, ast.Load)
    assert root.body[0].value.func.attr == 'append'
    assert isinstance(root.body[0].value.func.value, ast.Name)
    assert isinstance(root.body[0].value.func.value.ctx, ast.Load)
    assert root.body[0].value.func.value.id == 'children'
    assert mark_self_mark(root.body[1])
    return True

####################################################################################################

def handle_one_value(value: ast.AST) -> SingleLineRulePart:

    assert isinstance(value, ast.Call | ast.NamedExpr | ast.Tuple | ast.Compare)

    created_var : str | None = None

    if isinstance(value, ast.Tuple):
        assert isinstance(value.ctx, ast.Load)
        assert        len(value.elts) == 1
        assert isinstance(value.elts[0], ast.Call | ast.NamedExpr | ast.Compare)
        value = value.elts[0]
        assert isinstance(value, ast.Call | ast.NamedExpr | ast.Compare)
        return FalseIsOk(
            rule=handle_one_value(value)
        )

    if isinstance(value, ast.Compare):
        assert isinstance(value.left, ast.NamedExpr)
        assert        len(value.ops) == 1
        assert isinstance(value.ops[0], ast.IsNot)
        assert        len(value.comparators) == 1
        assert isinstance(value.comparators[0], ast.Constant)
        assert value.comparators[0].kind is None
        assert value.comparators[0].value is None
        value = value.left
        assert isinstance(value, ast.NamedExpr)
        return MatchIfNotNone(
            rule=handle_one_value(value)
        )

    if isinstance(value, ast.NamedExpr):
        assert isinstance(value.target, ast.Name)
        assert isinstance(value.target.ctx, ast.Store)
        assert isinstance(value.target.id, str)
        created_var = value.target.id
        assert isinstance(value.value, ast.Call | ast.Compare)
        value = value.value
        return VariableCreator(
            rule=handle_one_value(value),
            var_name=created_var,
        )

    if isinstance(value, ast.Call):
        assert        len(value.keywords) == 0
        assert isinstance(value.func, ast.Attribute)
        assert isinstance(value.func.ctx, ast.Load)
        assert isinstance(value.func.value, ast.Name)
        assert value.func.value.id == 'self'
        assert isinstance(value.func.attr, str)
        if value.func.attr in ['negative_lookahead', 'positive_lookahead']:
            assert        len(value.args) >= 1
            assert isinstance(value.args[0], ast.Attribute)
            assert isinstance(value.args[0], ast.Attribute)
            assert isinstance(value.args[0].value, ast.Name)
            assert value.args[0].value.id == 'self'
            f_attr = value.args[0].attr
            f_args = value.args[1:]
            if value.func.attr == 'negative_lookahead':
                return NegLookAhead(
                    rule=handle_one_value(
                        ast.Call(
                            func=value.args[0],
                            args=value.args[1:],
                            keywords=[],
                        )
                    )
                )
            if value.func.attr == 'positive_lookahead':
                return PosLookAhead(
                    rule=handle_one_value(
                        ast.Call(
                            func=value.args[0],
                            args=value.args[1:],
                            keywords=[],
                        )
                    )
                )
        else:
            f_attr = value.func.attr
            f_args = value.args[:]

        if f_attr == 'expect':
            assert        len(f_args) == 1
            assert isinstance(f_args[0], ast.Constant)
            assert f_args[0].kind is None
            assert isinstance(f_args[0].value, str)
            return Expect(
                pattern=f_args[0].value
            )
        else:
            assert        len(f_args) == 0
            return CallRule(
                rule_name=f_attr,
            )

def handle_concat(root_body_i_test: ast.BoolOp | ast.Call | ast.NamedExpr | ast.Tuple | ast.Compare, handler: ast.AST | None = None) -> SingleLineRulePart:

    if not isinstance(root_body_i_test, ast.BoolOp):
        root_body_i_test = ast.BoolOp(
            op=ast.And(),
            values=[root_body_i_test]
        )

    assert isinstance(root_body_i_test, ast.BoolOp)
    assert isinstance(root_body_i_test.op, ast.And)

    return Concat(
        rules=tuple(
            [
                handle_one_value(value)
                for value in root_body_i_test.values
            ]

        ),
        handler=handler,
    )

def alternatives_traversal(root: ast.FunctionDef) -> MultiLineRulePart:
    assert isinstance(root.name, str)
    name = root.name
    assert        len(root.body) % 2 == 0

    assert mark_self_mark(root.body[0])
    assert return_none(root.body[-1])

    for i in range(2, len(root.body), 2):
        assert self_reset_mark(root.body[i])

    for i in range(1, len(root.body)-1, 2):
        assert if_to_return(root.body[i])

    concats: list[SingleLineRulePart] = []

    for i in range(1, len(root.body)-1, 2):
        root_body_i = root.body[i]
        assert isinstance(root_body_i, ast.If)
        assert        len(root_body_i.orelse) == 0
        assert        len(root_body_i.body) == 1
        assert        len(root_body_i.body) == 1
        assert isinstance(root_body_i.test, ast.BoolOp | ast.Call | ast.NamedExpr | ast.Tuple | ast.Compare)

        root_body_i_test = root_body_i.test

        assert isinstance(root_body_i.body[0], ast.Return)
        root_body_i_body_0 = root_body_i.body[0]
        assert isinstance(root_body_i_body_0, ast.Return)
        root_body_i_body_0_value = root_body_i_body_0.value
        if root_body_i_body_0_value is None:
            root_body_i_body_0_value = ast.Constant(value=None)
        assert root_body_i_body_0_value is not None

        concats.append(
            handle_concat(
                root_body_i_test,
                root_body_i_body_0_value,
            )
        )

    return Alternatives(
        rules=tuple(
            concats
        )
    )

####################################################################################################

def fun_body_traversal(root: ast.FunctionDef) -> MultiLineRulePart:

    if len(root.body) % 2 == 0:
        tests = [self_reset_mark, if_to_return] * (len(root.body) // 2)
        assert len(tests) ==        len(root.body)
        tests[:1] = [mark_self_mark]
        tests[-1:] = [return_none]
        assert len(tests) ==        len(root.body)
        if all(
            [
                test(node)
                for test, node in zip(tests, root.body)
            ]
        ):
            return alternatives_traversal(root)
        assert False

    assert        len(root.body) == 5

    assert mark_self_mark(root.body[0])
    assert children_empty(root.body[1])
    assert while_to_append_and_mark(root.body[2])
    assert self_reset_mark(root.body[3])
    assert return_children(root.body[4])

    assert isinstance(root.body[2], ast.While)
    assert isinstance(root.body[2].test, ast.BoolOp | ast.Call | ast.NamedExpr)

    return Star(
        handle_concat(
            root.body[2].test
        )
    )

####################################################################################################

def fun_traversal(root: ast.FunctionDef) -> Rule:
    assert root.type_comment == None

    assert isinstance(root.returns, ast.Subscript)
    assert isinstance(root.returns.ctx, ast.Load)
    assert isinstance(root.returns.value, ast.Name)
    assert isinstance(root.returns.slice, ast.Name)
    assert root.returns.value.id == 'Optional'
    assert isinstance(root.returns.value.ctx, ast.Load)
    assert root.returns.slice.id == 'Any'
    assert isinstance(root.returns.slice.ctx, ast.Load)

    assert isinstance(root.name, str)
    name = root.name

    assert        len(root.decorator_list) == 1
    assert isinstance(root.decorator_list[0], ast.Name)
    assert root.decorator_list[0].id == 'memoize'
    assert isinstance(root.decorator_list[0].ctx, ast.Load)

    assert isinstance(root.args, ast.arguments)
    assert        len(root.args.posonlyargs) == 0
    assert        len(root.args.args) == 1
    assert isinstance(root.args.args[0], ast.arg)
    assert root.args.args[0].type_comment is None
    assert root.args.args[0].annotation is None
    assert isinstance(root.args.args[0].arg, str)
    assert root.args.args[0].arg == 'self'
    assert root.args.vararg is None
    assert        len(root.args.kwonlyargs) == 0
    assert        len(root.args.kw_defaults) == 0
    assert root.args.kwarg is None
    assert        len(root.args.defaults) == 0

    assert        len(root.body) >= 4

    assert mark_self_mark(root.body[0])

    assert isinstance(root.body[-1], ast.Return)

    assert self_reset_mark(root.body[-2])

    return Rule(
        rule=fun_body_traversal(root),
        rule_name=name,
    )

####################################################################################################

def parser_class_traversal(root: ast.ClassDef) -> Rules:
    assert isinstance(root, ast.ClassDef)
    return Rules(
        rules=tuple(
            [
                fun_traversal(node)
                for node in root.body
                if isinstance(node, ast.FunctionDef)
            ]
        )
    )

def module_list_traversal(root: typing.Sequence[ast.AST]) -> list[Rules]:
    result : list[Rules] = []
    for item in root:
        traversal_result = module_traversal(item)
        if traversal_result is not None:
            result.append(
                traversal_result
            )
    return result

def module_traversal(root: ast.AST) -> Rules | None:
    if isinstance(root, ast.Module):
        result = module_list_traversal(root.body)
        assert        len(result) == 1
        return result[0]
    if isinstance(root, ast.Import):
        return None
    if isinstance(root, ast.ImportFrom):
        return None
    if isinstance(root, ast.ClassDef):
        return parser_class_traversal(root)
    if isinstance(root, ast.Assign):
        return None
    if isinstance(root, ast.If):
        return None

    if isinstance(root, ast.AST):
        print(ast.dump(root, indent=4))
    print(root)
    assert False

def parse_parser_ast(root: ast.Module) -> File:
    assert isinstance(root, ast.Module)
    for i, node in enumerate(root.body):
        if isinstance(node, ast.ClassDef):
            return File(
                subheader=ast.Module(
                    body=root.body[:i],
                    type_ignores=[],
                ),
                rules=parser_class_traversal(node)
            ).simplify()
    assert False

if __name__ == '__main__':
    with open('python_parser.py') as python_parser_file:
        python_parser_text = python_parser_file.read()

    root = ast.parse(python_parser_text)

    print(parse_parser_ast(root).to_grammar(), file=open('python.gram', 'w'))
