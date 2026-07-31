# Trello — lists

Every block assumes creds are loaded:

```bash
set -a; source ~/.config/trello/creds.env; set +a
```

Guardrail: create/modify lists on the default board only, unless the user names
the shared board.

## Show lists on the default board

```bash
curl -s -G "https://api.trello.com/1/boards/$TRELLO_DEFAULT_BOARD_ID/lists" \
  --data-urlencode "filter=open" --data-urlencode "fields=name" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.id)  \(.name)"'
```

(For another board, swap the board ID — see `reference/boards.md`.)

## Create a list

Defaults to the default board. `pos` can be `top`, `bottom`, or a number.

```bash
curl -s -X POST "https://api.trello.com/1/lists" \
  --data-urlencode "name=<list name>" \
  --data-urlencode "idBoard=$TRELLO_DEFAULT_BOARD_ID" \
  --data-urlencode "pos=bottom" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Created list: \(.name)  (\(.id))"'
```

## Rename a list

```bash
curl -s -X PUT "https://api.trello.com/1/lists/<LIST_ID>/name" \
  --data-urlencode "value=<new name>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Renamed to: \(.name)"'
```

## Archive / unarchive a list

Trello archives lists (no hard delete via API). `value=true` archives,
`value=false` restores.

```bash
curl -s -X PUT "https://api.trello.com/1/lists/<LIST_ID>/closed" \
  --data-urlencode "value=true" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Archived list: \(.name)"'
```
