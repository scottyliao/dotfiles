---
description: Explore the current project and generate or update a README.md based on the shared template
allowed-tools: Read, Glob, Grep, Bash(ls:*), Bash(git log:*)
---

You are generating or updating a README.md for the project in the current working directory.

## Step 1 — Check for an existing README

Check whether `README.md` already exists in the project root.
- If it exists, read it fully — this is the baseline you will update, not replace.
- If it does not exist, you are creating one from scratch (skip ahead — there is no baseline to preserve).

## Step 2 — Understand the project

Before writing anything, explore the project to understand what it actually does:
- Read the main config/manifest file (e.g. `package.json`, `pyproject.toml`, `go.mod`, `*.csproj`, `Cargo.toml`) to identify the language, framework, and dependencies.
- Skim the entry point / main source files to understand the project's purpose.
- Check for existing scripts (build, test, dev, start) to know the real commands to document.
- Note any environment variables or config files actually used in the code.

Do not guess or invent details — only document what you can verify from the project itself.

## Step 3 — Read the template

Read the shared template at:

@~/.claude/templates/README_TEMPLATE.md

Use its section structure as a reference.
- If no README.md existed, use the template as the skeleton for the output.
- If a README.md already existed, use the template only as a structural reference — keep the existing README's section order, tone, and any project-specific sections it already has beyond the template, unless they are now inaccurate.

## Step 4 — Write README.md

- If no README.md existed: write a new one, filling in each template section with real information gathered in Step 2.
- If README.md already existed: update it in place —
  - Correct or refresh any section whose content no longer matches the project (stale commands, outdated feature list, wrong dependencies, etc.), based on what you verified in Step 2.
  - Leave sections that are still accurate unchanged — don't rewrite content that doesn't need to change.
  - Keep existing sections that go beyond the template (e.g. "Known limitations", "Project structure") unless they're outdated.
  - Only add sections from the template that are missing and genuinely apply to this project.
- In both cases:
  - Replace any placeholder text with the actual project name, description, and features.
  - List real installation and usage commands found in the project.
  - Only include a Configuration table if the project actually reads environment variables.
  - Keep the structure concise — do not add extra sections unless the project genuinely needs them (e.g. a CLI project may need a "Commands" section instead of "Usage").

Show the user a brief summary of what was written or changed, and ask if anything needs adjustment.
