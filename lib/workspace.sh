#! /bin/sh

# TODO: handle renamed/moved files

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
