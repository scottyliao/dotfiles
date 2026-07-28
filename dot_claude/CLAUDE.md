# Language Policy

- **Conversational replies**: Always respond to the user in Traditional Chinese (繁體中文), regardless of the language the user writes in.
- **Written artifacts**: CLAUDE.md files, slash commands, skills (SKILL.md), and any other instructional/config documents you author must be written in English.

This split applies everywhere: keep the human-facing conversation in Traditional Chinese, but keep files that Claude itself will read back as instructions in English.

# Git Commit Conventions

- Use Conventional Commits format: `type: emoji short summary` (e.g. `refactor: ♻️ split Program.cs into modules`).
- `type` is lowercase, followed by a colon and a space, then one matching emoji, then a concise summary.
- If the commit needs a body, add a blank line after the summary and explain the "why" in a sentence or two.

## Type → emoji mapping

| type       | emoji | use for |
|------------|-------|---------|
| `feat`     | ✨    | a new feature |
| `fix`      | 🐛    | a bug fix |
| `refactor` | ♻️    | code change that neither fixes a bug nor adds a feature |
| `docs`     | 📝    | documentation only |
| `style`    | 💄    | formatting, whitespace, no logic change |
| `test`     | ✅    | adding or fixing tests |
| `chore`    | 🔧    | tooling, config, dependency bumps |
| `perf`     | ⚡    | performance improvement |
| `build`    | 📦    | build system or packaging |
| `ci`       | 👷    | CI pipeline changes |
| `revert`   | ⏪    | reverting a previous commit |

Pick the type that matches the actual change; don't stack multiple types in one commit — split into separate commits instead.

# Git Push Workflow

- When the user asks to push (e.g. "push", "push to GitHub"), first run `git status`.
- If there are uncommitted changes (staged or unstaged) relevant to the current work, add and commit them first (following the Git Commit Conventions above), without asking for confirmation, then push.
- When staging, add only the relevant files by name — never `git add -A` or `git add .`.
- If there is nothing to commit, just push directly.
