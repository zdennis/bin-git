#!/usr/bin/env bash

# Test script to verify all git helper scripts have --version support
# Usage: ./test/test_version_flags.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/bin"
FAILED=0
PASSED=0

echo "Testing --version flag for all scripts in $SCRIPT_DIR"
echo "================================================================"

for script in "$SCRIPT_DIR"/git-*; do
  script_name=$(basename "$script")

  # Skip non-executable files
  if [ ! -x "$script" ]; then
    echo "SKIP: $script_name (not executable)"
    continue
  fi

  # Test --version flag
  output=$("$script" --version 2>&1)
  exit_code=$?

  if [ $exit_code -eq 0 ] && echo "$output" | grep -q "version"; then
    echo "PASS: $script_name"
    ((PASSED++))
  else
    echo "FAIL: $script_name (exit=$exit_code, output: $output)"
    ((FAILED++))
  fi
done

echo ""
echo "================================================================"
echo "Results: $PASSED passed, $FAILED failed"

if [ $FAILED -gt 0 ]; then
  exit 1
fi
