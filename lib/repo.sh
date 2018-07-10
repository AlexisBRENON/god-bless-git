#! /usr/bin/env sh

_gbg_get_repo_status() {
    gbg_is_a_git_repo="$(\
        git rev-parse --is-inside-work-tree 2> /dev/null || \
        echo "false" )"

    if [ "${gbg_is_a_git_repo}" = "true" ]; then
        lgbg_git_dir="$(\
            git rev-parse --absolute-git-dir \
            2> /dev/null)"
        lgbg_git_top_level="$(\
            git rev-parse --show-toplevel \
            2> /dev/null)"

        lgbg_number_of_logs="$(\
            git log --pretty=oneline \
            2> /dev/null | \
            wc -l || true)"
        lgbg_repo_just_init="$( \
            [ "${lgbg_number_of_logs}" -eq 0 ] && \
            echo "true" || \
            echo "false")"

        lgbg_number_of_stashes="$(\
            git stash list \
            2> /dev/null | \
            wc -l || true)"
        lgbg_has_stashes="$( \
            [ "${lgbg_number_of_stashes}" -gt 0 ] && \
            echo "true" || \
            echo "false" )"

        lgbg_number_of_conflicts="$(\
            git ls-files --unmerged \
            2> /dev/null | \
            cut -f2 | sort -u | \
            wc -l || true)"
        lgbg_has_conflicts="$( \
            [ "${lgbg_number_of_conflicts}" -gt 0 ] && \
            echo "true" || \
            echo "false" )"

        lgbg_pending_action_type="$(\
          _gbg_repo_get_pending_action \
          "${lgbg_git_dir}")"
        lgbg_has_pending_action="$( \
            [ -n "${lgbg_pending_action_type}" ] && \
            echo "true" || \
            echo "false" )"
    fi

    gbg_repo_git_dir="${lgbg_git_dir:-}"
    gbg_repo_top_level="${lgbg_git_top_level:-}"
    gbg_repo_just_init="${lgbg_repo_just_init:-}"
    gbg_repo_stashes_num="${lgbg_number_of_stashes:-}"
    gbg_repo_has_stashes="${lgbg_has_stashes:-}"
    gbg_repo_conflicts_num="${lgbg_number_of_conflicts:-}"
    gbg_repo_has_conflicts="${lgbg_has_conflicts:-}"
    gbg_repo_pending_action_type="${lgbg_pending_action_type:-}"
    gbg_repo_has_pending_action="${lgbg_has_pending_action:-}"

    export gbg_is_a_git_repo
    export gbg_repo_git_dir
    export gbg_repo_top_level
    export gbg_repo_just_init
    export gbg_repo_stashes_num
    export gbg_repo_has_stashes
    export gbg_repo_conflicts_num
    export gbg_repo_has_conflicts
    export gbg_repo_pending_action_type
    export gbg_repo_has_pending_action
}

_gbg_repo_get_pending_action() {
    _git_dir=${1}
    _pending_action=""
    if [ -d "${_git_dir}/rebase-merge" ]; then
        _pending_action="rebase"
        if [ -f "${_git_dir}/rebase-merge/interactive" ]; then
            _pending_action="${_pending_action}:interactive"
        else
            _pending_action="${_pending_action}:merge"
        fi
    elif [ -d "${_git_dir}/rebase-apply" ]; then
        if [ -f "${_git_dir}/rebase-apply/rebasing" ]; then
            _pending_action="rebase"
        elif [ -f "${_git_dir}/rebase-apply/applying" ]; then
            _pending_action="apply"
        else
            _pending_action="apply:rebase"
        fi
    elif [ -f "${_git_dir}/MERGE_HEAD" ]; then
        _pending_action="merge"
    elif [ -f "${_git_dir}/CHERRY_PICK_HEAD" ]; then
        _pending_action="cherry-pick"
    elif [ -f "${_git_dir}/BISECT_LOG" ]; then
        _pending_action="bisect"
    fi

    echo "${_pending_action}"

    unset _pending_action _git_dir
}




