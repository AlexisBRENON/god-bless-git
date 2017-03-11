#! /bin/sh

gbg_git_info() {
    enabled=$(git config --local --get oh-my-git.enabled)
    if [ "${enabled}" = "false" ]; then
        exit 1;
    fi

    _gbg_get_repo_status
    _gbg_get_head_status
    _gbg_get_workspace_status
    _gbg_get_index_status
    _gbg_get_upstream_status
}

_gbg_get_workspace_status() {
    git_status="$(git status --porcelain 2> /dev/null)"
    gbg_workspace_modifications_num=$(echo "${git_status}" | grep -Ece '^.M')
    gbg_workspace_has_modifications=$( [ "${gbg_workspace_modifications_num}" -gt 0 ] && echo "true" || echo "false" )

    gbg_workspace_deletions_num=$(echo "${git_status}" | grep -Ece '^.D')
    gbg_workspace_has_deletions=$( [ "${gbg_workspace_deletions_num}" -gt 0 ] && echo "true" || echo "false" )

    gbg_workspace_untracked_num=$(echo "${git_status}" | grep -Ece '^\?\?')
    gbg_workspace_has_untracked=$( [ "${gbg_workspace_untracked_num}" -gt 0 ] && echo "true" || echo "false" )

    export gbg_workspace_modifications_num
    export gbg_workspace_has_modifications
    export gbg_workspace_deletions_num
    export gbg_workspace_has_deletions
    export gbg_workspace_untracked_num
    export gbg_workspace_has_untracked
}

_gbg_get_index_status() {
    git_status="$(git status --porcelain 2> /dev/null)"
    gbg_index_modifications_num=$(echo "${git_status}" | grep -Ece '^M')
    gbg_index_has_modifications=$( [ "${gbg_index_modifications_num}" -gt 0 ] && echo "true" || echo "false" )

    gbg_index_deletions_num=$(echo "${git_status}" | grep -Ece '^D')
    gbg_index_has_deletions=$( [ "${gbg_index_deletions_num}" -gt 0 ] && echo "true" || echo "false" )

    gbg_index_additions_num=$(echo "${git_status}" | grep -Ece '^A')
    gbg_index_has_additions=$( [ "${gbg_index_additions_num}" -gt 0 ] && echo "true" || echo "false" )

    export gbg_index_modifications_num
    export gbg_index_has_modifications
    export gbg_index_deletions_num
    export gbg_index_has_deletions
    export gbg_index_additions_num
    export gbg_index_has_additions
}

_gbg_get_upstream_status() {
    upstream="$(git rev-parse --symbolic-full-name --abbrev-ref "@{upstream}" 2> /dev/null)"
    if [ -n "${upstream}" ] && [ "${upstream}" != "@{upstream}" ]; then
        has_upstream="true"
        commits_diff="$(git log --pretty=oneline --topo-order --left-right HEAD..."${upstream}" 2> /dev/null)"
        commits_ahead="$(printf "%s" "${commits_diff}" | grep -c "^<")"
        commits_behind="$(printf "%s" "${commits_diff}" | grep -c "^>")"
    else
        has_upstream="false"
        commits_ahead="0"
        commits_behind="0"
    fi

    gbg_upstream_has_commits_ahead="$( [ "${commits_ahead}" -gt 0 ] && echo "true" || echo "false" )"
    gbg_upstream_has_commits_behind="$( [ "${commits_behind}" -gt 0 ] && echo "true" || echo "false" )"
    gbg_upstream_has_diverged="$( [ "${commits_ahead}" -gt 0 ] && [ "${commits_behind}" -gt 0 ] && echo "true" || echo "false" )"
    # TODO : get pull method
    # gbg_upstream_merge_type=$( [ -n "${will_rebase}" ] && echo "rebase" || echo "merge" )

    export gbg_upstream_has_upstream="${has_upstream}"
    export gbg_upstream_name="${upstream}"
    export gbg_upstream_commits_ahead_num="${commits_ahead}"
    export gbg_upstream_has_commits_ahead
    export gbg_upstream_commits_behind_num="${commits_behind}"
    export gbg_upstream_has_commits_behind
    export gbg_upstream_has_diverged
    # export gbg_upstream_merge_type
}

_gbg_get_repo_status() {
    git_dir="$(git rev-parse --git-dir 2> /dev/null)"
    number_of_logs="$(git log --pretty=oneline -n1 2> /dev/null | wc -l)"
    number_of_stashes="$(git stash list -n1 2> /dev/null | wc -l)"

    gbg_repo_git_dir="${git_dir}"
    gbg_is_a_git_repo="$( [ -n "${git_dir}" ] && echo "true" || echo "false" )"
    gbg_repo_just_init="$( [ "${number_of_logs}" -eq 0 ] && echo "true" || echo "false" )"
    gbg_repo_stashes_num="${number_of_stashes}"
    gbg_repo_has_stashes="$( [ "${number_of_stashes}" -gt 0 ] && echo "true" || echo "false" )"

    export gbg_repo_git_dir
    export gbg_is_a_git_repo
    export gbg_repo_just_init
    export gbg_repo_stashes_num
    export gbg_repo_has_stashes
}

_gbg_get_head_status() {
    current_commit_hash="$(git rev-parse HEAD 2> /dev/null)"
    current_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
    tag_at_current_commit="$(git describe --exact-match --tags "${current_commit_hash}" 2> /dev/null)"

    gbg_head_hash="${current_commit_hash}"
    gbg_head_branch="${current_branch}"
    gbg_head_tag="${tag_at_current_commit}"
    gbg_head_is_on_tag="$( [ -n "${gbg_head_tag}" ] && echo "true" || echo "false" )"
    gbg_head_is_detached="$( [ "${current_branch}" = "HEAD" ] && echo "true" || echo "false" )"

    export gbg_head_hash
    export gbg_head_branch
    export gbg_head_tag
    export gbg_head_is_on_tag
    export gbg_head_is_detached
}
