# Trello — boards

Every block assumes creds are loaded:

```bash
set -a; source ~/.config/trello/creds.env; set +a
```

## List all open boards

```bash
curl -s -G "https://api.trello.com/1/members/me/boards" \
  --data-urlencode "filter=open" --data-urlencode "fields=name,url" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.id)  \(.name)"'
```

Known boards for this account:
- `🗓️ Weekly Workflow` — personal default (`$TRELLO_DEFAULT_BOARD_ID`)
- `My Trello board` — shared with wife (`$TRELLO_SHARED_BOARD_ID`, guarded)

## List the lists on a given board

```bash
curl -s -G "https://api.trello.com/1/boards/<BOARD_ID>/lists" \
  --data-urlencode "filter=open" --data-urlencode "fields=name" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.id)  \(.name)"'
```

## List cards on a board (no search index lag)

Useful right after creating a card, since `/search` takes a few seconds to index.

```bash
curl -s -G "https://api.trello.com/1/boards/<BOARD_ID>/cards" \
  --data-urlencode "filter=open" --data-urlencode "fields=name,url,idList" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.name)  —  \(.url)"'
```
