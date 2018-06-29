# List of the populated variables

[0.0.10]: https://github.com/AlexisBRENON/god-bless-git/releases/tag/v0.0.10
[0.0.9]: https://github.com/AlexisBRENON/god-bless-git/releases/tag/v0.0.9

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

  * `gbg_is_a_git_repo`: boolean

    **Introduction:** [0.0.9][]

    Is the working directory in a git repository?

  * `gbg_repo_git_dir`: file path

    **Introduction:** [0.0.9][]

    Absolute path of the `.git` folder of the working repository.

  * `gbg_repo_top_level`: file path

    **Introduction:** [0.0.9][]

    Absolute path of the folder containing the `.git` folder of the working repository.

  * `gbg_repo_just_init`: boolean

    **Introduction:** [0.0.9][]

    Is the working repository history empty (no existing commit)?

  * `gbg_repo_has_stashes`: boolean

    **Introduction:** [0.0.9][]

    Does the working repository has stashes commits?

  * `gbg_repo_stashes_num`: integer

    **Introduction:** [0.0.9][]

    Number of stashes in the working repository.

  * `gbg_repo_has_conflicts`: boolean

    **Introduction:** [0.0.11][]

    Are there conflicting files in the repository?

  * `gbg_repo_conflicts_num`: integer

    **Introduction:** [0.0.11][]

    Number of conflicting files in the repository.

## `HEAD` variables

  * `gbg_head_hash`: string

    **Introduction:** [0.0.9][]

    Full SHA1 hash of the HEAD commit.

  * `gbg_head_branch`: string

    **Introduction:** [0.0.9][]

    Short reference of HEAD commit (branch name).

  * `gbg_head_is_detached`: boolean

    **Introduction:** [0.0.9][]

    Is current `HEAD` detached (not attached to any branch)?

  * `gbg_head_is_on_tag`: boolean

    **Introduction:** [0.0.9][]

    Does a tag reference `HEAD`?

  * `gbg_head_tag`: string

    **Introduction:** [0.0.9][]

    Name of the tag referencing `HEAD`.

## Workspace variables

  * `gbg_workspace_has_modifications`: boolean

    **Introduction:** [0.0.9][]

    Are there modified files in the workspace?

  * `gbg_workspace_modifications_num`: integer

    **Introduction:** [0.0.9][]

    Number of files modified in the workspace.

  * `gbg_workspace_has_deletions`: boolean

    **Introduction:** [0.0.9][]

    Are there deleted files in the workspace?

  * `gbg_workspace_deletions_num`: integer

    **Introduction:** [0.0.9][]

    Number of files deleted in the workspace.

  * `gbg_workspace_has_untracked`: boolean

    **Introduction:** [0.0.9][]

    Are there files in the working directory not tracked by git?

  * `gbg_workspace_untracked_num`: integer

    **Introduction:** [0.0.9][]

    Number of untracked files in the workspace.

  * `gbg_workspace_has_ignored`: boolean

    **Introduction:** [0.0.9][]

    Are there files in the working directory ignored by git?

  * `gbg_workspace_ignored_num`: integer

    **Introduction:** [0.0.9][]

    Number of ignored files in the workspace.

## Index variables

  * `gbg_index_has_modifications`: boolean

    **Introduction:** [0.0.9][]

    Are there modifications indexed for commit?

  * `gbg_index_modifications_num`: integer

    **Introduction:** [0.0.9][]

    Number of modified files indexed for commit.

  * `gbg_index_has_moves`: boolean

    **Introduction:** [0.0.9][]

    Are there moves/renames indexed for commit?

  * `gbg_index_moves_num`: integer

    **Introduction:** [0.0.9][]

    Number of moved/renamed files indexed for commit.

  * `gbg_index_has_deletions`: boolean

    **Introduction:** [0.0.9][]

    Are there deletions indexed for commit?

  * `gbg_index_deletions_num`: integer

    **Introduction:** [0.0.9][]

    Number of deleted files indexed for commit.

  * `gbg_index_has_additions`: boolean

    **Introduction:** [0.0.9][]

    Are there new files indexed for commit?

  * `gbg_index_additions_num`: integer

    **Introduction:** [0.0.9][]

    Number of new files indexed for commit.

## Upstream variables

  * `gbg_upstream_has_upstream`: boolean

    **Introduction:** [0.0.9][]

    Is the current branch configured to follow an upstream branch?

  * `gbg_upstream_name`: string

    **Introduction:** [0.0.9][]

    Name of the followed upstream branch. This contains the remote name and the branch name as: `origin/master`.

  * `gbg_upstream_has_commits_ahead`: boolean

    **Introduction:** [0.0.9][]

    Is the upstream branch ahead of the local one (contains commits not present in the local one).

  * `gbg_upstream_commits_ahead_num`: integer

    **Introduction:** [0.0.9][]

    Number of commits in upstream branch but not in local one.

  * `gbg_upstream_has_commits_behind`: boolean

    **Introduction:** [0.0.9][]

    Is the upstream branch behind the local one (do not contains commits present in the local one).

  * `gbg_upstream_commits_behind_num`: integer

    **Introduction:** [0.0.9][]

    Number of commits not in upstream branch but in local one.

  * `gbg_upstream_has_diverged`: boolean

    **Introduction:** [0.0.9][]

    Does local and upstream branches have diverged (ahead and behind)
