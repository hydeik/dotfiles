#!/usr/bin/env python3
import json
import sys

data = json.load(sys.stdin)
command = data.get("tool_input", {}).get("command", "")

redirects = {
    "pip install": "uv add",
    "pip3 install": "uv add",
    "pip uninstall": "uv remove",
    "pip3 uninstall": "uv remove",
    "python -m pip": "uv add / uv remove",
    "python3 -m pip": "uv add / uv remove",
    "python -m pytest": "uv run pytest",
    "python3 -m pytest": "uv run pytest",
    "python -m ruff": "uv run ruff",
    "python3 -m ruff": "uv run ruff",
}

for pattern, replacement in redirects.items():
    if pattern in command:
        print(
            f"Blocked: '{pattern}' detected. Use '{replacement}' instead.",
            file=sys.stderr,
        )
        sys.exit(2)

# Block bare python/pytest/ruff unless prefixed with uv run
bare_commands = {"python ", "python3 ", "pytest", "ruff "}
for bare in bare_commands:
    if command == bare.strip() or (
        command.startswith(bare) and not command.startswith("uv run")
    ):
        print(f"Blocked: use 'uv run {command}' instead.", file=sys.stderr)
        sys.exit(2)
