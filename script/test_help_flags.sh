#!/usr/bin/env bash

# Test script to verify all git helper scripts have --help support
# Usage: ./test/test_help_flags.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/bin"
FAILED=0
PASSED=0

echo "Testing --help flag for all scripts in $SCRIPT_DIR"
echo "================================================================"

for script in "$SCRIPT_DIR"/git-*; do
  script_name=$(basename "$script")

  # Skip symlinks (they point to other scripts that are tested)
  if [ -L "$script" ]; then
    echo "SKIP: $script_name (symlink)"
    continue
  fi

  # Skip non-executable files
  if [ ! -x "$script" ]; then
    echo "SKIP: $script_name (not executable)"
    continue
  fi

  # Test --help flag
  output=$("$script" --help 2>&1)
  exit_code=$?

  # Check for exit code 0 and some common help text indicators
  if [ $exit_code -eq 0 ] && (echo "$output" | grep -qE "(Usage:|Options:|--help|Description:)"); then
    echo "PASS: $script_name"
    ((PASSED++))
  else
    echo "FAIL: $script_name (exit=$exit_code)"
    ((FAILED++))
  fi
done

echo ""
echo "================================================================"
echo "Results: $PASSED passed, $FAILED failed"

if [ $FAILED -gt 0 ]; then
  exit 1
fi
