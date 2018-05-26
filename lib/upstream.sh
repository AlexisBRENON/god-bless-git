#! /bin/sh

_gbg_get_upstream_status() {
    upstream="$(\
        git rev-parse --symbolic-full-name --abbrev-ref "@{upstream}" \
        2> /dev/null)"

    if [ -n "${upstream}" ] && \
        [ "${upstream}" != "@{upstream}" ]; then
        has_upstream="true"
        commits_diff="$(\
            git log --pretty=oneline --topo-order --left-right \
            HEAD..."${upstream}" \
            2> /dev/null)"
        commits_ahead="$(printf "%s" "${commits_diff}" | grep -c "^<")"
        commits_behind="$(printf "%s" "${commits_diff}" | grep -c "^>")"
    else
        has_upstream="false"
        commits_ahead="0"
        commits_behind="0"
    fi

    gbg_upstream_has_commits_ahead="$( \
        [ "${commits_ahead}" -gt 0 ] && \
        echo "true" || \
        echo "false" )"
    gbg_upstream_has_commits_behind="$( \
        [ "${commits_behind}" -gt 0 ] && \
        echo "true" || \
        echo "false" )"
    gbg_upstream_has_diverged="$( \
        [ "${commits_ahead}" -gt 0 ] && \
        [ "${commits_behind}" -gt 0 ] && \
        echo "true" || \
        echo "false" )"
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
