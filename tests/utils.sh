#! /usr/bin/env sh

# HELPER FUNCTIONS

_make_it_non_repo() {
    cd "${SHUNIT_TMPDIR:-/tmp}" && rm -fr ./.git
    cd - > /dev/null || fail
}

_make_subdir() {
    mkdir sub1
    mkdir sub1/sub11
}

_make_one_commit() {
    echo "f1" > f1
    git add f1
    git commit -m "f1" >> "${SHUNIT_CMDOUTFILE}"
}

