# Trello — setup & credentials

## Where things live

`~/.config/trello/creds.env`, mode `600`, per-machine. **Never** sync it to git or
Obsidian. Currently deployed on the CachyOS desktop and the `nuc.lan` server.

```
TRELLO_API_KEY=...            # secret
TRELLO_TOKEN=...              # secret — full access to the whole account
TRELLO_DEFAULT_BOARD_ID=...   # 🗓️ Weekly Workflow (personal default)
TRELLO_DEFAULT_LIST_ID=...    # 📥 Backlog (default target for new cards)
TRELLO_SHARED_BOARD_ID=...    # My Trello board (shared with wife — guarded)
```

Load with `set -a; source ~/.config/trello/creds.env; set +a`. Never echo the key
or token.

## First-time auth (one-off, done manually in a browser)

1. Create a minimal Power-Up at https://trello.com/power-ups/admin → reveals the
   **API Key**.
2. Authorize a never-expiring read/write token (substitute the key):
   `https://trello.com/1/authorize?expiration=never&scope=read,write&response_type=token&name=Claude%20Code&key=YOUR_KEY`
   → **Allow** → copy the 64-char token.
3. Put both into `~/.config/trello/creds.env`.

The token is a full-account credential — treat it like a password. Revoke at
`https://trello.com/alexanderfast/account` → **Applications**.

## Verify auth

```bash
set -a; source ~/.config/trello/creds.env; set +a
curl -s "https://api.trello.com/1/members/me?fields=username,fullName&key=$TRELLO_API_KEY&token=$TRELLO_TOKEN" | jq
```

## Set up a new machine

The skill is just files. From a machine that already has it:

```bash
ssh NEWHOST 'mkdir -p ~/.claude/skills ~/.config/trello'
scp -r ~/.claude/skills/trello NEWHOST:.claude/skills/     # SKILL.md + reference/
scp    ~/.config/trello/creds.env NEWHOST:.config/trello/  # same account/token
ssh NEWHOST 'chmod 600 ~/.config/trello/creds.env'
```

`scp` keeps the token file-to-file (never through a shell echo). Requires `curl`
on the target (`jq` recommended). Board/list IDs are the same everywhere since
it's one account.

## Discover the IDs (if setting up fresh / re-pointing)

See `reference/boards.md` for listing boards and a board's lists, then write the
chosen IDs into `creds.env`.
