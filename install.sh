#!/bin/bash

SRC_DIR=$(cd $(dirname $0) && pwd)

# Destination directory
AURORAE_DIR="$HOME/.local/share/aurorae/themes"
SCHEMES_DIR="$HOME/.local/share/color-schemes"
PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
KVANTUM_DIR="$HOME/.config/Kvantum"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
PLASMOIDS_DIR="$HOME/.local/share/plasma/plasmoids"
LAYOUT_DIR="$HOME/.local/share/plasma/layout-templates"

THEME_NAME=Fluent

[[ ! -d ${AURORAE_DIR} ]] && mkdir -p ${AURORAE_DIR}
[[ ! -d ${SCHEMES_DIR} ]] && mkdir -p ${SCHEMES_DIR}
[[ ! -d ${PLASMA_DIR} ]] && mkdir -p ${PLASMA_DIR}
[[ ! -d ${LOOKFEEL_DIR} ]] && mkdir -p ${LOOKFEEL_DIR}
[[ ! -d ${KVANTUM_DIR} ]] && mkdir -p ${KVANTUM_DIR}
[[ ! -d ${WALLPAPER_DIR} ]] && mkdir -p ${WALLPAPER_DIR}
[[ ! -d ${PLASMOIDS_DIR} ]] && mkdir -p ${PLASMOIDS_DIR}
[[ ! -d ${LAYOUT_DIR} ]] && mkdir -p ${LAYOUT_DIR}

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
}

install() {
  local name=${1}

  [[ -d ${AURORAE_DIR}/${name} ]] && rm -rf ${AURORAE_DIR}/${name}*
  [[ -d ${PLASMA_DIR}/${name} ]] && rm -rf ${PLASMA_DIR}/${name}*
  [[ -f ${SCHEMES_DIR}/${name}.colors ]] && rm -rf ${SCHEMES_DIR}/${name}*.colors
  [[ -d ${LOOKFEEL_DIR}/com.github.vinceliuice.${name} ]] && rm -rf ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}*
  [[ -d ${KVANTUM_DIR}/${name} ]] && rm -rf ${KVANTUM_DIR}/${name}*
  [[ -d ${WALLPAPER_DIR}/${name} ]] && rm -rf ${WALLPAPER_DIR}/${name}

  cp -r ${SRC_DIR}/aurorae/*                                                          ${AURORAE_DIR}
  cp -r ${SRC_DIR}/color-schemes/*.colors                                             ${SCHEMES_DIR}
  cp -r ${SRC_DIR}/Kvantum/*                                                          ${KVANTUM_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent                                         ${PLASMA_DIR}
  cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent                                         ${PLASMA_DIR}/${name}-light
  cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent-light/widgets/*.svgz                    ${PLASMA_DIR}/${name}-light/widgets
  sed -i "s|Name=Fluent|Name=${name}-light|"                                          ${PLASMA_DIR}/${name}-light/metadata.desktop
  cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent                                         ${PLASMA_DIR}/${name}-dark
  sed -i "s|Name=Fluent|Name=${name}-dark|"                                           ${PLASMA_DIR}/${name}-dark/metadata.desktop
  cp -r ${SRC_DIR}/color-schemes/FluentLight.colors                                   ${PLASMA_DIR}/${name}-light/colors
  cp -r ${SRC_DIR}/color-schemes/FluentDark.colors                                    ${PLASMA_DIR}/${name}-dark/colors
  cp -r ${SRC_DIR}/plasma/look-and-feel/*                                             ${LOOKFEEL_DIR}
  cp -r ${SRC_DIR}/wallpaper/*                                                        ${WALLPAPER_DIR}
  cp -ur ${SRC_DIR}/plasma/plasmoids/*                                                ${PLASMOIDS_DIR}
  cp -ur ${SRC_DIR}/plasma/layout-templates/*                                         ${LAYOUT_DIR}
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -n|--name)
      name="${1}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      prompt -e "ERROR: Unrecognized installation option '$1'."
      prompt -i "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

echo "Installing '${THEME_NAME} kde themes'..."

install "${name:-${THEME_NAME}}"

echo "Install finished..."
