# Trello — search

Every block assumes creds are loaded:

```bash
set -a; source ~/.config/trello/creds.env; set +a
```

## Search the default board (normal case)

```bash
curl -s -G "https://api.trello.com/1/search" \
  --data-urlencode "query=<terms>" \
  --data-urlencode "idBoards=$TRELLO_DEFAULT_BOARD_ID" \
  --data-urlencode "modelTypes=cards" \
  --data-urlencode "card_fields=name,url,due,idList" \
  --data-urlencode "cards_limit=20" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r 'if (.cards|length)>0 then (.cards[]|"\(.name)  —  \(.url)") else "no results" end'
```

## Search all boards

Only when the user explicitly asks to search everything — drop the `idBoards`
line above.

## Notes

- A **just-created** card takes a few seconds to appear in the search index. To
  confirm a fresh card immediately, list the board's cards instead
  (`reference/boards.md`).
- Trello query supports operators, e.g. `query=due:week`, `query=label:red`,
  `query=name:"exact phrase"`, `query=@me`. Pass them inside the `query` value.
- `modelTypes` can also include `boards` and `organizations`; add matching
  `board_fields` / limits as needed.
