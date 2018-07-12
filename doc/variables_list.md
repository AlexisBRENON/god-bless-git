# List of the populated variables

[0.0.12]: https://github.com/AlexisBRENON/god-bless-git/tree/0.0.12-rc1
[0.0.11]: https://github.com/AlexisBRENON/god-bless-git/releases/tag/v0.0.11
[0.0.10]: https://github.com/AlexisBRENON/god-bless-git/releases/tag/v0.0.10
[0.0.9]: https://github.com/AlexisBRENON/god-bless-git/releases/tag/v0.0.9

## Table of contents

  * [Variable types](#variable-types)

  * [Environment variables](#environment-variables)
  * [Repository variables](#repository-variables)
  * [Workspace variables](#workspace-variables)
  * [Index variables](#index-variables)
  * [Upstream variables](#upstream-variables)

  * [Index](#index)

## Variable types

  * boolean: `true` or `false` string
  * integer: string representing a decimal integer
  * file path: string pointing to a file or a directory

## Environment variables

  * `GBG_DIR`: file path

    **Introduction:** [0.0.9][]

    Root path of the God Bless Git project, _i.e._ path the directory containing the `god_bless_git.sh` file.

  * `GBG_VERSION`: version number

    **Introduction:** [0.0.10][]

    Current version of God Bless Git. Also allows availability detection of the `god_bless_git` function.


## Repository variables

  * <span id="gbg_is_a_git_repo">`gbg_is_a_git_repo`</span>: boolean

    **Introduction:** [0.0.9][]

    Is the working directory in a git repository?

  * <span id="gbg_repo_git_dir">`gbg_repo_git_dir`</span>: file path

    **Introduction:** [0.0.9][]

    Absolute path of the `.git` folder of the working repository.

  * <span id="gbg_repo_top_level">`gbg_repo_top_level`</span>: file path

    **Introduction:** [0.0.9][]

    Absolute path of the folder containing the `.git` folder of the working repository.

  * <span id="gbg_repo_just_init">`gbg_repo_just_init`</span>: boolean

    **Introduction:** [0.0.9][]

    Is the working repository history empty (no existing commit)?

  * <span id="gbg_repo_has_stashes">`gbg_repo_has_stashes`</span>: boolean

    **Introduction:** [0.0.9][]

    Does the working repository has stashes commits?

  * <span id="gbg_repo_stashes_num">`gbg_repo_stashes_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of stashes in the working repository.

  * <span id="gbg_repo_has_conflicts">`gbg_repo_has_conflicts`</span>: boolean

    **Introduction:** [0.0.11][]

    Are there conflicting files in the repository?

  * <span id="gbg_repo_conflicts_num">`gbg_repo_conflicts_num`</span>: integer

    **Introduction:** [0.0.11][]

    Number of conflicting files in the repository.

  * <span id="gbg_repo_has_pending_action">`gbg_repo_has_pending_action`</span>: boolean

    **Introduction:** [0.0.12][]

    Are there a pending action on the current repository.

  * <span id="gbg_repo_pending_action_type">`gbg_repo_pending_action_type`</span>: string

    **Introduction:** [0.0.12][]

    String representing the current pending action:
      * `rebase[:(interactive|merge)]`
      * `apply[:rebase]`
      * `merge`
      * `cherry-pick`
      * `bisect`

## `HEAD` variables

  * <span id="gbg_head_hash">`gbg_head_hash`</span>: string

    **Introduction:** [0.0.9][]

    Full SHA1 hash of the HEAD commit.

  * <span id="gbg_head_branch">`gbg_head_branch`</span>: string

    **Introduction:** [0.0.9][]

    Short reference of HEAD commit (branch name).

  * <span id="gbg_head_is_detached">`gbg_head_is_detached`</span>: boolean

    **Introduction:** [0.0.9][]

    Is current `HEAD` detached (not attached to any branch)?

  * <span id="gbg_head_is_on_tag">`gbg_head_is_on_tag`</span>: boolean

    **Introduction:** [0.0.9][]

    Does a tag reference `HEAD`?

  * <span id="gbg_head_tag">`gbg_head_tag`</span>: string

    **Introduction:** [0.0.9][]

    Name of the tag referencing `HEAD`.

## Workspace variables

  * <span id="gbg_workspace_has_modifications">`gbg_workspace_has_modifications`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there modified files in the workspace?

  * <span id="gbg_workspace_modifications_num">`gbg_workspace_modifications_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of files modified in the workspace.

  * <span id="gbg_workspace_has_deletions">`gbg_workspace_has_deletions`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there deleted files in the workspace?

  * <span id="gbg_workspace_deletions_num">`gbg_workspace_deletions_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of files deleted in the workspace.

  * <span id="gbg_workspace_has_untracked">`gbg_workspace_has_untracked`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there files in the working directory not tracked by git?

  * <span id="gbg_workspace_untracked_num">`gbg_workspace_untracked_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of untracked files in the workspace.

  * <span id="gbg_workspace_has_ignored">`gbg_workspace_has_ignored`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there files in the working directory ignored by git?

  * <span id="gbg_workspace_ignored_num">`gbg_workspace_ignored_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of ignored files in the workspace.

## Index variables

  * <span id="gbg_index_has_modifications">`gbg_index_has_modifications`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there modifications indexed for commit?

  * <span id="gbg_index_modifications_num">`gbg_index_modifications_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of modified files indexed for commit.

  * <span id="gbg_index_has_moves">`gbg_index_has_moves`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there moves/renames indexed for commit?

  * <span id="gbg_index_moves_num">`gbg_index_moves_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of moved/renamed files indexed for commit.

  * <span id="gbg_index_has_deletions">`gbg_index_has_deletions`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there deletions indexed for commit?

  * <span id="gbg_index_deletions_num">`gbg_index_deletions_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of deleted files indexed for commit.

  * <span id="gbg_index_has_additions">`gbg_index_has_additions`</span>: boolean

    **Introduction:** [0.0.9][]

    Are there new files indexed for commit?

  * <span id="gbg_index_additions_num">`gbg_index_additions_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of new files indexed for commit.

## Upstream variables

  * <span id="gbg_upstream_has_upstream">`gbg_upstream_has_upstream`</span>: boolean

    **Introduction:** [0.0.9][]

    Is the current branch configured to follow an upstream branch?

  * <span id="gbg_upstream_name">`gbg_upstream_name`</span>: string

    **Introduction:** [0.0.9][]

    Name of the followed upstream branch. This contains the remote name and the branch name as: `origin/master`.

  * <span id="gbg_upstream_has_commits_ahead">`gbg_upstream_has_commits_ahead`</span>: boolean

    **Introduction:** [0.0.9][]

    Is the upstream branch ahead of the local one (contains commits not present in the local one).

  * <span id="gbg_upstream_commits_ahead_num">`gbg_upstream_commits_ahead_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of commits in upstream branch but not in local one.

  * <span id="gbg_upstream_has_commits_behind">`gbg_upstream_has_commits_behind`</span>: boolean

    **Introduction:** [0.0.9][]

    Is the upstream branch behind the local one (do not contains commits present in the local one).

  * <span id="gbg_upstream_commits_behind_num">`gbg_upstream_commits_behind_num`</span>: integer

    **Introduction:** [0.0.9][]

    Number of commits not in upstream branch but in local one.

  * <span id="gbg_upstream_has_diverged">`gbg_upstream_has_diverged`</span>: boolean

    **Introduction:** [0.0.9][]

    Does local and upstream branches have diverged (ahead and behind)

## Index

  * **\_\_ A \_\_**
  * [additions_num (gbg_index)](#gbg_index_additions_num)
  * **\_\_ B \_\_**
  * [branch (gbg_head)](#gbg_head_branch)
  * **\_\_ C \_\_**
  * [commits_ahead_num (gbg_upstream)](#gbg_upstream_commits_ahead_num)
  * [commits_behind_num (gbg_upstream)](#gbg_upstream_commits_behind_num)
  * [conflicts_num (gbg_repo)](#gbg_repo_conflicts_num)
  * **\_\_ D \_\_**
  * [deletions_num (gbg_index)](#gbg_index_deletions_num)
  * [deletions_num (gbg_workspace)](#gbg_workspace_deletions_num)
  * **\_\_ G \_\_**
  * [git_dir (gbg_repo)](#gbg_repo_git_dir)
  * **\_\_ H \_\_**
  * [has_additions (gbg_index)](#gbg_index_has_additions)
  * [has_commits_ahead (gbg_upstream)](#gbg_upstream_has_commits_ahead)
  * [has_commits_behind (gbg_upstream)](#gbg_upstream_has_commits_behind)
  * [has_conflicts (gbg_repo)](#gbg_repo_has_conflicts)
  * [has_deletions (gbg_index)](#gbg_index_has_deletions)
  * [has_deletions (gbg_workspace)](#gbg_workspace_has_deletions)
  * [has_diverged (gbg_upstream)](#gbg_upstream_has_diverged)
  * [has_ignored (gbg_workspace)](#gbg_workspace_has_ignored)
  * [has_modifications (gbg_index)](#gbg_index_has_modifications)
  * [has_modifications (gbg_workspace)](#gbg_workspace_has_modifications)
  * [has_moves (gbg_index)](#gbg_index_has_moves)
  * [has_pending_action (gbg_repo)](#gbg_repo_has_pending_action)
  * [has_stashes (gbg_repo)](#gbg_repo_has_stashes)
  * [has_untracked (gbg_workspace)](#gbg_workspace_has_untracked)
  * [has_upstream (gbg_upstream)](#gbg_upstream_has_upstream)
  * [hash (gbg_head)](#gbg_head_hash)
  * **\_\_ I \_\_**
  * [ignored_num (gbg_workspace)](#gbg_workspace_ignored_num)
  * [is_a_git_repo (gbg)](#gbg_is_a_git_repo)
  * [is_detached (gbg_head)](#gbg_head_is_detached)
  * [is_on_tag (gbg_head)](#gbg_head_is_on_tag)
  * **\_\_ J \_\_**
  * [just_init (gbg_repo)](#gbg_repo_just_init)
  * **\_\_ M \_\_**
  * [modifications_num (gbg_index)](#gbg_index_modifications_num)
  * [modifications_num (gbg_workspace)](#gbg_workspace_modifications_num)
  * [moves_num (gbg_index)](#gbg_index_moves_num)
  * **\_\_ N \_\_**
  * [name (gbg_upstream)](#gbg_upstream_name)
  * \_\_ P \_\_
  * [pending_action_type (gbg_repo)](#gbg_repo_pending_action_type)
  * **\_\_ S \_\_**
  * [stashes_num (gbg_repo)](#gbg_repo_stashes_num)
  * **\_\_ T \_\_**
  * [tag (gbg_head)](#gbg_head_tag)
  * [top_level (gbg_repo)](#gbg_repo_top_level)
  * **\_\_ U \_\_**
  * [untracked_num (gbg_workspace)](#gbg_workspace_untracked_num)

