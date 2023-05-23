#!/bin/bash

SRC_DIR="$(cd $(dirname $0) && pwd)"

THEME_NAME=Fluent
THEME_VARIANTS=('' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey' '-teal')
CTHEME_VARIANTS=('' 'Purple' 'Pink' 'Red' 'Orange' 'Yellow' 'Green' 'Grey' 'Teal')
COLOR_VARIANTS=('' '-light' '-dark')

round=
solid=

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
  -t, --theme VARIANT     Specify theme color variant(s) [default|purple|pink|red|orange|yellow|green|grey|teal|all] (Default: blue)
  -c, --color VARIANT     Specify color variant(s) [standard|light|dark] (Default: All variants)s)
  --round VARIANT         Specify round variant
  --solid VARIANT         Specify solid variant
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

cp -rf "${SRC_DIR}"/configs/Xresources "$HOME"/.Xresources

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
    -teal)
      ctheme='Teal'
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

  [[ -d ${AURORAE_DIR}/${name}${round}${color}${solid} ]]                              && rm -rf ${AURORAE_DIR}/${name}${round}${color}${solid}
  [[ -d ${AURORAE_DIR}/${name}-round${color}{'','-normal'} ]]                          && rm -rf ${AURORAE_DIR}/${name}${round}${color}{'','-normal'}
  [[ -d ${PLASMA_DIR}/${name}${round}${theme}${color}${solid} ]]                       && rm -rf ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}
  [[ -f ${SCHEMES_DIR}/${name}${ctheme}${ccolor}.colors ]]                             && rm -rf ${name}${ctheme}${ccolor}.colors
  [[ -d ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid} ]] && rm -rf ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}
  [[ -d ${KVANTUM_DIR}/${name}${round}${theme}${solid} ]]                              && rm -rf ${KVANTUM_DIR}/${name}${round}${theme}${solid}
  [[ -d ${WALLPAPER_DIR}/${name}${theme} ]]                                            && rm -rf ${WALLPAPER_DIR}/${name}${theme}
  [[ -d ${WALLPAPER_DIR}/${name}${round}${color} ]]                                    && rm -rf ${WALLPAPER_DIR}/${name}${round}${color}


  if [[ "$round" == '-round' ]]; then
    cp -r ${SRC_DIR}/aurorae/${name}${round}${color}${solid}                           ${AURORAE_DIR}
    cp -r ${SRC_DIR}/aurorae/${name}${round}${color}-normal                            ${AURORAE_DIR}
  else
    cp -r ${SRC_DIR}/aurorae/${name}${color}                                           ${AURORAE_DIR}
  fi

  cp -r ${SRC_DIR}/wallpaper/${name}${theme}                                           ${WALLPAPER_DIR}

  if [[ "$round" == '-round' ]]; then
    cp -r ${SRC_DIR}/wallpaper/${name}${round}${color}                                 ${WALLPAPER_DIR}
  fi

  mkdir -p                                                                             ${KVANTUM_DIR}/${name}${round}${theme}${solid}
  cp -r ${SRC_DIR}/Kvantum/Fluent${round}${theme}${solid}/*                            ${KVANTUM_DIR}/${name}${round}${theme}${solid}

  if [[ "$color" != '' ]]; then
    cp -r ${SRC_DIR}/color-schemes/${name}${ctheme}${ccolor}.colors                    ${SCHEMES_DIR}
    mkdir -p                                                                           ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}
    cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${round}${theme}${color}/* ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}

    mkdir -p                                                                           ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}/*                              ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}${ELSE_LIGHT}/dialogs/*.svgz    ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/dialogs
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}${ELSE_LIGHT}/widgets/*.svgz    ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/widgets
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}${ELSE_LIGHT}/translucent/*     ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/translucent

    if [[ "$theme" != '' ]]; then
      sed -i "s|defaultWallpaperTheme=Fluent|defaultWallpaperTheme=Fluent${theme}|"    ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/metadata.desktop
    fi

    cp -r ${SRC_DIR}/color-schemes/Fluent${ctheme}${ccolor}.colors                     ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/colors
  else
    mkdir -p                                                                           ${PLASMA_DIR}/${name}${round}${solid}
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}/*                              ${PLASMA_DIR}/${name}${round}${solid}
    mkdir -p                                                                           ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${solid}
    cp -r ${SRC_DIR}/plasma/look-and-feel/com.github.vinceliuice.${name}${round}/*     ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${solid}
  fi

  sed -i "s|Name=Fluent${round}|Name=${name}${round}${theme}${color}${solid}|"         ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/metadata.desktop

  if [[ "$solid" == '-solid' ]]; then
    # plasma theme
    cp -r ${SRC_DIR}/plasma/desktoptheme/Fluent${round}${ELSE_LIGHT}${solid}/*         ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}
    sed -i "s|enabled=true|enabled=false|"                                             ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/metadata.desktop
    rm -rf ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/{solid,translucent}
    # global theme
    sed -i "s|Name=${name}${round}${theme}${color}|Name=${name}${round}${theme}${color}${solid}|" ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}/metadata.desktop
    sed -i "s|Name=com.github.vinceliuice.${name}${round}${theme}${color}|Name=com.github.vinceliuice.${name}${round}${theme}${color}${solid}|" ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}/metadata.desktop
    if [[ "$round" == '-round' ]]; then
      sed -i "s|theme=__aurorae__svg__${name}${round}${color}|theme=__aurorae__svg__${name}${round}${color}${solid}|" ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}/contents/defaults
    fi
    sed -i "s|name=${name}${round}${theme}${color}|name=${name}${round}${theme}${color}${solid}|" ${LOOKFEEL_DIR}/com.github.vinceliuice.${name}${round}${theme}${color}${solid}/contents/defaults
  fi

  if [[ "$round" == '-round' ]]; then
    sed -i "s|defaultWallpaperTheme=Fluent|defaultWallpaperTheme=Fluent${round}${color}|" ${PLASMA_DIR}/${name}${round}${theme}${color}${solid}/metadata.desktop
  fi
}

install_common() {
  cp -r ${SRC_DIR}/plasma/plasmoids/*                                                  ${PLASMOIDS_DIR}
  cp -r ${SRC_DIR}/plasma/layout-templates/*                                           ${LAYOUT_DIR}
  cp -r ${SRC_DIR}/Kvantum/Fluent-round${solid}                                        ${KVANTUM_DIR}
}

while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -n|--name)
      name="${1}"
      shift
      ;;
    --round)
      round='-round'
      prompt -i "Install rounded version."
      shift
      ;;
    --solid)
      solid='-solid'
      prompt -i "Install solid version."
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
          teal)
            themes+=("${THEME_VARIANTS[8]}")
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

prompt -i "Installing '${THEME_NAME}${round} kde themes'..."

for theme in "${themes[@]}"; do
  for color in "${colors[@]}"; do
    install "${_name:-$THEME_NAME}" "$theme" "$color"
  done
done

install_common

prompt -s "Install finished..."
