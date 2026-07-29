# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/), primarily targeting Windows.

## Contents

| Source path | Deploys to | Description |
|---|---|---|
| `dot_claude/` | `~/.claude/` | Global Claude Code config: `CLAUDE.md` and custom skills |
| `dot_config/emacs/` | `~/.config/emacs/` | Emacs configuration (`early-init.el`, `init.el`, `lisp/init-*.el` modules) |
| `dot_gitconfig` | `~/.gitconfig` | Git user identity |
| `readonly_Documents/PowerShell/Microsoft.PowerShell_profile.ps1` | PowerShell profile | Helper functions (e.g. `Clear-AgentHistory`) |
| `.chezmoiscripts/run_once_configure-windows-env.ps1` | — | One-time script that sets `HOME` and `XDG_CONFIG_HOME` on Windows |
| `.chezmoiignore` | — | Excludes the Windows-only setup script on non-Windows machines, and excludes Emacs runtime/generated files from being tracked |

## Setup

Install chezmoi, then initialize from this repo:

```powershell
chezmoi init --apply <git-remote-url>
```

If chezmoi is already initialized against this repo, pull and apply updates with:

```powershell
chezmoi update
```

## Usage

```powershell
chezmoi diff      # preview changes before applying
chezmoi apply     # apply source files to their target locations
chezmoi status    # show which target files differ from source
chezmoi cd         # open a shell in this source directory
```

Edit files here (the source directory), not the deployed copies in the home directory — running `chezmoi apply` overwrites the latter.

## Emacs configuration

Emacs config lives under `dot_config/emacs/` and follows the standard `early-init.el` / `init.el` / `lisp/init-*.el` split:

- `early-init.el` — settings that must run before the UI initializes (frame chrome, GC threshold, initial frame size/font)
- `init.el` — package management bootstrap (`use-package`) and module loading
- `lisp/init-ui.el` — UI toggles
- `lisp/init-editing.el` — editing defaults, backup/autosave locations
- `lisp/init-completion.el` — minibuffer and in-buffer completion (vertico, orderless, marginalia, consult, corfu)
- `lisp/init-dev.el` — LSP (eglot), project.el, magit, treemacs
- `lisp/init-dashboard.el` — startup dashboard

## License

Personal configuration files; no license specified.
