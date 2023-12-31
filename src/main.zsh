#!/bin/zsh

DOTFILES_BASE_PATH=/Users/wuchuheng/myProjects/wuchuheng/dotfiles/src/vendor/dotfile_zsh_module/src/vendor/dotfile_bash_module
source /Users/wuchuheng/myProjects/wuchuheng/dotfiles/src/vendor/dotfile_zsh_module/src/vendor/dotfile_bash_module/src/zsh_toolbox/autoload.zsh || exit

## Autoload CLI 
cli_dir_list=($(get_all_sub_dir_by_path "${DOTFILES_BASE_PATH}/src/cli"))
for directory in "${cli_dir_list[@]}"; do
  IFS="_" read -r parts <<< "$directory"
  number=${parts[0]}
  number=$((${#number} + 1))
  cli_name="${directory:$number}"
  installer=/src/cli/$directory/${cli_name}_installer/${cli_name}_installer.sh
  import @$(get_cli_to_env_provider_by_cli_directory_name $directory)
done
## Autoload CLI 
cli_dir_list=($(get_all_sub_dir_by_path "${DOTFILES_BASE_PATH}/src/cli"))
for directory in "${cli_dir_list[@]}"; do
  IFS="_" read -r parts <<< "$directory"
  number=${parts[0]}
  number=$((${#number} + 1))
  cli_name="${directory:$number}"
  installer=/src/cli/$directory/${cli_name}_installer/${cli_name}_installer.sh
  import @$(get_cli_to_env_provider_by_cli_directory_name $directory)
done
