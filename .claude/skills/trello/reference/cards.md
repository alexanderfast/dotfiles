# Trello — cards

Every block assumes creds are loaded:

```bash
set -a; source ~/.config/trello/creds.env; set +a
```

Respect the board guardrail in `SKILL.md`: new cards go to the default Backlog
unless the user names another list/board.

## Create a card

`name` = title, `desc` = optional body. Optional: `due` (ISO 8601), `pos=top`.

```bash
curl -s -X POST "https://api.trello.com/1/cards" \
  --data-urlencode "idList=$TRELLO_DEFAULT_LIST_ID" \
  --data-urlencode "name=<card title>" \
  --data-urlencode "desc=<optional description>" \
  --data-urlencode "key=$TRELLO_API_KEY" \
  --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Created: \(.name)\n\(.shortUrl)"'
```

To target a different list, get its ID from `reference/lists.md` and swap
`idList`.

## Find a card's ID

Search (`reference/search.md`) returns URLs; the short code is in the URL. To get
the full id from a card URL:

```bash
curl -s -G "https://api.trello.com/1/cards/<SHORT_OR_FULL_ID>" \
  --data-urlencode "fields=id,name,idList,idBoard" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" | jq
```

## Move a card to another list

```bash
curl -s -X PUT "https://api.trello.com/1/cards/<CARD_ID>/idList" \
  --data-urlencode "value=<TARGET_LIST_ID>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Moved: \(.name)"'
```

Moving across boards also needs `--data-urlencode "idBoard=<BOARD_ID>"` on the
same call (and the guardrail applies if that board is the shared one).

## Comment on a card

```bash
curl -s -X POST "https://api.trello.com/1/cards/<CARD_ID>/actions/comments" \
  --data-urlencode "text=<comment>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Commented on \(.data.card.name)"'
```

## Read comments on a card

```bash
curl -s -G "https://api.trello.com/1/cards/<CARD_ID>/actions" \
  --data-urlencode "filter=commentCard" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.date) \(.memberCreator.fullName): \(.data.text)"'
```

## Set / change a due date

`value` is ISO 8601 (e.g. `2026-08-01T17:00:00Z`). Send an empty value to clear.

```bash
curl -s -X PUT "https://api.trello.com/1/cards/<CARD_ID>/due" \
  --data-urlencode "value=2026-08-01T17:00:00Z" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Due set: \(.name) -> \(.due)"'
```

Mark complete/incomplete with the `dueComplete` field:
`-X PUT ".../1/cards/<CARD_ID>" --data-urlencode "dueComplete=true"`.

## Archive (close) a card

```bash
curl -s -X PUT "https://api.trello.com/1/cards/<CARD_ID>/closed" \
  --data-urlencode "value=true" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Archived: \(.name)"'
```

To delete permanently (irreversible — prefer archiving; ask the user first):
`-X DELETE "https://api.trello.com/1/cards/<CARD_ID>?key=..&token=.."`.
