#!/usr/bin/env bash
input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path')

if [[ "$file_path" == *.py ]] && [[ -f "$file_path" ]]; then
  uv run ruff check --fix --quiet "$file_path" 2> /dev/null
  uv run ruff format --quiet "$file_path" 2> /dev/null
fi
exit 0
