#! /usr/bin/env sh

# HELPER FUNCTIONS

_git() {
    echo "" | \
        tee -a "${SHUNIT_CMDERRFILE}" "${SHUNIT_CMDOUTFILE}" \
        > /dev/null
    echo "git $*" | \
        tee -a "${SHUNIT_CMDERRFILE}" "${SHUNIT_CMDOUTFILE}" \
        > /dev/null
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
        echo "${branch_name}:c${num_commited}" \
            >> "${branch_name}_f${num_commited}"
        _git add "${branch_name}_f${num_commited}"
        _git commit -m "${branch_name}:c${num_commited}"
        if [ "${num_commited}" -eq 1 ]; then
            _git tag "${branch_name}_init"
        fi
        num_commited=$(( num_commited + 1 ))
    done
}

_make_history() {
    # Build a complete git history given numbers of commit
    # n commits are added to the master branch according to $1 (or 1)
    # Then commits are added to branches b1, b2, etc. according to
    # following arguments, forked from first commit of master.
    # A tag <branch_name>_init is added of the first commit of each branch.
    # This finally checkout master branch
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

_make_upstream() {
    mkdir remote
    _git init --bare remote
    _git remote add origin ./remote
    _git push --all -u origin
}

