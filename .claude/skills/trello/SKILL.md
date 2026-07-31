---
name: trello
description: >-
  Create, search, and manage Trello from the shell via Trello's REST API (curl).
  Use whenever the user wants to add/capture something to Trello, search or look
  up cards (including by label), move cards between lists, comment on a card, set
  a due date, manage labels (create/recolor/rename/delete and assign to cards), or
  create/list boards and lists. Detailed recipes live in reference/ — read the
  relevant file before running commands.
---

# Trello

Shell access to the user's Trello (account `alexanderfast`) via the REST API.
Credentials + board config live in `~/.config/trello/creds.env` (per-machine,
mode 600). This file stays small on purpose; open the reference file for the task
at hand.

## Before any operation

Load credentials at the top of every command block:

```bash
set -a; source ~/.config/trello/creds.env; set +a
```

If the file is missing, or `TRELLO_API_KEY` / `TRELLO_TOKEN` are empty or still a
`PASTE_..._HERE` placeholder, stop and follow `reference/setup.md`. **Never print
the key or token** into chat or logs.

## Board guardrail (always applies)

- **Default / personal** board = **🗓️ Weekly Workflow** (`$TRELLO_DEFAULT_BOARD_ID`);
  new cards default to its **📥 Backlog** list (`$TRELLO_DEFAULT_LIST_ID`).
- **Shared with wife** board = **My Trello board** (`$TRELLO_SHARED_BOARD_ID`).
  Never create or modify anything on the shared board unless the user names it
  explicitly. If a request is ambiguous about which board, ask first.

Any write (card, list, comment, etc.) targets the default board unless the user
is explicit — this rule overrides whatever a reference recipe shows as the target.

## Recipes — read the file before running

| Task | File |
|------|------|
| Auth, `creds.env` layout, set up a new machine, revoke token | `reference/setup.md` |
| Create / move / comment / due date / archive a **card** | `reference/cards.md` |
| List / create / archive / rename **lists** | `reference/lists.md` |
| Manage **labels** (create/color/rename/delete, assign to cards, search by label) | `reference/labels.md` |
| List **boards**, list a board's lists | `reference/boards.md` |
| **Search** cards | `reference/search.md` |
| The Trello **Inbox** (and why it's not API-accessible) | `reference/inbox.md` |

Conventions used by every recipe: `curl --data-urlencode` for all fields (safe for
spaces/symbols), and `key=$TRELLO_API_KEY` / `token=$TRELLO_TOKEN` for auth. Pipe
through `jq` for readable output; if `jq` is absent (rare), parse the raw JSON.

## Maintaining this skill

When adding or removing a capability:
1. Add/edit the recipe in a `reference/*.md` file.
2. Add or update its row in the table above.
3. **Update the `description` frontmatter** to name the capability — the
   description is the only thing loaded *before* the skill triggers, so a
   capability that isn't mentioned there may fail to make the skill fire at all.
4. Redeploy to the nuc: `scp -r ~/.claude/skills/trello/. nuc:.claude/skills/trello/`.
