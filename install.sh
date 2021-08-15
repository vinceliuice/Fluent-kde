#!/bin/bash

SRC_DIR="$(cd $(dirname $0) && pwd)"

THEME_NAME=Fluent
THEME_VARIANTS=('' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey')
CTHEME_VARIANTS=('' 'Purple' 'Pink' 'Red' 'Orange' 'Yellow' 'Green' 'Grey')
COLOR_VARIANTS=('' '-light' '-dark')
ROUND_VARIANTS=('' '-round')

# Destination directory
AURORAE_DIR="$HOME/.local/share/aurorae/themes"
SCHEMES_DIR="$HOME/.local/share/color-schemes"
PLASMA_DIR="$HOME/.local/share/plasma/desktoptheme"
LOOKFEEL_DIR="$HOME/.local/share/plasma/look-and-feel"
KVANTUM_DIR="$HOME/.config/Kvantum"
WALLPAPER_DIR="$HOME/.local/share/wallpapers"
PLASMOIDS_DIR="$HOME/.local/share/plasma/plasmoids"
LAYOUT_DIR="$HOME/.local/share/plasma/layout-templates"

# COLORS
CDEF=" \033[0m"                                     # default color
CCIN=" \033[0;36m"                                  # info color
CGSC=" \033[0;32m"                                  # success color
CRER=" \033[0;31m"                                  # error color
CWAR=" \033[0;33m"                                  # warning color
b_CDEF=" \033[1;37m"                                # bold default color
b_CCIN=" \033[1;36m"                                # bold info color
b_CGSC=" \033[1;32m"                                # bold success color
b_CRER=" \033[1;31m"                                # bold error color
b_CWAR=" \033[1;33m"                                # bold warning color

# Echo like ... with flag type and display message colors
prompt () {
  case ${1} in
    "-s"|"--success")
      echo -e "${b_CGSC}${@/-s/}${CDEF}";;    # print success message
    "-e"|"--error")
      echo -e "${b_CRER}${@/-e/}${CDEF}";;    # print error message
    "-w"|"--warning")
      echo -e "${b_CWAR}${@/-w/}${CDEF}";;    # print warning message
    "-i"|"--info")
      echo -e "${b_CCIN}${@/-i/}${CDEF}";;    # print info message
    *)
    echo -e "$@"
    ;;
  esac
}

usage() {
  cat << EOF
Usage: $0 [OPTION]...

OPTIONS:
  -n, --name NAME         Specify theme name (Default: $THEME_NAME)
  -t, --theme VARIANT     Specify theme color variant(s) [default|purple|pink|red|orange|yellow|green|grey|all] (Default: blue)
  -c, --color VARIANT     Specify color variant(s) [standard|light|dark] (Default: All variants)s)
  --round VARIANT         Specify round variant
  -h, --help              Show help
EOF
}

[[ ! -d ${AURORAE_DIR} ]] && mkdir -p ${AURORAE_DIR}
[[ ! -d ${SCHEMES_DIR} ]] && mkdir -p ${SCHEMES_DIR}
[[ ! -d ${PLASMA_DIR} ]] && mkdir -p ${PLASMA_DIR}
[[ ! -d ${LOOKFEEL_DIR} ]] && mkdir -p ${LOOKFEEL_DIR}
[[ ! -d ${KVANTUM_DIR} ]] && mkdir -p ${KVANTUM_DIR}
[[ ! -d ${WALLPAPER_DIR} ]] && mkdir -p ${WALLPAPER_DIR}
[[ ! -d ${PLASMOIDS_DIR} ]] && mkdir -p ${PLASMOIDS_DIR}
[[ ! -d ${LAYOUT_DIR} ]] && mkdir -p ${LAYOUT_DIR}

