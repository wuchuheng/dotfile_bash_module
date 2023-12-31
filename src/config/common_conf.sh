#!/bin/bash

DOTFILES_CLI_PATH=src/cli

GLOBAL_OS=''

#define global generic boolean values.
TRUE=0
FALSE=1

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  OS=$(cat /etc/os-release | grep NAME= | awk 'NR == 1 {print $0}' |  sed -n 's/NAME="\([^"]*\)".*/\1/p')
  case ${OS} in
    'Ubuntu'|PRETTY_Ubuntu*)
        GLOBAL_OS='Ubuntu';
    ;;
    'CentOS Linux')
        GLOBAL_OS='CentOS';
    ;;
    *)
      throw "Unknown OS: $OS"
    ;;
  esac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  GLOBAL_OS="MacOS"
fi

# printf "%s\n" "${GLOBAL_OS}"

if [[ "$GLOBAL_OS" == "" ]]; then
  throw "Unknown OS: $OSTYPE"
fi
