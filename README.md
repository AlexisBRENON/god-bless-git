# God Bless Git

A POSIX compatible script to extract some informations about a git repository.

Status:
[![Build Status](https://travis-ci.org/AlexisBRENON/god-bless-git.svg?branch=master)](https://travis-ci.org/AlexisBRENON/god-bless-git)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/AlexisBRENON/god-bless-git/graphs/commit-activity)
[![GitHub release](https://img.shields.io/github/release/AlexisBRENON/god-bless-git.svg)](https://GitHub.com/AlexisBRENON/god-bless-git/releases/)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

God Bless Git (GBG) is a shell tool which can extract repository informations in a
simple and readable format. Thus, you can know:

 * Repository informations: is the folder a git repository, which is the top folder, etc.
 * Head informations: is head detached, head hash, branch, tag
 * Workspace informations: are there and how many modified/deleted/untracked/ignored files
 * Index informations: are there and how many added/modified/moved/deleted files
 * Remote informations: is upstream declared, how many commits differ, etc.

This list will grow with time. Priorities goes to:

  - Merge type: merge or rebase
  - Current action: merge, rebase, bissect, etc.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.
See [deployment][] for notes on how to deploy the project on a live system.

### <a name="prerequisites"></a>Prerequisites

God Bless Git as few prerequisites.

First one is [git][] which is required.
You can install it with your distribution package manager (apt, yum, pacman, etc.) or compile it yourself (look [git website][git]).

Then, GBG rely on POSIX compliant system utilities as `sed`, `grep`, `cut`, etc.
These should be already install on most of the POSIX systems.
If not, then you probably have a very custom system and so must be skilled enough to install them.
**WARNING:** Busybox's version of utilities have weird options/syntax and are very likely to not work properly with GBG.

There is some optional dependencies.
On the one side, for code linting.
We rely on [ShellCheck][] and [Bashate][] to warn us about the coding style.
Just check their respective pages to know how to install them (nothing really complicated).
On the other side, for testing.
Here we rely on [shUnit2][].
Hopefully, it is automatically installed the first time you run the tests, and so you do not have to install it manually.

### Installing

God Bless Git does not need to be installed.

First, clone the repository:

```sh
git clone https://github.com/AlexisBRENON/god-bless-git.git
```

That's it, GBG is ready to use.
See [deployment][] to know how to use it in real life.


## Running the tests

Some tests are distributed alongside the source code.
While, one day, they will be executed on a continuous integration server, you can still run them locally.

### Functional tests

These ones test that Gob Bless Git behave as expected, i.e. that the right variables are defined correctly.
You can run all of them using the following command:

```sh
make functionnal-tests
```

You can also run only one with:

```sh
make tests/functionnal/<test_type>_test.sh
```

### Profiling tests

GBG also comes with a profiling test, checking that execution time is not excessive.
You can execute it with:

```sh
make profile
```

### Coding style tests

As explained in the [prerequisites][] part, we rely on [ShellCheck][] and [Bashate][] to lint the code.
You can run these both linting checkers on the whole code base with the following command:

```sh
make lint
```

## <a name="deployment"></a>Deployment

It exists two ways to use God Bless Git:

 * [Sourcing the script](sourcing)
 * [Invoking the script](invoking)

### <a name="sourcing"></a>Sourcing

This way of using GBG is probably the best way if you intent to often fetch Git informations.
It is also the way GBG has been designed.

First, source one of the init script (note the '`.`' at the line start):

```sh
. god-bless-git/god_bless_git.sh
```

Or, for ZSH user

```zsh
. god-bless-git/god_bless_git.plugin.zsh
```

**Note:** Depending on your shell (in particular, on classical `sh`), init script is not able to determine GBG root directory.
It is possible to overcome this providing the path of this directory in the `GBG_DIR` environment variable.

You now have a `god_bless_git` function declared which will populate GBG's variables each time you call it.
For example, move to a non git repository folder (like `/tmp`) and run:

```sh
cd /tmp
god_bless_git
```

At this point GBG's variables have been added to your environment.
You can print the list of these variables with the following command:

```sh
set | grep -aE '^gbg_'
```

Here is the sample output:

```
gbg_head_branch=''
gbg_head_hash=''
gbg_head_is_detached=''
gbg_head_is_on_tag=''
gbg_head_tag=''
gbg_index_additions_num=''
gbg_index_deletions_num=''
gbg_index_has_additions=''
gbg_index_has_deletions=''
gbg_index_has_modifications=''
gbg_index_has_moves=''
gbg_index_modifications_num=''
gbg_index_moves_num=''
gbg_is_a_git_repo=false
gbg_repo_git_dir=''
gbg_repo_has_stashes=''
gbg_repo_just_init=''
gbg_repo_stashes_num=''
gbg_repo_top_level=''
gbg_upstream_commits_ahead_num=''
gbg_upstream_commits_behind_num=''
gbg_upstream_has_commits_ahead=''
gbg_upstream_has_commits_behind=''
gbg_upstream_has_diverged=''
gbg_upstream_has_upstream=''
gbg_upstream_name=''
gbg_workspace_deletions_num=''
gbg_workspace_has_deletions=''
gbg_workspace_has_ignored=''
gbg_workspace_has_modifications=''
gbg_workspace_has_untracked=''
gbg_workspace_ignored_num=''
gbg_workspace_modifications_num=''
gbg_workspace_untracked_num=''
```

Then move back to the `god_bless_git` folder and run again the previous commands:

```sh
cd god_bless_git
god_bless_git
set | grep -aE '^gbg_'
```

The GBG's variables have been updated, and here is an example output (which can be different from yours):

```
gbg_head_branch=master
gbg_head_hash=5543d924a41f33b045b5317291d3df0e4b76eee0
gbg_head_is_detached=false
gbg_head_is_on_tag=false
gbg_head_tag=''
gbg_index_additions_num=0
gbg_index_deletions_num=0
gbg_index_has_additions=false
gbg_index_has_deletions=false
gbg_index_has_modifications=false
gbg_index_has_moves=false
gbg_index_modifications_num=0
gbg_index_moves_num=0
gbg_is_a_git_repo=true
gbg_repo_git_dir=/home/jovyan/god-bless-git/.git
gbg_repo_has_stashes=false
gbg_repo_just_init=false
gbg_repo_stashes_num=0
gbg_repo_top_level=/home/jovyan/god-bless-git
gbg_upstream_commits_ahead_num=0
gbg_upstream_commits_behind_num=0
gbg_upstream_has_commits_ahead=false
gbg_upstream_has_commits_behind=false
gbg_upstream_has_diverged=false
gbg_upstream_has_upstream=true
gbg_upstream_name=origin/master
gbg_workspace_deletions_num=0
gbg_workspace_has_deletions=false
gbg_workspace_has_ignored=true
gbg_workspace_has_modifications=false
gbg_workspace_has_untracked=true
gbg_workspace_ignored_num=2
gbg_workspace_modifications_num=0
gbg_workspace_untracked_num=1
```

This list of variables can also be acquired by [invoking][] the script directly.

#### <a name="invoking"></a>Invoking

If you want to get Git informations just once, you can invoke GBG as any other standard commands.

Execute the init script from your shell:

```sh
./god-bless-git/god_bless_git.sh
```

Even better, if the `god-bless-git` appears in your PATH variable (or you linked the init script in any PATH registered folder), you can just call the script without any prefix:

```sh
god_bless_git.sh
```

This will display the list of GBG's variables, that is to say all the lines starting with `gbg_` in the `set` command output, as presented in the [sourcing][] examples.

## Built With

* [ShellCheck][], a static analysis tool for shell scripts.
* [Bashate][] - Code style enforcement for bash programs.
* [shUnit2][], a xUnit based unit test framework for Bourne based shell scripts.
* [README-Template.md](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2), a template to make good `README.md`.

## Contributing

Anybody is very welcome to contribute in any manner: asking features, reporting bugs, making pull requests, etc.
There is no particular contribution guidelines, just be clear and kind.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/AlexisBRENON/god-bless-git/). 

## Authors

* [**Alexis BRENON**](https://github.com/AlexisBRENON/) - _Initial work_ 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [oh-my-git][] which gives me the inspiration and a great code base as a starting point.

[deployment]: #deployment
[prerequisites]: #prerequisites
[sourcing]: #sourcing
[invoking]: #invoking

[bashate]: https://github.com/openstack-dev/bashate
[git]: https://git-scm.com/downloads
[oh-my-git]: https://github.com/arialdomartini/oh-my-git
[shellcheck]: https://github.com/koalaman/shellcheck
[shunit2]: https://github.com/kward/shunit2
