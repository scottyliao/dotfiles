---
description: Commit and push any relevant changes
allowed-tools: Bash(git:*)
---

- When the user asks to push (e.g. "push", "push to GitHub"), first run `git status`.
- If there are uncommitted changes (staged or unstaged) relevant to the current work, add and commit them first (following the Git Commit Conventions above), without asking for confirmation, then push.
- When staging, add only the relevant files by name — never `git add -A` or `git add .`.
- If there is nothing to commit, just push directly.