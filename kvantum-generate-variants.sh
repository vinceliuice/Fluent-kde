#! /usr/bin/env bash

SRC_DIR="$(cd $(dirname $0) && pwd)"

THEME_NAME=Fluent
DEFAULT_CODE='#0078D4'
THEME_VARIANTS=('-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey' '-teal')
THEME_CODES=('#AB47BC' '#EC407A' '#E53935' '#F57C00' '#FBC02D' '#4CAF50' '#616161' '#26a69a')

create_variant() {
  local theme="$1"
  local code="$2"
  local round="$3"
  local solid="$4"

  local src_name="${THEME_NAME}${round}${solid}"
  local src_dir="${SRC_DIR}/Kvantum/${src_name}"
  local dest_name="${THEME_NAME}${round}${theme}${solid}"
  local dest_dir="${SRC_DIR}/Kvantum/${dest_name}"

  rm -rf "$dest_dir"
  mkdir "$dest_dir"

  sed "s/${DEFAULT_CODE}/${code}/gI" "${src_dir}/${src_name}.kvconfig" > "${dest_dir}/${dest_name}.kvconfig"
  sed "s/${DEFAULT_CODE}/${code}/gI" "${src_dir}/${src_name}.svg" > "${dest_dir}/${dest_name}.svg"
  sed "s/${DEFAULT_CODE}/${code}/gI" "${src_dir}/${src_name}Dark.kvconfig" > "${dest_dir}/${dest_name}Dark.kvconfig"
  sed "s/${DEFAULT_CODE}/${code}/gI" "${src_dir}/${src_name}Dark.svg" > "${dest_dir}/${dest_name}Dark.svg"
}

for i in "${!THEME_VARIANTS[@]}"; do
  echo "Creating variant ${THEME_VARIANTS[$i]} (${THEME_CODES[$i]})"
  create_variant "${THEME_VARIANTS[$i]}" "${THEME_CODES[$i]}" "" ""
  create_variant "${THEME_VARIANTS[$i]}" "${THEME_CODES[$i]}" "" "-solid"
  create_variant "${THEME_VARIANTS[$i]}" "${THEME_CODES[$i]}" "-round" ""
  create_variant "${THEME_VARIANTS[$i]}" "${THEME_CODES[$i]}" "-round" "-solid"
done
