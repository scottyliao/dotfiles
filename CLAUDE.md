# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is a [chezmoi](https://www.chezmoi.io/) source directory — the single source of truth for this user's dotfiles across machines. Files here are not used directly; chezmoi renders/copies them into their target locations in the home directory according to its file-naming convention. Do not edit files in the target locations (e.g. `~/.config/emacs/init.el`) expecting changes to persist — always edit the source files in this repo, then apply.

## chezmoi naming convention (source → target)

| source prefix/pattern   | target behavior                                              |
|--------------------------|----------------------------------------------------------------|
| `dot_foo`                | becomes `~/.foo`                                               |
| `readonly_Documents`     | becomes `~/Documents`, applied read-only where supported       |
| `run_once_*.ps1` (in `.chezmoiscripts/`) | script chezmoi runs once (tracked by content hash), not copied as a dotfile |
| `.chezmoiignore`         | patterns chezmoi should never manage/apply, supports Go templates (e.g. `{{- if ne .chezmoi.os "windows" }}`) |

Concretely in this repo:

- `dot_claude/` → `~/.claude/` — global Claude Code config (`CLAUDE.md`, `skills/`)
- `dot_config/emacs/` → `~/.config/emacs/` (via `XDG_CONFIG_HOME`) — Emacs configuration
- `dot_gitconfig` → `~/.gitconfig`
- `readonly_Documents/PowerShell/Microsoft.PowerShell_profile.ps1` → the user's PowerShell profile
- `.chezmoiscripts/run_once_configure-windows-env.ps1` → one-time setup script (sets `HOME`/`XDG_CONFIG_HOME` env vars on Windows so XDG-style paths work)

`.chezmoiignore` excludes the Windows-only setup script on non-Windows machines, and excludes Emacs runtime/generated directories (`elpa/`, `eln-cache/`, `backups/`, `autosaves/`, `auto-save-list/`, `transient/`, `recentf`, `history`, `places`) from being tracked or clobbered.

**Important distinction:** `dot_claude/CLAUDE.md` is a *managed dotfile* — it deploys to `~/.claude/CLAUDE.md` and contains instructions for Claude Code globally on this user's machine. This file (the repo root `CLAUDE.md`) is *not* deployed anywhere; it exists only to guide Claude Code when working inside this chezmoi source repo itself. Don't confuse the two, and don't duplicate content between them — if a instruction is about global Claude Code behavior, it belongs in `dot_claude/CLAUDE.md`.

## Common commands

Run from inside this source directory (or use `chezmoi cd` to jump here from anywhere):

```powershell
chezmoi diff                  # preview what would change on disk before applying
chezmoi apply                 # render and copy source files to their target locations
chezmoi apply -v              # verbose apply (shows each file written)
chezmoi status                # show which target files differ from source
chezmoi execute-template < file  # test a Go template snippet against chezmoi data
chezmoi cd                    # open a shell in the source directory
```

There is no build, lint, or test suite in this repo — it is plain configuration/scripts. Validate changes by running `chezmoi diff` and, for Emacs changes, actually starting Emacs to confirm `init.el` loads without error.

## Emacs configuration architecture

`dot_config/emacs/` follows the standard `early-init.el` / `init.el` / `lisp/init-*.el` split:

- **`early-init.el`** runs before the UI initializes — package.el startup, frame chrome (menu/tool/scroll bars), initial frame size/font, and GC threshold are set here specifically because setting them later causes a visible resize/flash.
- **`init.el`** owns package management bootstrap (`package.el` + `use-package`), restores the GC threshold raised in `early-init.el`, sets UTF-8 encoding, and loads each `lisp/init-*.el` module in a fixed order via `dolist`.
- **`lisp/init-*.el`** are topic-scoped modules, each ending with `(provide 'init-xxx)`:
  - `init-ui.el` — chrome/UI toggles (line numbers, paren matching, etc.)
  - `init-editing.el` — editing defaults, backup/autosave file locations
  - `init-completion.el` — minibuffer completion stack (vertico/orderless/marginalia/consult) + in-buffer completion (corfu) + session history (savehist/recentf/saveplace)
  - `init-dev.el` — LSP (eglot), project.el, magit, treemacs
  - `init-dashboard.el` — startup dashboard (nerd-icons + dashboard package)

When adding a new concern, prefer adding it to the matching existing module over creating a new one; only add a new `lisp/init-*.el` module for a genuinely new topic area, and register it in the `dolist` in `init.el`.

## Working conventions

Global git commit and push conventions (Conventional Commits with emoji, push workflow) are defined once in `~/.claude/CLAUDE.md` (source: `dot_claude/CLAUDE.md`) and apply here as everywhere else — see that file rather than duplicating its rules.
