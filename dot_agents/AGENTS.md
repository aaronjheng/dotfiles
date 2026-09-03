# Global agent instructions

## GitHub CLI (gh) account usage

- Never use `gh auth switch`; it mutates global state and races with concurrent sessions.
- To run a gh command as a non-active account, set the token inline:

  ```shell
  GH_TOKEN=$(gh auth token --user <account>) gh ...
  ```

- Pick the account per repository: prefer the account matching the repo owner;
  otherwise probe candidate accounts for push permission on the repo; fall back
  to the default active account.
