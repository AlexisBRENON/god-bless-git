#! /bin/sh

_gbg_get_repo_status() {
  gbg_is_a_git_repo="$(git rev-parse --is-inside-work-tree 2> /dev/null || echo "false" )"

  if [ "${gbg_is_a_git_repo}" = "true" ]; then
    git_dir="$(git rev-parse --absolute-git-dir 2> /dev/null)"
    git_top_level="$(git rev-parse --show-toplevel 2> /dev/null)"
    number_of_logs="$(git log --pretty=oneline -n1 2> /dev/null | wc -l)"
    number_of_stashes="$(git stash list 2> /dev/null | wc -l)"

    gbg_repo_git_dir="${git_dir}"
    gbg_repo_top_level="${git_top_level}"
    gbg_repo_just_init="$( \
      [ "${number_of_logs}" -eq 0 ] && \
      echo "true" || \
      echo "false" )"
    gbg_repo_stashes_num="${number_of_stashes}"
    gbg_repo_has_stashes="$( \
      [ "${number_of_stashes}" -gt 0 ] && \
      echo "true" || \
      echo "false" )"
  else
    gbg_repo_git_dir=""
    gbg_repo_top_level=""
    gbg_repo_just_init=""
    gbg_repo_stashes_num=""
    gbg_repo_has_stashes=""
  fi


  export gbg_is_a_git_repo
  export gbg_repo_git_dir
  export gbg_repo_top_level
  export gbg_repo_just_init
  export gbg_repo_stashes_num
  export gbg_repo_has_stashes
}
