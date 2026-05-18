#!/usr/bin/env bash
# nix-deps: wireplumber jq
# control active window pipewire volume with niri binds
if [[ -z "$1" ]]; then
  echo "Control active window volume in niri"
  echo "Usage: nirivol 5%-|5%+|toggle"
  exit 0
fi

pidtree() {
  declare -A CHILDS
  while read -r P PP; do
    CHILDS[$PP]+=" $P"
  done < <(ps -e -o pid= -o ppid=)
  walk() {
    echo "$1"
    for i in ${CHILDS[$1]}; do
      walk "$i"
    done
  }
  for i in "$@"; do
    walk "$i"
  done
}

setvol() {
  for ID in "$@"; do
    if [ "$CMD" == "toggle" ]; then
      wpctl set-mute "$ID" toggle &
    else
      wpctl set-volume -l 1.5 "$ID" "$CMD" &
    fi
  done
}

CMD="$*"
ACTIVE=$(niri msg --json focused-window)
DUMP=$(pw-dump | jq '[
  .[] | select(.type == "PipeWire:Interface:Node" or .type == "PipeWire:Interface:Client") | {
    id:     .id,
    client: .info.props["client.id"],
    type:   .type,
    name:   .info.props["media.name"],
    class:  .info.props["media.class"],
    pid:    .info.props["application.process.id"]
  }
]')

# try window title match first (catches individual firefox tabs etc.)
TITLE=$(echo "$ACTIVE" | jq -r .title)
TITLE=${TITLE% —*}

mapfile -t IDS < <(echo "$DUMP" | jq -r --arg t "$TITLE" \
  '.[] | select(.type == "PipeWire:Interface:Node" and .name == $t) | .id')

if [ "${#IDS[@]}" -gt 0 ]; then
  setvol "${IDS[@]}"
else
  WINDOW_PID=$(echo "$ACTIVE" | jq -r .pid)
  while IFS= read -r CPID; do
    mapfile -t CLIENTS < <(echo "$DUMP" | jq -r --argjson p "$CPID" \
      '.[] | select(.type == "PipeWire:Interface:Client" and .pid == ($p | tostring)) | .id')
    for CLIENT in "${CLIENTS[@]}"; do
      mapfile -t IDS < <(echo "$DUMP" | jq -r --arg c "$CLIENT" \
        '.[] | select(.type == "PipeWire:Interface:Node" and .class == "Stream/Output/Audio" and .client == $c) | .id')
      setvol "${IDS[@]}"
    done
  done < <(pidtree "$WINDOW_PID")
fi