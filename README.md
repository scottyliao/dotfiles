# dotfiles

Personal dotfiles for Windows, managed with [chezmoi](https://www.chezmoi.io/). Covers Git, Emacs, PowerShell, and Claude Code configuration.

## Requirements

- [chezmoi](https://www.chezmoi.io/install/)
- Windows (the setup script targets Windows-specific environment variables)
- Git

## Installation

```bash
chezmoi init --apply git@github.com:scottyliao/dotfiles.git
```

If the repo is already checked out as the chezmoi source directory:

```bash
chezmoi apply
```

On first run, `.chezmoiscripts/run_once_configure-windows-env.ps1` sets the `HOME` and `XDG_CONFIG_HOME` user environment variables — restart your terminal/session afterward for the change to take effect.

## Contents

- `dot_gitconfig` — Git user identity
- `dot_config/emacs/` — modular Emacs configuration; `init.el` loads `lisp/init-ui.el`, `init-editing.el`, `init-completion.el`, `init-dev.el`, and `init-dashboard.el`
- `dot_claude/` — Claude Code configuration: global `CLAUDE.md` instructions, custom slash commands (`/push`, `/create-readme-file`), skills (e.g. `review-and-reply-issue`), and shared templates (`README_TEMPLATE.md`)
- `readonly_Documents/PowerShell/Microsoft.PowerShell_profile.ps1` — PowerShell profile providing a `Clear-AgentHistory` helper that clears Claude Code / Copilot session history and PSReadLine data
- `.chezmoiscripts/run_once_configure-windows-env.ps1` — one-time Windows environment setup script
- `.chezmoiignore` — files excluded from chezmoi management (Emacs runtime/cache directories; the Windows setup script when targeting non-Windows)

## Usage

```bash
chezmoi diff          # preview pending changes before applying
chezmoi apply          # apply the dotfiles to the target machine
chezmoi cd             # open a shell in the source directory
chezmoi edit <file>    # edit a managed file and re-apply
```
