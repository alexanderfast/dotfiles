# Trello — labels

Every block assumes creds are loaded:

```bash
set -a; source ~/.config/trello/creds.env; set +a
```

Labels are **board-scoped**: each board defines its own set (name + color), and
cards reference them by id. Guardrail (see `SKILL.md`): create/edit/delete labels
on the default board only, unless the user names the shared board.

Current labels on the 🗓️ Weekly Workflow board: `Priority` (red), `Personal`
(green), `Time Block` (blue), `Milestone` (purple), `Quick Win` (yellow). Always
list them fresh (below) to get current ids — ids are needed for assign/search.

## List a board's labels

```bash
curl -s -G "https://api.trello.com/1/boards/$TRELLO_DEFAULT_BOARD_ID/labels" \
  --data-urlencode "fields=name,color" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.id)  \(.name // "(no name)")  [\(.color // "none")]"'
```

## Create a label

Valid colors: `green yellow orange red purple blue sky lime pink black` (Trello
also accepts `_light`/`_dark` shade suffixes, e.g. `blue_dark`). Pass an empty
`color` for a colorless label.

```bash
curl -s -X POST "https://api.trello.com/1/labels" \
  --data-urlencode "name=<label name>" \
  --data-urlencode "color=<color>" \
  --data-urlencode "idBoard=$TRELLO_DEFAULT_BOARD_ID" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Created label: \(.name) [\(.color // "none")]  (\(.id))"'
```

## Rename a label

```bash
curl -s -X PUT "https://api.trello.com/1/labels/<LABEL_ID>/name" \
  --data-urlencode "value=<new name>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"Renamed: \(.name)"'
```

## Change a label's color

`value` is one of the colors above; send an empty value to remove the color.

```bash
curl -s -X PUT "https://api.trello.com/1/labels/<LABEL_ID>/color" \
  --data-urlencode "value=<color>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '"\(.name) -> \(.color // "none")"'
```

## Delete a label

Irreversible, and it removes the label from **every** card on the board. Confirm
with the user first.

```bash
curl -s -X DELETE "https://api.trello.com/1/labels/<LABEL_ID>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  -o /dev/null -w "deleted label HTTP %{http_code}\n"
```

## Assign / unassign a label on a card

Get the label id from "List a board's labels" and the card id from
`reference/cards.md` or search.

```bash
# assign
curl -s -X POST "https://api.trello.com/1/cards/<CARD_ID>/idLabels" \
  --data-urlencode "value=<LABEL_ID>" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  -o /dev/null -w "assign HTTP %{http_code}\n"

# unassign
curl -s -X DELETE "https://api.trello.com/1/cards/<CARD_ID>/idLabels/<LABEL_ID>?key=$TRELLO_API_KEY&token=$TRELLO_TOKEN" \
  -o /dev/null -w "unassign HTTP %{http_code}\n"
```

## Show the labels on a card

```bash
curl -s -G "https://api.trello.com/1/cards/<CARD_ID>/labels" \
  --data-urlencode "fields=name,color" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r '.[] | "\(.name) [\(.color // "none")]"'
```

## Search cards by label

**Preferred (lag-free):** filter the board's cards by label id. Works immediately,
even for labels/cards just changed. First get the label id from the list above,
then:

```bash
LABEL_ID=<label id>
curl -s -G "https://api.trello.com/1/boards/$TRELLO_DEFAULT_BOARD_ID/cards" \
  --data-urlencode "filter=open" --data-urlencode "fields=name,url,idLabels" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r --arg L "$LABEL_ID" '.[] | select(.idLabels | index($L)) | "\(.name)  —  \(.url)"'
```

**Search operator (subject to a few seconds' index lag):** Trello search supports
`label:` with a name or color.

```bash
curl -s -G "https://api.trello.com/1/search" \
  --data-urlencode "query=label:red" \
  --data-urlencode "idBoards=$TRELLO_DEFAULT_BOARD_ID" \
  --data-urlencode "modelTypes=cards" --data-urlencode "card_fields=name,url" \
  --data-urlencode "key=$TRELLO_API_KEY" --data-urlencode "token=$TRELLO_TOKEN" \
  | jq -r 'if (.cards|length)>0 then (.cards[]|"\(.name)  —  \(.url)") else "no results (index may be lagging; use the board-cards filter above)" end'
```

For a multi-word label name use `label:"Time Block"`. Combine with other terms,
e.g. `query=label:red @me`.
