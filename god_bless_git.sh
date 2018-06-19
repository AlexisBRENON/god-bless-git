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

is_sourcing="false"
is_invoked="false"
if [ -n "${ZSH_VERSION}" ]; then # Z Shell
    if [ -n "${ZSH_ARGZERO:-}" ]; then
        is_sourcing="true"
        gbg_file="$0"
    else
        is_invoked="true"
        gbg_file="$0"
    fi
elif [ "$(basename "${SHELL:-}")" =  "bash" ]; then # Bash
    if [ "$(basename "${0:-}")" = "god_bless_git.sh" ]; then
        is_invoked="true"
        gbg_file="$0"
    else
        is_sourcing="true"
        # shellcheck disable=SC2039
        gbg_file="${BASH_SOURCE[0]}"
    fi
else # Other shells
    if [ "$(basename "${0:-}")" = "god_bless_git.sh" ]; then
        is_invoked="true"
        gbg_file="$0"
    else
        is_sourcing="true"
    fi
fi

GBG_DIR="${GBG_DIR:-$(get_absolute_dirname "${gbg_file}")}"
if [ ! -r "${GBG_DIR}/god_bless_git.sh" ]; then
    echo "Unable to get God Bless Git base directory." >&2
    echo "Please define the GBG_DIR environment variable" \
        "to the base directory, before invoking script." >&2
else
    # shellcheck source=./lib/main.sh
    . "${GBG_DIR}/lib/main.sh"

    if [ "${is_invoked}" = "true" ]; then
        # Script invoked as command
        _gbg_git_info
        set | grep -a -e "^gbg_.*=..*$"
    elif [ "${is_sourcing}" = "true" ]; then
        god_bless_git() {
            _gbg_git_info
        }
        export god_bless_git
        export GBG_DIR
    else
        echo "Unable to determine invokation type." >&2
    fi
fi

unset get_absolute_dirname
unset gbg_file
unset is_invoked
unset is_sourcing

