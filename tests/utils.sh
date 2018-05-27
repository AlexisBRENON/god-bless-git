#! /usr/bin/env sh

# HELPER FUNCTIONS

_git() {
    git "$@" >> "${SHUNIT_CMDOUTFILE}" 2>> "${SHUNIT_CMDERRFILE}"
}

_make_it_non_repo() {
    cd "${SHUNIT_TMPDIR:-/tmp}" && rm -fr ./.git
    cd - > /dev/null || fail
}

_make_subdir() {
    mkdir sub1
    mkdir sub1/sub11
}

_make_commits() {
    num_commits="${1:-1}"
    branch_name="${2:-}"
    num_commited=1
    while [ "${num_commited}" -le "${num_commits}" ]; do
        echo "${branch_name}:c${num_commited}" >> f1
        _git add f1
        _git commit -m "${branch_name}:c${num_commited}"
        if [ "${num_commited}" -eq 1 ]; then
            _git tag "${branch_name}_init"
        fi
        num_commited=$(( num_commited + 1 ))
    done
}

_make_history() {
    _make_commits "$1" "master"
    shift

    branch_num=1
    for num_commits in "$@"; do
        _git checkout -b "b${branch_num}" master_init
        _make_commits "${num_commits}" "b${branch_num}"
        branch_num=$(( branch_num + 1 ))
    done

    _git checkout master
    _git log --oneline --decorate --graph --all
}

_make_branches() {
    _make_history 1 1 1
}

_make_one_commit() {
    _make_history 1
}

