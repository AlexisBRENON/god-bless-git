#! /bin/sh

. ./repo.sh
. ./head.sh
. ./workspace.sh
. ./index.sh
. ./upstream.sh

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

