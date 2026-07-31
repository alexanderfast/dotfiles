# Trello — Inbox (NOT API-accessible)

**Do not try to add/read the Trello Inbox via the REST API — it does not work
with this auth.** This file exists so the limitation isn't rediscovered the hard
way.

## What the Inbox is

The Inbox is Trello's personal, private quick-capture space in the left sidebar
(separate from Boards/Planner). It is member-level, not part of any board, and not
shared with anyone. It is a different thing from the `📥 Backlog` **list** on the
🗓️ Weekly Workflow board (that list is where the skill's normal "add to trello"
cards go — see `reference/cards.md`).

## Why there's no recipe (verified 2026-07-29)

The Inbox IDs are visible on the member object:

```bash
curl -s -G "https://api.trello.com/1/members/me" \
  --data-urlencode "fields=inbox" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" | jq
# => { "inbox": { "idBoard": "...", "idList": "6a68b6c1...", "idOrganization": "..." } }
```

…but every attempt to actually use it is rejected at the permission layer with a
Power-Up token (scope `read,write`):

| Attempt | Result |
|---|---|
| `POST /1/cards` with `idList=<inbox list>` | **401** unauthorized card permission |
| `GET /1/lists/<inbox list>/cards` | **401** unauthorized permission |
| `GET /1/members/me/inbox` | **401** unauthorized member permission |
| `GET`/`POST /1/members/me/inbox/cards` | **404** no such endpoint |

The Inbox is a first-party/system surface served by internal APIs the official
Trello clients use; the public REST API + Power-Up tokens can see its IDs but
cannot read or write it. No known scope on a Power-Up token unlocks it.

## The only working alternative (not implemented)

Trello supports **email-to-Inbox**: each account has a private address
(Trello → Settings → Inbox) that drops emailed items into the Inbox. This could be
driven via the connected Gmail if ever wanted — but it's indirect (goes through
email) and needs that private address. Not wired up; ask the user before building
it.

## Bottom line

For quick capture, use the normal card-create flow into `📥 Backlog`
(`reference/cards.md`). Treat the Inbox as out of scope for the API.
