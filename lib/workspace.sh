#! /bin/sh

_gbg_get_workspace_status() {
  git_status=""
  if [ "${_gbg_list_untracked:-""}" = true ]; then
    git_status="$(git status --porcelain --ignored 2> /dev/null)"
  else
    git_status="$(git status --porcelain 2> /dev/null)"
  fi

  gbg_workspace_modifications_num=$(echo "${git_status}" | grep -Ece '^.M')
  gbg_workspace_has_modifications=$( [ "${gbg_workspace_modifications_num}" -gt 0 ] && echo "true" || echo "false" )

  gbg_workspace_deletions_num=$(echo "${git_status}" | grep -Ece '^.D')
  gbg_workspace_has_deletions=$( [ "${gbg_workspace_deletions_num}" -gt 0 ] && echo "true" || echo "false" )

  gbg_workspace_untracked_num=$(echo "${git_status}" | grep -Ece '^\?\?')
  gbg_workspace_has_untracked=$( [ "${gbg_workspace_untracked_num}" -gt 0 ] && echo "true" || echo "false" )

  gbg_workspace_ignored_num=$(echo "${git_status}" | grep -Ece '^!!')
  gbg_workspace_has_ignored=$( [ "${gbg_workspace_ignored_num}" -gt 0 ] && echo "true" || echo "false" )

  export gbg_workspace_modifications_num
  export gbg_workspace_has_modifications
  export gbg_workspace_deletions_num
  export gbg_workspace_has_deletions
  export gbg_workspace_untracked_num
  export gbg_workspace_has_untracked
  export gbg_workspace_ignored_num
  export gbg_workspace_has_ignored
}
