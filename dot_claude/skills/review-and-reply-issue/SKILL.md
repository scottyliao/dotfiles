---
name: review-and-reply-issue
description: Compare local code changes against a GitHub issue in a user-specified repo, judge whether the fix is complete, and post a confirmation comment on the issue via the gh CLI; if the fix is incomplete, push back and ask the user to keep working. Use whenever the user says things like "review my code and reply to the issue", "I've fixed this issue, take a look", "check whether this change resolves the issue", or similar — in any language, including Chinese phrases such as「幫我審查程式碼並回覆/留言 issue」「這個 issue 我改好了幫我看一下」「幫我確認這次修改有沒有解決 issue」. If the user did not specify a repo, first read references/repos.md, list candidate repos, and ask; then list that repo's open issues and ask which one to review.
---

# Review and Reply Issue

Compare "local code changes" against "the problem described in a GitHub issue", judge whether the fix is complete, and then either post a confirmation comment directly on the corresponding issue via the `gh` CLI, or push back and ask the user to continue fixing.

## Prerequisites

- `gh` CLI installed and authenticated (verify with `gh auth status`)
- The user has write access to the target repo (required for commenting)

## Workflow

> **Context isolation**: Steps 1–2 must be resolved using only the message/arguments that triggered *this* run of the skill. Never reuse a repo or issue number mentioned earlier in the conversation for an unrelated purpose — prior turns are not a valid source. If the current invocation doesn't explicitly restate the repo/issue itself, treat it as unspecified and ask, even if something similar came up before.

### Step 1: Determine the repo

- If the user has explicitly specified a repo **in the message/arguments that invoked this skill** (in the format `owner/repo` or a name that can be inferred), use it directly.
- If the user has **not specified** a repo in this invocation:
  1. scottyliao/GearLinkAutomation
  2. scottyliao/asus-gammingacc-training
  3. GWGRepo/CodeReview_AacMouseHal
  4. GWGRepo/CodeReview_MsCompanion
  5. GWGRepo/CodeReview_KbCompanion
- List the repos above as a candidate list and ask the user which one to use (either via `ask_user_input_v0` or as a plain bulleted list, depending on the current interface's capabilities). Only proceed to the next step after the user has made a selection.

### Step 2: Determine the issue

- If the user has explicitly specified an issue number **in the message/arguments that invoked this skill**, use it directly.
- If the user has **not specified** an issue number in this invocation, ask them which issue number they want — even if an issue number was mentioned earlier in the conversation for a different purpose.
- Use the following command to view the issue's content:
   ```bash
   gh issue view <number> --repo <owner>/<repo>
   ```

### Step 3: Read and understand the local code changes

- Identify the files the user changed this time (via `git diff`, `git diff --staged`, or file paths the user points to directly)
- Read the before/after logic thoroughly and understand:
  - What was changed
  - Why it was changed that way
  - Whether it resolves the root cause described in the issue, not just the surface symptom

### Step 4: Compare the issue against the code and make a judgment

Go through every problem point mentioned in the issue and verify the code changes cover it and are sound. Check for:

- **Completeness**: Does every problem point in the issue have a corresponding change? Is anything missed?
- **Correctness**: Does the change genuinely fix the problem, rather than papering over it or introducing a new bug?
- **Side effects**: Could the change affect other behavior? Was existing logic modified unnecessarily?
- **Leftovers**: Is there anything the issue mentions that the code clearly does not address?

Based on the review, take one of two paths:

#### Case A: The fix is complete and sound → post a confirmation comment to conclude the discussion

1. Draft a comment following the "Comment template" below, concretely listing:
   - Which file(s) and line ranges were changed
   - Which problem in the issue each change resolves
   - A brief note on whether behavior before and after is consistent (e.g., only the defect was removed, existing functionality is unaffected)
2. **Show the full draft to the user for confirmation** and ask whether to post it
3. Only after the user confirms, run:
   ```bash
   gh issue comment <number> --repo <owner>/<repo> --body "<comment body>"
   ```

#### Case B: The fix is incomplete or questionable → push back

1. **Do not comment** — do not run any `gh issue comment`
2. Tell the user clearly:
   - Which problems mentioned in the issue are **still unresolved**
   - Or where the change is **logically flawed and needs adjustment**
   - Concrete suggestions for how to fix it
3. Ask whether they want to keep working on it now, or rerun this skill later

> Decision rule: whenever "the issue clearly mentions a problem that wasn't addressed", "the change introduces new concerns", or "a logic change looks like it alters existing behavior without explanation", lean toward Case B rather than rushing to comment and close. When unsure, ask the user instead of deciding unilaterally.

## Comment template

Write the comment in the following format. The comment itself is posted in Traditional Chinese — replace the details with the actual changes, but keep this structure and tone:

```markdown
## 修復確認
已完成修復，變更如下（`<檔案名稱>:<起始行>-<結束行>`）：
- <修改項目 1，具體描述改了什麼、解決了什麼問題>
- <修改項目 2，如有多項逐條列出>
已比對修改前後的邏輯，行為與原先一致，僅<簡述變更範圍，例如：移除記憶體配置與死碼>，可視為此 issue 已解決。
```

If the changes span multiple files or multiple problem points, adjust the number of bullet items as needed, but **keep the overall structure of the「## 修復確認」heading + bulleted changes + closing confirmation sentence**.

## Safety rules

- **Always show the comment to the user for confirmation before running `gh issue comment`** — never post without confirmation
- If the fix is judged incomplete, never comment, and never embellish the description to hide unresolved problems just to finish the task
- If anything about the issue or the scope of the code changes is unclear (e.g., a referenced file cannot be found, or the diff is empty), clarify with the user first — do not assume