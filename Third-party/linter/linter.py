#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ReSDK_A3 Code Style Linter
Validates code against project style guide (CODE-STANDARDS.md)
"""

import sys
import os
import argparse
import re
from datetime import datetime
from pathlib import Path
from typing import List, Tuple, Dict, Optional, ClassVar, Set
from dataclasses import dataclass
from enum import Enum

class Severity(Enum):
    WARNING = "warning"
    ERROR = "error"

@dataclass
class LintIssue:
    file: str
    line: int
    column: int
    severity: Severity
    rule: str
    message: str
    
    def __str__(self) -> str:
        sev = "⚠️ " if self.severity == Severity.WARNING else "❌"
        return f"{self.file}:{self.line}:{self.column}: {sev} [{self.rule}] {self.message}"
    
    def github_format(self) -> str:
        level = "warning" if self.severity == Severity.WARNING else "error"
        return f"::{level} file={self.file},line={self.line},col={self.column}::[{self.rule}] {self.message}"

class SQFLinter:
    """Main linter class for SQF/HPP files"""
    
    # Directories to exclude from linting (lowercase for case-insensitive matching)
    EXCLUDED_DIRS: ClassVar[List[str]] = [
        'third-party',
        'editor/bin',
        'rvengine', 
        'host/mapmanager/maps',
    ]
    
    # Special variables that are automatically local in SQF
    SPECIAL_VARS: ClassVar[Set[str]] = {'_x', '_y', '_forEachIndex', '_this', '_exception', '_thisScript', '_thisFSM'}
    
    # Module function pattern: moduleName_functionName = {
    MODULE_FUNC_PATTERN = re.compile(r'^([a-z][a-zA-Z0-9]*(?:_[a-z][a-zA-Z0-9]*)+)\s*=\s*\{', re.MULTILINE)
    
    # Include pattern (only quote includes - angle brackets are for system headers)
    INCLUDE_QUOTE_PATTERN = re.compile(r'#include\s*"([^"]+)"')
    
    # Macro patterns
    MACRO_FUNC_PATTERN = re.compile(r'^#define\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*\(', re.MULTILINE)
    
    # Class/struct member patterns
    CLASS_FUNC_PATTERN = re.compile(r'^\t(func|def)\s*\(\s*([a-zA-Z_][a-zA-Z0-9_]*)\s*\)', re.MULTILINE)
    CLASS_VAR_PATTERN = re.compile(r'^\t(var|getter_func|getterconst_func)\s*\(', re.MULTILINE)
    
    def __init__(self, root_path: str, verbose: bool = False):
        self.root_path = Path(root_path)
        self.issues: List[LintIssue] = []
        self.verbose = verbose
        self.current_year = datetime.now().year
    
    def _is_excluded_path(self, file_path: Path) -> bool:
        """Check if file path should be excluded (case-insensitive)"""
        path_str = str(file_path).replace('\\', '/').lower()
        for excluded in self.EXCLUDED_DIRS:
            if excluded in path_str:
                return True
        return False
    
    def _is_interface_file(self, file_path: Path, content: str) -> bool:
        """Check if file is an interface file (included inside a class)"""
        # Interface files don't have class/endclass declarations
        # but contain class members like func(), var(), etc.
        has_class_decl = bool(re.search(r'^(class|struct)\s*\(', content, re.MULTILINE))
        has_endclass = bool(re.search(r'^(endclass|endstruct)', content, re.MULTILINE))
        has_members = bool(re.search(r'^\t?(func|def|var|getter_func|getterconst_func)\s*\(', content, re.MULTILINE))
        
        # It's an interface file if it has members but no class/endclass
        return has_members and not has_class_decl and not has_endclass
    
    def _check_copyright(self, file_path: str, content: str) -> List[LintIssue]:
        """Check for copyright header with valid year range"""
        issues = []
        
        # Pattern for copyright header with dynamic year validation
        copyright_pattern = re.compile(
            r'^// ======+\s*\n'
            r'// Copyright \(c\) (\d{4})(-(\d{4}))? the ReSDK_A3 project\s*\n'
            r'// sdk\.relicta\.ru\s*\n'
            r'// ======+',
            re.MULTILINE
        )
        
        match = copyright_pattern.search(content)
        if not match:
            issues.append(LintIssue(
                file=file_path,
                line=1,
                column=1,
                severity=Severity.ERROR,
                rule="copyright-header",
                message="Missing or invalid copyright header"
            ))
        else:
            # Validate year range
            start_year = int(match.group(1))
            end_year = int(match.group(3)) if match.group(3) else start_year
            
            if start_year != 2017:
                issues.append(LintIssue(
                    file=file_path,
                    line=2,
                    column=1,
                    severity=Severity.ERROR,
                    rule="copyright-year",
                    message=f"Copyright start year should be 2017, found {start_year}"
                ))
            
            if end_year != self.current_year:
                issues.append(LintIssue(
                    file=file_path,
                    line=2,
                    column=1,
                    severity=Severity.ERROR,
                    rule="copyright-year",
                    message=f"Copyright end year should be {self.current_year}, found {end_year}"
                ))
        
        return issues
        
    def lint_file(self, file_path: Path) -> List[LintIssue]:
        """Lint a single file and return issues"""
        issues = []
        
        # Check if excluded
        if self._is_excluded_path(file_path):
            return issues
        
        try:
            rel_path = str(file_path.relative_to(self.root_path) if file_path.is_relative_to(self.root_path) else file_path)
        except ValueError:
            rel_path = str(file_path)
        
        # Verbose logging (to stderr so it doesn't mix with issues)
        if self.verbose:
            print(f"[LINT] Checking: {rel_path}", file=sys.stderr)
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='replace') as f:
                content = f.read()
                lines = content.split('\n')
        except Exception as e:
            issues.append(LintIssue(
                file=rel_path,
                line=1,
                column=1,
                severity=Severity.ERROR,
                rule="file-read",
                message=f"Could not read file: {e}"
            ))
            return issues
        
        # Determine if this is an interface file
        is_interface = self._is_interface_file(file_path, content)
        
        # Check copyright header
        issues.extend(self._check_copyright(rel_path, content))
        
        # Check tabs vs spaces
        issues.extend(self._check_tabs(rel_path, lines))
        
        # Check if-then formatting
        issues.extend(self._check_if_then_formatting(rel_path, lines))
        
        # Check macro naming
        issues.extend(self._check_macros(rel_path, content, lines))
        
        # Check function naming style
        issues.extend(self._check_function_naming(rel_path, content, lines))
        
        # Check local variable declarations
        issues.extend(self._check_local_variables(rel_path, lines))
        
        # Check includes validity (only quote includes, not angle brackets)
        issues.extend(self._check_includes(rel_path, file_path, lines))
        
        # Check class/struct member formatting (skip for interface files)
        if not is_interface:
            issues.extend(self._check_class_members(rel_path, lines))
        
        return issues
    
    def _check_tabs(self, file_path: str, lines: List[str]) -> List[LintIssue]:
        """Check for spaces used instead of tabs for indentation"""
        issues = []
        for i, line in enumerate(lines, 1):
            # Check if line starts with spaces (not tabs) for indentation
            if line and not line.startswith('\t') and line.startswith('    '):
                # Count leading spaces
                spaces = len(line) - len(line.lstrip(' '))
                if spaces >= 4:  # At least one tab-worth of spaces
                    issues.append(LintIssue(
                        file=file_path,
                        line=i,
                        column=1,
                        severity=Severity.ERROR,
                        rule="tabs-not-spaces",
                        message=f"Use tabs for indentation, not spaces (found {spaces} leading spaces)"
                    ))
        return issues
    
    def _find_matching_paren(self, text: str, start: int) -> int:
        """Find the index of matching closing parenthesis, handling nested parens"""
        depth = 0
        i = start
        while i < len(text):
            if text[i] == '(':
                depth += 1
            elif text[i] == ')':
                depth -= 1
                if depth == 0:
                    return i
            i += 1
        return -1
    
    def _check_if_then_formatting(self, file_path: str, lines: List[str]) -> List[LintIssue]:
        """Check if-then-else formatting using parenthesis balancing"""
        issues = []
        
        # Join lines to handle multiline if conditions
        content = '\n'.join(lines)
        
        # Find all 'if' followed by '('
        i = 0
        while i < len(content):
            # Find 'if' keyword (not part of another word)
            if_match = re.search(r'\bif\s*\(', content[i:])
            if not if_match:
                break
            
            if_start = i + if_match.start()
            paren_start = i + if_match.end() - 1  # Position of '('
            
            # Find matching ')'
            paren_end = self._find_matching_paren(content, paren_start)
            if paren_end == -1:
                i = paren_start + 1
                continue
            
            # Check what comes after the closing paren
            after_paren = content[paren_end + 1:paren_end + 50]  # Look ahead
            
            # Check if 'then' is on a new line
            then_match = re.match(r'\s*\n\s*then\s*[\{]?', after_paren)
            if then_match:
                line_num = content[:if_start].count('\n') + 1
                issues.append(LintIssue(
                    file=file_path,
                    line=line_num,
                    column=1,
                    severity=Severity.ERROR,
                    rule="if-then-format",
                    message="'then' should be on the same line as 'if', not on a new line"
                ))
            
            i = paren_end + 1
        
        return issues
    
    def _check_macros(self, file_path: str, content: str, lines: List[str]) -> List[LintIssue]:
        """Check macro naming conventions"""
        issues = []
        
        # Check macro-functions should be camelCase
        for match in self.MACRO_FUNC_PATTERN.finditer(content):
            name = match.group(1)
            line_num = content[:match.start()].count('\n') + 1
            
            # Skip internal macros (starting with __ or _)
            if name.startswith('__') or name.startswith('_'):
                continue
            
            # Skip if it's all uppercase (could be valid constant-like macro)
            if name.isupper():
                continue
                
            # Check if it follows camelCase (starts with lowercase)
            if not name[0].islower():
                issues.append(LintIssue(
                    file=file_path,
                    line=line_num,
                    column=match.start() - content.rfind('\n', 0, match.start()),
                    severity=Severity.WARNING,
                    rule="macro-func-naming",
                    message=f"Macro function '{name}' should use camelCase (start with lowercase)"
                ))
        
        return issues
    
    def _check_function_naming(self, file_path: str, content: str, lines: List[str]) -> List[LintIssue]:
        """Check module function naming convention"""
        issues = []
        
        # Module functions should be moduleName_functionName
        for match in self.MODULE_FUNC_PATTERN.finditer(content):
            name = match.group(1)
            line_num = content[:match.start()].count('\n') + 1
            
            parts = name.split('_')
            if len(parts) < 2:
                continue
                
            # Check each part is camelCase
            for part in parts:
                if not part:
                    continue
                # First char should be lowercase, rest can be mixed
                if not part[0].islower():
                    issues.append(LintIssue(
                        file=file_path,
                        line=line_num,
                        column=1,
                        severity=Severity.WARNING,
                        rule="func-naming",
                        message=f"Function '{name}' parts should use camelCase (part '{part}' starts with uppercase)"
                    ))
                    break
        
        return issues
    
    def _check_local_variables(self, file_path: str, lines: List[str]) -> List[LintIssue]:
        """Check local variable declarations use private/params/objParams"""
        issues = []
        
        # Track variables that have been declared in the file
        declared_vars: Set[str] = set()
        
        # Track if we're inside a multiline #define
        in_multiline_define = False
        # Track if we're inside a multiline comment /* */
        in_multiline_comment = False
        
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            
            # Handle multiline comments
            if in_multiline_comment:
                if '*/' in stripped:
                    in_multiline_comment = False
                continue
            
            if '/*' in stripped and '*/' not in stripped:
                in_multiline_comment = True
                continue
            
            # Skip single-line comments
            if stripped.startswith('//'):
                continue
            
            # Skip lines that are entirely a comment
            if stripped.startswith('/*') and stripped.endswith('*/'):
                continue
            
            # Skip empty lines
            if not stripped:
                continue
            
            # Track multiline #define (ends with \)
            if stripped.startswith('#define'):
                in_multiline_define = stripped.endswith('\\')
                continue
            
            if in_multiline_define:
                in_multiline_define = stripped.endswith('\\')
                continue
            
            # Track private declarations
            private_match = re.search(r'private\s+["\']?(_[a-zA-Z][a-zA-Z0-9_]*)', line)
            if private_match:
                declared_vars.add(private_match.group(1))
                continue
            
            # Track privates() macro declarations
            privates_match = re.search(r'privates\s*\(\s*"([^"]+)"', line)
            if privates_match:
                for var in privates_match.group(1).split():
                    if var.startswith('_'):
                        declared_vars.add(var)
                continue
            
            # Track params declarations
            params_match = re.search(r'params\s*\[([^\]]+)\]', line)
            if params_match:
                for var in re.findall(r'"(_[a-zA-Z][a-zA-Z0-9_]*)"', params_match.group(1)):
                    declared_vars.add(var)
                continue
            
            # Track objParams declarations
            objparams_match = re.search(r'objParams[_0-9]*\s*\(([^)]+)\)', line)
            if objparams_match:
                for var in re.findall(r'(_[a-zA-Z][a-zA-Z0-9_]*)', objparams_match.group(1)):
                    declared_vars.add(var)
                continue
            
            # Look for _varName = without prior declaration
            assign_match = re.match(r'^\s*(_[a-zA-Z][a-zA-Z0-9_]*)\s*=', stripped)
            if assign_match:
                var_name = assign_match.group(1)
                
                # Skip special SQF variables
                if var_name in self.SPECIAL_VARS:
                    continue
                
                # Skip if already declared
                if var_name in declared_vars:
                    continue
                
                # Skip if this line contains private declaration
                if 'private' in line:
                    declared_vars.add(var_name)
                    continue
                
                # Mark as declared to avoid duplicate warnings
                declared_vars.add(var_name)
                
                issues.append(LintIssue(
                    file=file_path,
                    line=i,
                    column=1,
                    severity=Severity.WARNING,
                    rule="local-var-declaration",
                    message=f"Local variable '{var_name}' should be declared with 'private', 'params', or 'objParams'"
                ))
        
        return issues
    
    def _check_includes(self, file_path: str, abs_path: Path, lines: List[str]) -> List[LintIssue]:
        """Check include statements validity (only quote includes, not angle brackets)"""
        issues = []
        file_dir = abs_path.parent
        
        for i, line in enumerate(lines, 1):
            # Only check quote includes (angle brackets are for system/SDK headers)
            match = self.INCLUDE_QUOTE_PATTERN.search(line)
            if match:
                include_path = match.group(1)
                resolved = self._resolve_include_path(file_dir, include_path)
                if resolved and not resolved.exists():
                    issues.append(LintIssue(
                        file=file_path,
                        line=i,
                        column=match.start() + 1,
                        severity=Severity.ERROR,
                        rule="include-not-found",
                        message=f"Include file not found: {include_path}"
                    ))
        
        return issues
    
    def _resolve_include_path(self, file_dir: Path, include_path: str) -> Optional[Path]:
        """Resolve include path relative to file directory"""
        # Normalize backslashes to forward slashes
        include_path = include_path.replace('\\', '/')
        
        # Remove leading ./ or <./
        if include_path.startswith('./'):
            include_path = include_path[2:]
        
        try:
            resolved = (file_dir / include_path).resolve()
            return resolved
        except Exception:
            return None
    
    def _check_class_members(self, file_path: str, lines: List[str]) -> List[LintIssue]:
        """Check class/struct member formatting"""
        issues = []
        
        in_class = False
        class_indent = 0
        
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            
            # Detect class/struct start
            if re.match(r'^(class|struct)\s*\(', stripped):
                in_class = True
                class_indent = len(line) - len(line.lstrip('\t'))
                continue
            
            # Detect class/struct end
            if stripped.startswith('endclass') or stripped.startswith('endstruct'):
                in_class = False
                continue
            
            if in_class and stripped:
                # Check member indentation (should be one tab more than class)
                current_indent = len(line) - len(line.lstrip('\t'))
                
                # Check func/def/var declarations have proper indentation
                if re.match(r'^(func|def|var|getter_func|getterconst_func)\s*\(', stripped):
                    if current_indent != class_indent + 1:
                        issues.append(LintIssue(
                            file=file_path,
                            line=i,
                            column=1,
                            severity=Severity.WARNING,
                            rule="class-member-indent",
                            message=f"Class member should be indented with {class_indent + 1} tab(s), found {current_indent}"
                        ))
        
        return issues
    
    def lint_directory(self, dir_path: Path, extensions: List[str]) -> List[LintIssue]:
        """Lint all matching files in directory recursively"""
        all_issues = []
        
        for ext in extensions:
            for file_path in dir_path.rglob(f'*{ext}'):
                # Skip excluded directories (checked in lint_file too, but skip early)
                if self._is_excluded_path(file_path):
                    continue
                    
                issues = self.lint_file(file_path)
                all_issues.extend(issues)
        
        return all_issues


def main():
    parser = argparse.ArgumentParser(
        description='ReSDK_A3 Code Style Linter',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  python linter.py                    # Lint entire project
  python linter.py -f Src/host/file.sqf  # Lint single file
  python linter.py --github-actions   # Output in GitHub Actions format
        '''
    )
    
    parser.add_argument('-f', '--file', type=str, help='Lint a single file')
    parser.add_argument('-d', '--directory', type=str, help='Lint a specific directory')
    parser.add_argument('-v', '--verbose', action='store_true', help='Show each file being checked')
    parser.add_argument('--github-actions', action='store_true', help='Output in GitHub Actions format')
    parser.add_argument('--root', type=str, default=None, help='Project root directory')
    parser.add_argument('--extensions', type=str, default='.sqf,.hpp', help='File extensions to lint (comma-separated)')
    parser.add_argument('--warnings-as-errors', action='store_true', help='Treat warnings as errors')
    
    args = parser.parse_args()
    
    # Determine root path
    if args.root:
        root_path = Path(args.root)
    else:
        # Find project root (look for CODE-STANDARDS.md)
        current = Path(__file__).parent
        while current != current.parent:
            if (current / 'CODE-STANDARDS.md').exists():
                root_path = current
                break
            current = current.parent
        else:
            root_path = Path(__file__).parent.parent.parent  # Assume Third-party/linter structure
    
    linter = SQFLinter(str(root_path), verbose=args.verbose)
    extensions = args.extensions.split(',')
    
    # Collect issues
    issues: List[LintIssue] = []
    
    if args.file:
        file_path = Path(args.file)
        if not file_path.is_absolute():
            file_path = root_path / file_path
        issues = linter.lint_file(file_path)
    elif args.directory:
        dir_path = Path(args.directory)
        if not dir_path.is_absolute():
            dir_path = root_path / dir_path
        issues = linter.lint_directory(dir_path, extensions)
    else:
        # Lint Src directory by default
        src_path = root_path / 'Src'
        if src_path.exists():
            issues = linter.lint_directory(src_path, extensions)
        else:
            print(f"Error: Src directory not found in {root_path}", file=sys.stderr)
            sys.exit(1)
    
    # Output results
    errors = 0
    warnings = 0
    
    for issue in sorted(issues, key=lambda x: (x.file, x.line)):
        if args.github_actions:
            print(issue.github_format())
        else:
            print(issue)
        
        if issue.severity == Severity.ERROR:
            errors += 1
        else:
            warnings += 1
    
    # Summary
    if not args.github_actions:
        print(f"\n{'='*60}")
        print(f"Linting complete: {errors} error(s), {warnings} warning(s)")
        print(f"{'='*60}")
    
    # Exit code
    if errors > 0 or (args.warnings_as_errors and warnings > 0):
        sys.exit(1)
    
    sys.exit(0)


if __name__ == '__main__':
    main()
