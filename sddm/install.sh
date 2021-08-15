#!/bin/bash

ROOT_UID=0
THEME_DIR="/usr/share/sddm/themes"
REO_DIR="$(cd $(dirname $0) && pwd)"
THEME_VARIANTS=('' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey' '-round')

MAX_DELAY=20                                  # max delay for user to enter root password

#COLORS
CDEF=" \033[0m"                               # default color
CCIN=" \033[0;36m"                            # info color
CGSC=" \033[0;32m"                            # success color
CRER=" \033[0;31m"                            # error color
CWAR=" \033[0;33m"                            # waring color
b_CDEF=" \033[1;37m"                          # bold default color
b_CCIN=" \033[1;36m"                          # bold info color
b_CGSC=" \033[1;32m"                          # bold success color
b_CRER=" \033[1;31m"                          # bold error color
b_CWAR=" \033[1;33m"                          # bold warning color

# echo like ...  with  flag type  and display message  colors
prompt() {
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

while [[ "$#" -gt 0 ]]; do
  case "${1:-}" in
    -t|--theme)
      shift
      for theme in "$@"; do
        case "$theme" in
          default)
            themes+=("${THEME_VARIANTS[0]}")
            theme_color="#0078D4"
            shift
            ;;
          purple)
            themes+=("${THEME_VARIANTS[1]}")
            theme_color="#AB47BC"
            shift
            ;;
          pink)
            themes+=("${THEME_VARIANTS[2]}")
            theme_color="#EC407A"
            shift
            ;;
          red)
            themes+=("${THEME_VARIANTS[3]}")
            theme_color="#E53935"
            shift
            ;;
          orange)
            themes+=("${THEME_VARIANTS[4]}")
            theme_color="#F57C00"
            shift
            ;;
          yellow)
            themes+=("${THEME_VARIANTS[5]}")
            theme_color="#FBC02D"
            shift
            ;;
          green)
            themes+=("${THEME_VARIANTS[6]}")
            theme_color="#4CAF50"
            shift
            ;;
          grey)
            themes+=("${THEME_VARIANTS[7]}")
            theme_color="#616161"
            shift
            ;;
          round)
            themes+=("${THEME_VARIANTS[8]}")
            theme_color="#0078D4"
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized theme variant '$1'."
            echo "Try '$0 --help' for more information."
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

usage() {
  cat << EOF
Usage: $0 [OPTION]...

OPTIONS:
  -t, --theme VARIANT     Specify theme color variant(s) [default|purple|pink|red|orange|yellow|green|grey|all] (Default: blue)
  -h, --help              Show help
EOF
}

install() {
  local theme="$1"

# Checking for root access and proceed if it is present
if [[ "$UID" -eq "$ROOT_UID" ]]; then
  prompt -i "\n * Install Fluent${theme} in ${THEME_DIR}... "
  [[ -d "${THEME_DIR}/Fluent${theme}" ]] && rm -rf "${THEME_DIR}/Fluent${theme}"
  cp -rf "${REO_DIR}/Fluent" "${THEME_DIR}/Fluent${theme}"
  cp -rf "${REO_DIR}/backgrounds/background${theme}.png" "${THEME_DIR}/Fluent${theme}/background.png"
  if [[ "${theme}" != '' ]]; then
    sed -i "s/#0078D4/${theme_color}/g" "${THEME_DIR}/Fluent${theme}/Login.qml"
    sed -i "s/#0078D4/${theme_color}/g" "${THEME_DIR}/Fluent${theme}/theme.conf"
  fi
  sed -i "s/Fluent/Fluent${theme}/g" "${THEME_DIR}/Fluent${theme}/metadata.desktop"
  # Success message
  prompt -s "\n * All done!"
else
  # Error message
  prompt -e "\n [ Error! ] -> Please Run me as root ! "
  exit 1
fi
}

if [[ "${#themes[@]}" -eq 0 ]] ; then
  themes=("${THEME_VARIANTS[0]}")
fi

for theme in "${themes[@]}"; do
  install "$theme"
done
