#!/bin/sh

SOCKET="$("$(dirname "$0")/socket")"
read -r CURRENT < "$SOCKET"

if [ "$CURRENT" = "$1" ]; then
    exit 0
fi

i3-msg "$(i3-msg -t get_workspaces | jq -r \
    -L "$(dirname "$0")" \
    --arg to "$1" \
'
    include "lib";

    .[] | select(.focused).name | parse_metaws | if .pin then
        ""
    else
        "move container to workspace \"\(make_name(.name; $to) | escape)\""
    end

')"
