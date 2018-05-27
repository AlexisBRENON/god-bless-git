#! /bin/sh

_gbg_get_head_status() {
    if [ "${gbg_is_a_git_repo:-}" = "true" ]; then
        lgbg_current_commit_hash="$(git rev-parse HEAD 2> /dev/null)"
        lgbg_current_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
        lgbg_tag_at_current_commit="$(\
            git describe --exact-match --tags \
            "${lgbg_current_commit_hash}"\
            2> /dev/null)"
        lgbg_head_is_on_tag="$( \
            [ -n "${lgbg_tag_at_current_commit}" ] && \
            echo "true" || \
            echo "false")"
        lgbg_head_is_detached="$( \
            [ "${lgbg_current_branch}" = "HEAD" ] && \
            echo "true" || \
            echo "false")"
    fi

    gbg_head_hash="${lgbg_current_commit_hash:-}"
    gbg_head_branch="${lgbg_current_branch:-}"
    gbg_head_tag="${lgbg_tag_at_current_commit:-}"
    gbg_head_is_on_tag="${lgbg_head_is_on_tag:-}"
    gbg_head_is_detached="${lgbg_head_is_detached:-}"

    export gbg_head_hash
    export gbg_head_branch
    export gbg_head_tag
    export gbg_head_is_on_tag
    export gbg_head_is_detached
}
