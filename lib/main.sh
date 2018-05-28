#! /bin/sh

# shellcheck source=./lib/repo.sh
. "${GBG_DIR}/lib/repo.sh"
# shellcheck source=./lib/head.sh
. "${GBG_DIR}/lib/head.sh"
# shellcheck source=./lib/workspace.sh
. "${GBG_DIR}/lib/workspace.sh"
# shellcheck source=./lib/index.sh
. "${GBG_DIR}/lib/index.sh"
# shellcheck source=./lib/upstream.sh
. "${GBG_DIR}/lib/upstream.sh"

gbg_git_info() {

    # Check that gbg is not disabled
    lgbg_enabled="$(git config --get gbg.enabled)"
    lgbg_disabled="$(git config --get gpg.disabled)"
    if [ "${lgbg_enabled}" = "false" ] || \
        [ "${lgbg_disabled}" = "true" ]; then
        # Unset previously defined gbg variables
        _gbg_clean_variables
    else
        _gbg_get_repo_status
        _gbg_get_head_status
        _gbg_get_workspace_status
        _gbg_get_index_status
        _gbg_get_upstream_status
    fi

    _gbg_clean_local_variables
}

_gbg_clean_local_variables() {
    gbg_local_variables="$(\
        set | \
        grep -a -E '^lgbg_.*=' | \
        cut -d'=' -f1 | \
        tr '\n' ' ')"
    eval "unset" "${gbg_local_variables}"
    unset gbg_local_variables
}

_gbg_clean_variables() {
    gbg_variables="$(\
        set | \
        grep -a -E '^gbg_.*=' | \
        grep -a -F -v 'gbg_git_info' | \
        cut -d'=' -f1 | \
        tr '\n' ' ')"
    eval "unset" "${gbg_variables}"
    unset gbg_variables
}

export gbg_git_info
