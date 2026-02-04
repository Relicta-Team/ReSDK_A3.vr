#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Unit tests for ReSDK_A3 Code Style Linter
Run with: python -m pytest test_linter.py -v
Or: python test_linter.py
"""

import unittest
import tempfile
import os
from pathlib import Path
from linter import SQFLinter, LintIssue, Severity


class TestCopyright(unittest.TestCase):
    """Tests for copyright header validation"""
    
    def setUp(self):
        self.linter = SQFLinter("/tmp")
    
    def test_valid_copyright(self):
        """Valid copyright header should pass"""
        content = '''// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

some_code = {};
'''
        issues = self.linter._check_copyright("test.sqf", content)
        self.assertEqual(len(issues), 0)
    
    def test_missing_copyright(self):
        """Missing copyright should be flagged"""
        content = "some_code = {};"
        issues = self.linter._check_copyright("test.sqf", content)
        self.assertEqual(len(issues), 1)
        self.assertEqual(issues[0].rule, "copyright-header")
    
    def test_wrong_start_year(self):
        """Wrong start year should be flagged"""
        content = '''// ======================================================
// Copyright (c) 2020-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
'''
        issues = self.linter._check_copyright("test.sqf", content)
        self.assertEqual(len(issues), 1)
        self.assertEqual(issues[0].rule, "copyright-year")
        self.assertIn("2017", issues[0].message)


class TestTabs(unittest.TestCase):
    """Tests for tab/space indentation checking"""
    
    def setUp(self):
        self.linter = SQFLinter("/tmp")
    
    def test_tabs_only(self):
        """File with only tabs should pass"""
        lines = [
            "func = {",
            "\tprivate _x = 1;",
            "\tif (true) then {",
            "\t\t_x = 2;",
            "\t};",
            "};"
        ]
        issues = self.linter._check_tabs("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_spaces_only_file(self):
        """File using only spaces should get single error"""
        lines = [
            "func = {",
            "    private _x = 1;",
            "    if (true) then {",
            "        _x = 2;",
            "    };",
            "};"
        ]
        issues = self.linter._check_tabs("test.sqf", lines)
        self.assertEqual(len(issues), 1)
        self.assertEqual(issues[0].rule, "tabs-not-spaces")
        self.assertIn("lines affected", issues[0].message)
    
    def test_mixed_file(self):
        """File with both tabs and spaces should report each space line"""
        lines = [
            "\tfunc1 = {",
            "\t\tcode;",
            "\t};",
            "    func2 = {",  # spaces
            "        code;",  # spaces
            "    };"
        ]
        issues = self.linter._check_tabs("test.sqf", lines)
        # Should report individual lines since file has tabs
        self.assertGreater(len(issues), 1)
        self.assertTrue(all(i.rule == "tabs-not-spaces" for i in issues))
    
    def test_mixed_indentation_tab_then_spaces(self):
        """Tabs followed by spaces should be flagged"""
        lines = [
            "\t    mixed;",  # tab + spaces
            "\tgood;",       # just tabs
        ]
        issues = self.linter._check_tabs("test.sqf", lines)
        mixed_issues = [i for i in issues if i.rule == "mixed-indentation"]
        self.assertEqual(len(mixed_issues), 1)
        self.assertIn("tab(s) followed by", mixed_issues[0].message)


class TestIfThenFormatting(unittest.TestCase):
    """Tests for if-then formatting validation"""
    
    def setUp(self):
        self.linter = SQFLinter("/tmp")
    
    def test_correct_if_then(self):
        """Correct if-then on same line should pass"""
        lines = [
            "if (condition) then {",
            "\tcode;",
            "};"
        ]
        issues = self.linter._check_if_then_formatting("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_then_on_new_line(self):
        """'then' on new line should be flagged"""
        lines = [
            "if (condition)",
            "then {",
            "\tcode;",
            "};"
        ]
        issues = self.linter._check_if_then_formatting("test.sqf", lines)
        self.assertEqual(len(issues), 1)
        self.assertEqual(issues[0].rule, "if-then-format")
    
    def test_nested_parentheses(self):
        """Nested parentheses in condition should be handled"""
        lines = [
            "if (call(func(arg))) then {",
            "\tcode;",
            "};"
        ]
        issues = self.linter._check_if_then_formatting("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_multiline_condition_with_then_on_new_line(self):
        """Multiline condition with then on new line"""
        lines = [
            "if (",
            "\tcondition1 &&",
            "\tcondition2",
            ")",
            "then {"
        ]
        issues = self.linter._check_if_then_formatting("test.sqf", lines)
        self.assertEqual(len(issues), 1)


class TestClassMemberIndent(unittest.TestCase):
    """Tests for class member indentation"""
    
    def setUp(self):
        self.linter = SQFLinter("/tmp")
    
    def test_correct_class_indent(self):
        """Class at root with members at 1 tab"""
        lines = [
            "class(MyClass)",
            "\tfunc(doSomething)",
            "\t{",
            "\t\tcode;",
            "\t}",
            "endclass"
        ]
        issues = self.linter._check_class_members("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_nested_class_indent(self):
        """Nested class with correct indentation"""
        lines = [
            "\tclass(InnerClass)",
            "\t\tfunc(method)",
            "\t\t{",
            "\t\t\tcode;",
            "\t\t}",
            "\tendclass"
        ]
        issues = self.linter._check_class_members("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_wrong_member_indent(self):
        """Member with wrong indentation should be flagged"""
        lines = [
            "class(MyClass)",
            "func(noIndent)",  # Should be 1 tab
            "{",
            "}",
            "endclass"
        ]
        issues = self.linter._check_class_members("test.sqf", lines)
        self.assertEqual(len(issues), 1)
        self.assertEqual(issues[0].rule, "class-member-indent")


class TestLocalVariables(unittest.TestCase):
    """Tests for local variable declaration checking"""
    
    def setUp(self):
        self.linter = SQFLinter("/tmp")
    
    def test_declared_private(self):
        """Variable declared with private should pass"""
        lines = [
            "private _x = 1;",
            "_x = 2;"
        ]
        issues = self.linter._check_local_variables("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_undeclared_local(self):
        """Undeclared local variable should be flagged"""
        lines = [
            "_undeclared = 1;"
        ]
        issues = self.linter._check_local_variables("test.sqf", lines)
        self.assertEqual(len(issues), 1)
        self.assertEqual(issues[0].rule, "local-var-declaration")
    
    def test_special_vars(self):
        """Special SQF variables should not be flagged"""
        lines = [
            "_x = 1;",
            "_y = 2;",
            "_forEachIndex = 0;",
            "_this = [];"
        ]
        issues = self.linter._check_local_variables("test.sqf", lines)
        self.assertEqual(len(issues), 0)
    
    def test_params_declaration(self):
        """Variables declared via params should pass"""
        lines = [
            'params ["_arg1", "_arg2"];',
            "_arg1 = 1;",
            "_arg2 = 2;"
        ]
        issues = self.linter._check_local_variables("test.sqf", lines)
        self.assertEqual(len(issues), 0)


class TestIntegration(unittest.TestCase):
    """Integration tests with real files"""
    
    def test_lint_file(self):
        """Test linting a complete file"""
        with tempfile.NamedTemporaryFile(mode='w', suffix='.sqf', delete=False) as f:
            f.write('''// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

test_func = {
\tparams ["_arg"];
\tprivate _result = _arg * 2;
\t_result
};
''')
            f.flush()
            
            linter = SQFLinter(str(Path(f.name).parent))
            issues = linter.lint_file(Path(f.name))
            
            os.unlink(f.name)
            
            # Should have no major issues
            errors = [i for i in issues if i.severity == Severity.ERROR]
            self.assertEqual(len(errors), 0)


class TestExcludedPaths(unittest.TestCase):
    """Tests for path exclusion"""
    
    def setUp(self):
        self.linter = SQFLinter("/project")
    
    def test_third_party_excluded(self):
        """Third-party directory should be excluded (case insensitive)"""
        self.assertTrue(self.linter._is_excluded_path(Path("/project/Third-party/lib.sqf")))
        self.assertTrue(self.linter._is_excluded_path(Path("/project/third-party/lib.sqf")))
        self.assertTrue(self.linter._is_excluded_path(Path("/project/THIRD-PARTY/lib.sqf")))
    
    def test_normal_path_not_excluded(self):
        """Normal paths should not be excluded"""
        self.assertFalse(self.linter._is_excluded_path(Path("/project/Src/main.sqf")))


if __name__ == '__main__':
    unittest.main(verbosity=2)
