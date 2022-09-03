#!/bin/bash

INKSCAPE="$(command -v inkscape)" || true
OPTIPNG="$(command -v optipng)" || true

SRC_FILE="Fluent-lnf.svg"

for round in '' '-round'; do
for theme in '' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey' '-teal'; do
for color in '-light' '-dark'; do

  preview_id="preview${round}${theme}${color}"
  splash_id="splash${round}${theme}"
  preview_dir="com.github.vinceliuice.Fluent${round}${theme}${color}/contents/previews"

  echo "Rendering '${preview_id}'"
  "$INKSCAPE" --export-id="${preview_id}" \
              --export-id-only \
              --export-dpi=96 \
              --export-filename="${preview_dir}/preview.png" "$SRC_FILE" >/dev/null

  echo "Rendering '${splash_id}'"
  "$INKSCAPE" --export-id="${splash_id}" \
              --export-id-only \
              --export-dpi=96 \
              --export-filename="${preview_dir}/splash.png" "$SRC_FILE" >/dev/null
done
done
done

for round in '' '-round'; do
  preview_id="preview${round}"
  preview_dir="com.github.vinceliuice.Fluent${round}/contents/previews"
  echo "Rendering '${splash_id}'"
  "$INKSCAPE" --export-id="${splash_id}" \
              --export-id-only \
              --export-dpi=96 \
              --export-filename="${preview_dir}/splash.png" "$SRC_FILE" >/dev/null
done
