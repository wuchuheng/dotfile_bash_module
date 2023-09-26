#!/usr/bin/env bash

current_dir="$(dirname "${BASH_SOURCE[0]}")"
DOTFILES_BASE_PATH="$(dirname "${current_dir}")"
source "${DOTFILES_BASE_PATH}"/src/utils/autoload.sh || exit 1
