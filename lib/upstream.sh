#! /bin/sh

_gbg_get_upstream_status() {
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
        lgbg_commits_behind="$(\
            printf "%s" "${lgbg_commits_diff}" | \
            grep -c "^>")"
    else
        lgbg_has_upstream="false"
        lgbg_commits_ahead="0"
        lgbg_commits_behind="0"
    fi

    gbg_upstream_has_commits_ahead="$( \
        [ "${lgbg_commits_ahead}" -gt 0 ] && \
        echo "true" || \
        echo "false" )"
    gbg_upstream_has_commits_behind="$( \
        [ "${lgbg_commits_behind}" -gt 0 ] && \
        echo "true" || \
        echo "false" )"
    gbg_upstream_has_diverged="$( \
        [ "${lgbg_commits_ahead}" -gt 0 ] && \
        [ "${lgbg_commits_behind}" -gt 0 ] && \
        echo "true" || \
        echo "false" )"
    # TODO : get pull method
    # gbg_upstream_merge_type=$( [ -n "${will_rebase}" ] && echo "rebase" || echo "merge" )

    export gbg_upstream_has_upstream="${lgbg_has_upstream}"
    export gbg_upstream_name="${lgbg_upstream}"
    export gbg_upstream_commits_ahead_num="${lgbg_commits_ahead}"
    export gbg_upstream_has_commits_ahead
    export gbg_upstream_commits_behind_num="${lgbg_commits_behind}"
    export gbg_upstream_has_commits_behind
    export gbg_upstream_has_diverged
    # export gbg_upstream_merge_type
}
