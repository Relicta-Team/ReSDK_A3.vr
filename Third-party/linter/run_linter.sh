#!/bin/bash
# ReSDK_A3 Code Style Linter - Linux/macOS Runner
# Usage: ./run_linter.sh [options]
#   No options - lint entire project
#   -f <file> - lint single file
#   -d <dir>  - lint specific directory

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! cd "$SCRIPT_DIR"; then
    echo "Error: Failed to change directory to $SCRIPT_DIR" >&2
    exit 1
fi

python3 linter.py "$@"
exit_code=$?

if [ $exit_code -ne 0 ]; then
    echo ""
    echo "Linting failed with errors!"
    exit 1
fi

echo ""
echo "Linting passed!"
exit 0