install() {
  local name="$1"
  local theme="$2"
  local color="$3"

  case "${theme}" in
    -purple)
      ctheme='Purple'
      ;;
    -pink)
      ctheme='Pink'
      ;;
    -red)
      ctheme='Red'
      ;;
    -orange)
      ctheme='Orange'
      ;;
    -yellow)
      ctheme='Yellow'
      ;;
    -green)
      ctheme='Green'
      ;;
    -grey)
      ctheme='Grey'
      ;;
    *)
      ctheme=''
      ;;
  esac

  case "${color}" in
    -light)
      ccolor='Light'
      ;;
    -dark)
      ccolor='Dark'
      ;;
    *)
      ccolor=''
      ;;
  esac

  [[ "$color" == '-dark' ]] && local ELSE_DARK="$color"
  [[ "$color" == '-light' ]] && local ELSE_LIGHT="$color"

  [[ -d ${AURORAE_DIR}/${name}${round}${color} ]]                                      && rm -rf ${AURORAE_DIR}/${name}${round}${color}
  [[ -d ${PLASMA_DIR}/${name}${round}${theme}${color} ]]                               && rm -rf ${PLASMA_DIR}/${name}${round}${theme}${color}
  [[ -f ${SCHEMES_DIR}/${name}${ctheme}${ccolor}.colors ]]                             && rm -rf ${name}${ctheme}${ccolor}.colors
  [[ -d ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color} ]]      && rm -rf ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}
  [[ -d ${KVANTUM_DIR}/${name}${theme} ]]                                              && rm -rf ${KVANTUM_DIR}/${name}${theme}
  [[ -d ${WALLPAPER_DIR}/${name}${theme} ]]                                            && rm -rf ${WALLPAPER_DIR}/${name}${theme}
  [[ -d ${WALLPAPER_DIR}/${name}${round}${color} ]]                                    && rm -rf ${WALLPAPER_DIR}/${name}${round}${color}

  cp -r ${SRC_DIR}/aurorae/${name}${round}${color}                                     ${AURORAE_DIR}
  cp -r ${SRC_DIR}/wallpaper/${name}${theme}                                           ${WALLPAPER_DIR}

  if [[ "$round" == '-round' ]]; then
    cp -r ${SRC_DIR}/wallpaper/${name}${round}${color}                                 ${WALLPAPER_DIR}
  fi

  mkdir -p                                                                             ${KVANTUM_DIR}/${name}${theme}
  cp -r ${SRC_DIR}/Kvantum/Fluent${theme}/*                                            ${KVANTUM_DIR}/${name}${theme}

  if [[ "$color" != '' ]]; then
    cp -r ${SRC_DIR}/color-schemes/${name}${ctheme}${ccolor}.colors                    ${SCHEMES_DIR}
    cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${round}${theme}${color} ${LOOKFEEL_DIR}

    mkdir -p                                                                           ${PLASMA_DIR}/${name}${round}${theme}${color}
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}/*                              ${PLASMA_DIR}/${name}${round}${theme}${color}
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}${ELSE_LIGHT}/dialogs/*.svgz    ${PLASMA_DIR}/${name}${round}${theme}${color}/dialogs
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}${ELSE_LIGHT}/widgets/*.svgz    ${PLASMA_DIR}/${name}${round}${theme}${color}/widgets
    sed -i "s|Name=Fluent${round}|Name=${name}${round}${theme}${color}|"               ${PLASMA_DIR}/${name}${round}${theme}${color}/metadata.desktop
    if [[ "$theme" != '' ]]; then
      sed -i "s|defaultWallpaperTheme=Fluent|defaultWallpaperTheme=Fluent${theme}|"    ${PLASMA_DIR}/${name}${round}${theme}${color}/metadata.desktop
    fi
    cp -r ${SRC_DIR}/color-schemes/Fluent${ctheme}${ccolor}.colors                     ${PLASMA_DIR}/${name}${round}${theme}${color}/colors
  else
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}                                ${PLASMA_DIR}/${name}${round}
    cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${round}       ${LOOKFEEL_DIR}
  fi

  if [[ "$round" == '-round' ]]; then
    sed -i "s|defaultWallpaperTheme=Fluent|defaultWallpaperTheme=Fluent${round}${color}|" ${PLASMA_DIR}/${name}${round}${theme}${color}/metadata.desktop
  fi
}

install_common() {
  cp -r ${SRC_DIR}/plasma/plasmoids/*                                                  ${PLASMOIDS_DIR}
  cp -r ${SRC_DIR}/plasma/layout-templates/*                                           ${LAYOUT_DIR}
  cp -r ${SRC_DIR}/Kvantum/Fluent-round                                                ${KVANTUM_DIR}
}

while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -n|--name)
      name="${1}"
      shift
      ;;
    --round)
      roundconer='true'
      shift
      ;;
    -t|--theme)
      shift
      for theme in "$@"; do
        case "$theme" in
          default)
            themes+=("${THEME_VARIANTS[0]}")
            shift
            ;;
          purple)
            themes+=("${THEME_VARIANTS[1]}")
            shift
            ;;
          pink)
            themes+=("${THEME_VARIANTS[2]}")
            shift
            ;;
          red)
            themes+=("${THEME_VARIANTS[3]}")
            shift
            ;;
          orange)
            themes+=("${THEME_VARIANTS[4]}")
            shift
            ;;
          yellow)
            themes+=("${THEME_VARIANTS[5]}")
            shift
            ;;
          green)
            themes+=("${THEME_VARIANTS[6]}")
            shift
            ;;
          grey)
            themes+=("${THEME_VARIANTS[7]}")
            shift
            ;;
          all)
            themes+=("${THEME_VARIANTS[@]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            prompt -e "ERROR: Unrecognized theme variant '$1'."
            prompt -i "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
        prompt -w "${theme} version"
      done
      ;;
    -c|--color)
      shift
      for variant in "$@"; do
        case "$variant" in
          standard)
            colors+=("${COLOR_VARIANTS[0]}")
            shift
            ;;
          light)
            colors+=("${COLOR_VARIANTS[1]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[2]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            prompt -e "ERROR: Unrecognized color variant '$1'."
            prompt -i "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
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

if [[ "${#themes[@]}" -eq 0 ]] ; then
  themes=("${THEME_VARIANTS[0]}")
fi

if [[ "${#colors[@]}" -eq 0 ]] ; then
  colors=("${COLOR_VARIANTS[@]}")
fi

if [[ "${#cthemes[@]}" -eq 0 ]] ; then
  cthemes=("${CTHEME_VARIANTS[0]}")
fi

if [[ "${roundconer:-}" == 'true' ]] ; then
  round=("${ROUND_VARIANTS[1]}")
  else
  round=("${ROUND_VARIANTS[0]}")
fi

prompt -i "Installing '${THEME_NAME}${round} kde themes'..."

for theme in "${themes[@]}"; do
  for color in "${colors[@]}"; do
    install "${_name:-$THEME_NAME}" "$theme" "$color"
  done
done

install_common

prompt -s "Install finished..."
