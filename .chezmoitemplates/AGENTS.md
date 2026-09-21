# Global agent instructions

## Language

Always respond in the same language the user uses. If the user writes in Chinese
(中文), respond entirely in Chinese; never switch to English unless the user
explicitly asks for it.

## Git

- Never commit, push, create branches or tags, or open PRs unless I explicitly ask.
- Do not ask whether to commit and do not offer it as a next step. Leave the changes
  in the working tree and stop — I will say so when I want them committed.
- When I do ask for a commit, write a subject line and nothing else — no body. Keep
  the reasoning in the conversation, not in the commit message.
- When I do ask for a PR, provide a title only — no description, unless I explicitly
  ask for one.

## Tests

- Never add tests to the repo unless I explicitly ask for them — no unit,
  integration, end-to-end, snapshot, or benchmark files; no test framework config
  files, test helper utilities, or mock data; and no test scaffolding "while I'm
  here".
- If a change would normally warrant tests, say so in one line and move on.
- Verifying your own work is still expected: build it, lint it, run it. Just don't
  leave test files behind unless I asked for them.

## GUI testing

- Never perform any form of GUI testing, running, screenshotting, window
  inspection, or synthesized input (clicks/keys) on your own initiative.
  Verifying your own work means building, linting, and typechecking -
  visual or interactive verification is the user's job. Only touch the GUI
  when the user explicitly asks for it.

## GitHub CLI (gh) account usage

- Never use `gh auth switch`; it mutates global state and races with concurrent sessions.
- To run a gh command as a non-active account, set the token inline:

  ```shell
  GH_TOKEN=$(gh auth token --user <account>) gh ...
  ```

- Pick the account per repository: prefer the account matching the repo owner;
  otherwise probe candidate accounts for push permission on the repo; fall back
  to the default active account.

## One-off Python scripts (uv)

When writing a one-off, auxiliary Python script to complete the current task —
data processing, format conversion, quick validation; something to discard after
use rather than keep in the project — prefer `uv` over the system `python` /
`python3`, so the script does not depend on the system's preinstalled Python
version or packages. Unless there is a clear reason (e.g. debugging the system
Python environment itself), do not use `pip install` or call the system `python`
directly.

This convention does not apply to the project's own Python source files; those
follow the project's own build and dependency management.

### Temporary script files: PEP 723 inline metadata

Give the script a self-contained dependency declaration block at the top:

```python
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "requests",
#     "rich",
# ]
# ///

import requests
from rich import print
...
```

Then run it with:

```bash
uv run script.py
```

- Default to `requires-python = ">=3.12"` unless the user specifies another version.
- List only the third-party packages the script actually imports; omit the
  `dependencies` line for stdlib-only scripts.
- `uv run` downloads the matching Python interpreter and installs dependencies
  automatically (cached, no repeated downloads).

### One-liners

```bash
# No extra dependencies
uv run python -c "import json; print(json.dumps({'a':1}))"

# With extra dependencies, use --with
uv run --with requests,rich python -c "import requests; print(requests.get('https://httpbin.org/ip').json())"
```

### Notes

- Avoid `python script.py` / `python3 script.py`; prefer `uv run script.py`.
- Avoid `pip install xxx`; dependencies are managed by uv automatically.
- Do not assume any third-party package is already installed system-wide.
- No need to manually create or activate a venv; `uv run` handles it.
