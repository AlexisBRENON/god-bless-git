#! /bin/sh

get_absolute_dirname() {
  SOURCE="$1"
  while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [ "$SOURCE" != "/*" ] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
  ( cd -P "$( dirname "$SOURCE" )" && pwd )
  unset DIR
  unset SOURCE
}

GBG_DIR=""
while [ ! -e "${GBG_DIR}/god-bless-git.plugin.zsh" ] ; do
  GBG_DIR="$(get_absolute_dirname "$1")"
  shift
done

export GBG_DIR
. "${GBG_DIR}/lib/main.sh"

unset get_absolute_dirname
