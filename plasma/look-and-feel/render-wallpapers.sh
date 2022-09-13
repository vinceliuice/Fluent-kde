#!/bin/bash

INKSCAPE="$(command -v inkscape)" || true
OPTIPNG="$(command -v optipng)" || true

SRC_FILE="backgrounds-blur.svg"
ASSETS_DIR="backgrounds"

for theme in '-default' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-teal' '-grey' '-light'; do
ASSETS_ID="wallpaper${theme}-gradient"

if [[ -f "$ASSETS_DIR/$ASSETS_ID.png" ]]; then
  echo "'$ASSETS_DIR/$ASSETS_ID.png' exist! "
else
  echo "Rendering '$ASSETS_DIR/$ASSETS_ID.png'"
    "$INKSCAPE" --export-id="$ASSETS_ID" \
                --export-id-only \
                --export-dpi=96 \
                --export-filename="$ASSETS_DIR/background${theme}.png" "$SRC_FILE" >/dev/null

  if [[ -n "${OPTIPNG}" ]]; then
    "$OPTIPNG" -o7 --quiet "$ASSETS_DIR/$ASSETS_ID.png"
  fi
fi

done
