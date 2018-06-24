#! /bin/sh

_shell_state="$(set +o | grep -v -e '+o')"
set -eu

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


lgbg_call=${GBG_CALL:-}
lgbg_file="./god_bless_git.sh"
if [ -z "${lgbg_call}" ]; then # Try to guess call type (invokation vs. sourcing)
    if [ -n "${ZSH_VERSION:-}" ]; then # Z Shell
        lgbg_eval_context="${ZSH_EVAL_CONTEXT:-}"
        if [ \
            "$(echo "${lgbg_eval_context}" | rev | cut -d: -f1 | rev)" = \
            "file" ]; then
            lgbg_call="source"
        else
            lgbg_call="invoke"
        fi
        lgbg_file="$0"
        unset lgbg_eval_context
    elif [ -n "${BASH_VERSION:-}" ]; then # Bash
        if [ "$(basename "${0:-}")" = "god_bless_git.sh" ]; then
            lgbg_call="invoke"
            lgbg_file="$0"
        else
            lgbg_call="source"
            # shellcheck disable=SC2039
            lgbg_file="${BASH_SOURCE[0]}"
        fi
    else # Other shells
        if [ "$(basename "${0:-}")" = "god_bless_git.sh" ]; then
            lgbg_call="invoke"
            lgbg_file="$0"
        else
            lgbg_call="source"
        fi
    fi
fi

GBG_DIR="${GBG_DIR:-$(get_absolute_dirname "${lgbg_file}")}"
if [ ! -r "${GBG_DIR}/god_bless_git.sh" ]; then
    echo "Unable to get God Bless Git base directory." >&2
    echo "Please define the GBG_DIR environment variable" \
        "to the base directory, before invoking script." >&2
else
    # shellcheck source=./lib/main.sh
    . "${GBG_DIR}/lib/main.sh"

    if [ "${lgbg_call}" = "invoke" ]; then
        # Script invoked as command
        _gbg_git_info
        set | grep -a --color=NEVER -e "^gbg_.*=..*$"
    elif [ "${lgbg_call}" = "source" ]; then
        god_bless_git() {
            _gbg_git_info
        }
        export god_bless_git
        export GBG_DIR
        export GBG_VERSION="0.0.10"
    else
        echo "Unable to determine invokation type." >&2
    fi
fi

unset get_absolute_dirname
unset lgbg_file
unset lgbg_call

set +eu
eval "${_shell_state}"
unset shell_state

