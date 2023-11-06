#!/bin/bash

import @/src/utils/helper.sh
import @/src/utils/color_printf.sh

##
# throw exception
#
# @use throw "exception info"
# @echo #void
##
function throw() {
  local test_file=${BASH_SOURCE[1]}
  local current_file=${test_file:${prefix_path_len}}
  local line="${BASH_LINENO[0]}"
  printf "$(bg_red_print " EXCEPTION ") $(red_print "$1")\n"
  # print the part of codecc
  get_a_part_of_code ${current_file} ${line}
  # print the call stack
  local frame=1
  local frame_count=${#FUNCNAME[@]}
  while [ "${frame}" -lt "${frame_count}" ]; do
    local func="${FUNCNAME[${frame}]}"
    local stackLine="${BASH_LINENO[$((frame - 1))]}"
    local src="${BASH_SOURCE[${frame}]}"
    local src_file=${src:${prefix_path_len}}
    if [[ "${src_file:0:${#DOTFILES_BASE_PATH}}" == "${DOTFILES_BASE_PATH}"  ]]; then
      src_file=${src_file:${#DOTFILES_BASE_PATH} + 1}
    fi
    printf "    ${src_file}:${stackLine} ${func}\n"
    ((frame++))
  done
  exit 1
}

