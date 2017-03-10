function gbg_git_info {
    local enabled=`git config --local --get oh-my-git.enabled`
    if [[ ${enabled} == false ]]; then
        exit 1;
    fi
    
    _gbg_get_repo_status
    _gbg_get_head_status
    _gbg_get_workspace_status
    _gbg_get_index_status
    _gbg_get_upstream_status
}

function _gbg_get_workspace_status {
  local git_status="$(git status --porcelain 2> /dev/null)"
  gbg_workspace_modifications_num=$(echo $git_status | grep -E '^.M' | wc -l)
  gbg_workspace_has_modifications=$( [[ $gbg_workspace_modifications_num -gt 0 ]] && echo "true" || echo "false" )

  gbg_workspace_deletions_num=$(echo $git_status | grep -E '^.D' | wc -l)
  gbg_workspace_has_deletions=$( [[ $gbg_workspace_deletions_num -gt 0 ]] && echo "true" || echo "false" )

  gbg_workspace_untracked_num=$(echo $git_status | grep -E '^\?\?' | wc -l)
  gbg_workspace_has_untracked=$( [[ $gbg_workspace_untracked_num -gt 0 ]] && echo "true" || echo "false" )
}

function _gbg_get_index_status {
  local git_status="$(git status --porcelain 2> /dev/null)"
  gbg_index_modifications_num=$(echo $git_status | grep -E '^M' | wc -l)
  gbg_index_has_modifications=$( [[ $gbg_index_modifications_num -gt 0 ]] && echo "true" || echo "false" )

  gbg_index_deletions_num=$(echo $git_status | grep -E '^D' | wc -l)
  gbg_index_has_deletions=$( [[ $gbg_index_deletions_num -gt 0 ]] && echo "true" || echo "false" )

  gbg_index_adds_num=$(echo $git_status | grep -E '^D' | wc -l)
  gbg_index_has_adds=$( [[ $gbg_index_adds_num -gt 0 ]] && echo "true" || echo "false" )
}

function _gbg_get_upstream_status {
  local upstream="$(git rev-parse --symbolic-full-name --abbrev-ref "@{upstream}" 2> /dev/null)"
  if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then
    local has_upstream=true
  fi
  if [[ $has_upstream == true ]]; then
    local commits_diff="$(git log --pretty=oneline --topo-order --left-right HEAD...${upstream} 2> /dev/null)"
    local commits_ahead=$(\grep -c "^<" <<< "$commits_diff")
    local commits_behind=$(\grep -c "^>" <<< "$commits_diff")
  fi

  gbg_upstream_has_upstream=${has_upstream}
  gbg_upstream_name=${upstream}
  gbg_upstream_commits_ahead_num=${commits_ahead}
  gbg_upstream_has_commits_ahead=$( [[ ${commits_ahead} -gt 0 ]] && echo "true" || echo "false" )
  gbg_upstream_commits_behind_num=${commits_behind}
  gbg_upstream_has_commits_behind=$( [[ ${commits_behind} -gt 0 ]] && echo "true" || echo "false" )
  gbg_upstream_has_diverged=$( [[ $commits_ahead -gt 0 && $commits_behind -gt 0 ]] && echo "true" || echo "false" )
  gbg_upstream_merge_type=$( [[ -n $will_rebase ]] && echo "rebase" || echo "merge" )
}

function _gbg_get_repo_status {
  local git_dir="$(git rev-parse --git-dir 2> /dev/null)"
  local number_of_logs="$(git log --pretty=oneline -n1 2> /dev/null | wc -l)"
  local number_of_stashes="$(git stash list -n1 2> /dev/null | wc -l)"
  
  gbg_repo_git_dir=${git_dir}
  gbg_is_a_git_repo=$( [[ -n ${git_dir} ]] && echo "true" || echo "false" )
  gbg_repo_just_init=$( [[ $number_of_logs -eq 0 ]] && echo "true" || echo "false" )
  gbg_repo_stashes_num=${number_of_stashes}
  gbg_repo_has_stashes=$( [[ $number_of_stashes -gt 0 ]] && echo "true" || echo "false" )
}

function _gbg_get_head_status {
  local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)
  local current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  local tag_at_current_commit=$(git describe --exact-match --tags $current_commit_hash 2> /dev/null)
  
  gbg_head_hash=${current_commit_hash}
  gbg_head_branch=${current_branch}
  gbg_head_tag=${tag_at_current_commit}
  gbg_head_is_on_tag=$( [[ -n "${gbg_head_tag}" ]] && echo "true" || echo "false" )
  gbg_head_is_detached=$( [[ "${current_branch}" == "HEAD" ]] && echo "true" || echo "false" )
}
