#! /usr/bin/env sh

oneTimeSetUp() {
    . ./god_bless_git.sh
    SHUNIT_CMDOUTFILE="${GBG_DIR:-.}/tests/out.txt"
    export SHUNIT_CMDOUTFILE
    echo "" > "${SHUNIT_CMDOUTFILE}"

    SHUNIT_CMDERRFILE="${GBG_DIR:-.}/tests/err.txt"
    export SHUNIT_CMDERRFILE
    echo "" > "${SHUNIT_CMDERRFILE}"

    . ./tests/util/utils.sh
}

setUp() {
    cd "${SHUNIT_TMPDIR}" || \
        fail "Unable to cd to tmpdir '${SHUNIT_TMPDIR}'"
    echo "## ${_shunit_test_:-Undefined test name}" \
        >> "${SHUNIT_CMDOUTFILE}"
    echo "## ${_shunit_test_}" \
        >> "${SHUNIT_CMDERRFILE}"
    _git init .
    _git config user.email "test@tmp.com"
    _git config user.name "Test temp"
}

tearDown() {
    cd "${SHUNIT_TMPDIR:-/tmp}" && \
        rm -fr ./* && rm -fr ./.git
    cd "${GBG_DIR:-/tmp}" || \
        fail "Unable to cd back to GBG_DIR"
}

