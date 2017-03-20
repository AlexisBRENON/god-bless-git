#! /bin/sh

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
