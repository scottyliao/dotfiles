\---

description: Explore the current project and generate a README.md based on the shared template

allowed-tools: Read, Glob, Grep, Bash(ls:\*), Bash(git log:\*)

\---



You are generating a README.md for the project in the current working directory.



\## Step 1 — Understand the project



Before writing anything, explore the project to understand what it actually does:

\- Read the main config/manifest file (e.g. `package.json`, `pyproject.toml`, `go.mod`, `\*.csproj`, `Cargo.toml`) to identify the language, framework, and dependencies.

\- Skim the entry point / main source files to understand the project's purpose.

\- Check for existing scripts (build, test, dev, start) to know the real commands to document.

\- Note any environment variables or config files actually used in the code.



Do not guess or invent details — only document what you can verify from the project itself.



\## Step 2 — Read the template



Read the shared template at:



@\~/.claude/templates/README\_TEMPLATE.md



Use its section structure as the skeleton for the output.



\## Step 3 — Write README.md



Write (or overwrite) `README.md` in the project root, filling in each template section with real information gathered in Step 1:

\- Replace placeholder text with the actual project name, description, and features.

\- List real installation and usage commands found in the project.

\- Only include a Configuration table if the project actually reads environment variables.

\- Keep the same concise structure as the template — do not add extra sections unless the project genuinely needs them (e.g. a CLI project may need a "Commands" section instead of "Usage").



Show the user a brief summary of what was written and ask if anything needs adjustment.



