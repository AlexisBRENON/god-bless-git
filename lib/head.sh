#! /bin/sh

_gbg_get_head_status() {
    if [ "${gbg_is_a_git_repo:-}" = "true" ]; then
        current_commit_hash="$(git rev-parse HEAD 2> /dev/null)"
        current_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
        tag_at_current_commit="$(\
            git describe --exact-match --tags \
            "${current_commit_hash}"\
            2> /dev/null)"
        head_is_on_tag="$( \
            [ -n "${tag_at_current_commit}" ] && \
            echo "true" || \
            echo "false")"
        head_is_detached="$( \
            [ "${current_branch}" = "HEAD" ] && \
            echo "true" || \
            echo "false")"
    fi

    gbg_head_hash="${current_commit_hash:-}"
    gbg_head_branch="${current_branch:-}"
    gbg_head_tag="${tag_at_current_commit:-}"
    gbg_head_is_on_tag="${head_is_on_tag:-}"
    gbg_head_is_detached="${head_is_detached:-}"

    export gbg_head_hash
    export gbg_head_branch
    export gbg_head_tag
    export gbg_head_is_on_tag
    export gbg_head_is_detached

    unset current_commit_hash
    unset current_branch
    unset tag_at_current_commit
    unset head_is_on_tag
    unset head_is_detached
}
