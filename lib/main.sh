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
    enabled="$(git config --get gbg.enabled)"
    disabled="$(git config --get gpg.disabled)"
    if [ "${enabled}" = "false" ] || \
        [ "${disabled}" = "true" ]; then
        # Unset previously defined gbg variables
        gbg_variables="$(\
            set | \
            grep -E '^gbg_.*=' | \
            grep -F -v 'gbg_git_info' | \
            cut -d'=' -f1)"
        for variable in ${gbg_variables}; do
            eval "unset" "${variable}"
        done
        unset gbg_variables
    else
        _gbg_get_repo_status
        _gbg_get_head_status
        _gbg_get_workspace_status
        _gbg_get_index_status
        _gbg_get_upstream_status
    fi
    unset enabled
    unset disabled
}

export gbg_git_info
