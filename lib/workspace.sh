#! /bin/sh

_gbg_get_workspace_status() {
    if [ "${gbg_is_a_git_repo:-}" = "true" ]; then
        lgbg_git_status="$(git status --porcelain --ignored 2> /dev/null)"

        lgbg_modifications_num=$(\
            echo "${lgbg_git_status}" | \
            grep -Ece '^.M')
        lgbg_has_modifications=$( \
            [ "${lgbg_modifications_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )

        lgbg_deletions_num=$(echo "${lgbg_git_status}" | grep -Ece '^.D')
        lgbg_has_deletions=$( \
            [ "${lgbg_deletions_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )

        lgbg_untracked_num=$(\
            echo "${lgbg_git_status}" | \
            grep -Ece '^\?\?')
        lgbg_has_untracked=$( \
            [ "${lgbg_untracked_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )

        lgbg_ignored_num=$(echo "${lgbg_git_status}" | grep -Ece '^!!')
        lgbg_has_ignored=$( \
            [ "${lgbg_ignored_num}" -gt 0 ] && \
            echo "true" || \
            echo "false" )
    fi

    gbg_workspace_modifications_num="${lgbg_modifications_num:-}"
    gbg_workspace_has_modifications="${lgbg_has_modifications:-}"
    gbg_workspace_deletions_num="${lgbg_deletions_num:-}"
    gbg_workspace_has_deletions="${lgbg_has_deletions:-}"
    gbg_workspace_untracked_num="${lgbg_untracked_num:-}"
    gbg_workspace_has_untracked="${lgbg_has_untracked:-}"
    gbg_workspace_ignored_num="${lgbg_ignored_num:-}"
    gbg_workspace_has_ignored="${lgbg_has_ignored:-}"

    export gbg_workspace_modifications_num
    export gbg_workspace_has_modifications
    export gbg_workspace_deletions_num
    export gbg_workspace_has_deletions
    export gbg_workspace_untracked_num
    export gbg_workspace_has_untracked
    export gbg_workspace_ignored_num
    export gbg_workspace_has_ignored
}
