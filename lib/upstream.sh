#! /bin/sh

_gbg_get_upstream_status() {
    if [ "${gbg_is_a_git_repo:-false}" = "true" ]; then
        lgbg_upstream="$(\
            git rev-parse --symbolic-full-name --abbrev-ref "@{upstream}" \
            2> /dev/null)"

        if [ -n "${lgbg_upstream}" ] && \
            [ "${lgbg_upstream}" != "@{upstream}" ]; then
            lgbg_has_upstream="true"
            lgbg_commits_diff="$(\
                git log --pretty=oneline --topo-order --left-right \
                HEAD..."${lgbg_upstream}" \
                2> /dev/null)"
            lgbg_commits_ahead="$(\
                printf "%s" "${lgbg_commits_diff}" | \
                grep -c "^<")"
            lgbg_has_commits_ahead="$( \
                [ "${lgbg_commits_ahead}" -gt 0 ] && \
                echo "true" || \
                echo "false" )"
            lgbg_commits_behind="$(\
                printf "%s" "${lgbg_commits_diff}" | \
                grep -c "^>")"
            lgbg_has_commits_behind="$( \
                [ "${lgbg_commits_behind}" -gt 0 ] && \
                echo "true" || \
                echo "false" )"
            lgbg_has_diverged="$( \
                [ "${lgbg_commits_ahead}" -gt 0 ] && \
                [ "${lgbg_commits_behind}" -gt 0 ] && \
                echo "true" || \
                echo "false" )"
        else
            lgbg_has_upstream="false"
        fi

        # TODO(v1.x) : get pull method
        # gbg_upstream_merge_type=$( [ -n "${will_rebase}" ] && echo "rebase" || echo "merge" )
    fi

    export gbg_upstream_has_upstream="${lgbg_has_upstream:-}"
    # TODO(v2): remote name and remote branch name
    export gbg_upstream_name="${lgbg_upstream:-}"
    export gbg_upstream_commits_ahead_num="${lgbg_commits_ahead:-}"
    export gbg_upstream_has_commits_ahead="${lgbg_has_commits_ahead:-}"
    export gbg_upstream_commits_behind_num="${lgbg_commits_behind:-}"
    export gbg_upstream_has_commits_behind="${lgbg_has_commits_behind:-}"
    export gbg_upstream_has_diverged="${lgbg_has_diverged:-}"
    # export gbg_upstream_merge_type
}
