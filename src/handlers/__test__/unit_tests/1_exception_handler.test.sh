#!/bin/bash

import @/src/utils/test_except.sh

function throw_test() {
  local result=$( (throw "hello") ); local line="${LINENO}"
  local current_file=${BASH_SOURCE[0]}
  local except_value="$(bg_red_print ' EXCEPTION ') $(red_print 'hello')"
  local file_part_of_code=$(get_a_part_of_code "${current_file}" "${line}")
  local frame=1
  local frame_count=${#FUNCNAME[@]}
  local callstack="    ${current_file:${#DOTFILES_BASE_PATH} + 1}:${line} throw_test"
  while [ "${frame}" -lt "${frame_count}" ]; do
    local func="${FUNCNAME[${frame}]}"
    local stackLine="${BASH_LINENO[$((frame - 1))]}"
    local src_file="${BASH_SOURCE[${frame}]}"
    if [[ "${src_file:0:${#DOTFILES_BASE_PATH}}" == "${DOTFILES_BASE_PATH}"  ]]; then
      src_file=${src_file:${#DOTFILES_BASE_PATH} + 1}
    fi
    if [[ -z "${callstack}" ]]; then
  callstack=$(cat <<EOF
    ${src_file}:${stackLine} ${func}
EOF
)
    else
  callstack=$(cat <<EOF
${callstack}
    ${src_file}:${stackLine} ${func}
EOF
)
    fi
    ((frame++))
  done
  except_value=$(cat <<EOF
${except_value}
${file_part_of_code}
${callstack}
EOF
)
  local BASE_PATH=$(get_runtime_space_by_unit_test_name ${global_test_name})
  cat > "${BASE_PATH}/except_value" << EOF
  ${except_value}
EOF
  cat > "${BASE_PATH}/result_value" << EOF
  ${result}
EOF
   except_str "${except_value}" "${result}"
}

handle_testing_callback "throw_test" "To throw function" 
