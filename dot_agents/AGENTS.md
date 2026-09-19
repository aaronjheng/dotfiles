# Global agent instructions

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
