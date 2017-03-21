#! /bin/sh

. "${GBG_DIR}/lib/repo.sh"
. "${GBG_DIR}/lib/head.sh"
. "${GBG_DIR}/lib/workspace.sh"
. "${GBG_DIR}/lib/index.sh"
. "${GBG_DIR}/lib/upstream.sh"

gbg_git_info() {

  # Check that gbg is not disabled
  enabled=$(git config --get gbg.enabled)
  if [ "${enabled}" = "false" ]; then
    exit 1;
  fi

  _gbg_get_repo_status
  _gbg_get_head_status
  _gbg_get_workspace_status
  _gbg_get_index_status
  _gbg_get_upstream_status
}

export gbg_git_info
