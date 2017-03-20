#! /bin/sh

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
