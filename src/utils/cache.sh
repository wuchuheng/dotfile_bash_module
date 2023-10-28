#!/usr/bin/env bash

import ./load_env.sh # {get_env}

##
# get keyCacheFile
# @Use _getKeyCacheFile "<key>"
# @Return <String>
##
function _getKeyCacheFile() {
  local key="$1"
  local runtimeDir=$(get_env "RUNTIME_DIR" "${DOTFILES_BASE_PATH}/src/runtime")
  local cacheDir=${runtimeDir}/keyCache
  if [[ ! -d ${cacheDir} ]]; then
    mkdir -p "${cacheDir}"
  fi
  local cacheFile=${cacheDir}/${key}.cache
  echo "${cacheFile}"
}

##
# to cache a string value with a key
# @Use save_cache "<key>" "<value>"
# @Return <Boolean>
##
function save_cache() {
  local key="$1"
  local value="$2"
  local cache_file=$(_getKeyCacheFile "$key")
  echo "$value" > "$cache_file"

  return "${TRUE}"
}

##
# to get a cached string value with a key
# @Use get_cache "<key>"
# @Echo "<String>"
##
function get_cache() {
  local key="$1"
  local cache_file=$(_getKeyCacheFile "$key")
  cat "${cache_file}"
}