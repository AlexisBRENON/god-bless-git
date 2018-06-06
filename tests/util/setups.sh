#! /usr/bin/env sh

oneTimeSetUp() {
    . ./init.sh
    SHUNIT_CMDOUTFILE="${GBG_DIR:-.}/tests/out.txt"
    export SHUNIT_CMDOUTFILE
    echo "" > "${SHUNIT_CMDOUTFILE}"

    SHUNIT_CMDERRFILE="${GBG_DIR:-.}/tests/err.txt"
    export SHUNIT_CMDERRFILE
    echo "" > "${SHUNIT_CMDERRFILE}"
}

setUp() {
    cd "${SHUNIT_TMPDIR}" || \
        fail "Unable to cd to tmpdir '${SHUNIT_TMPDIR}'"
    git init . \
        >> "${SHUNIT_CMDOUTFILE}" \
        2>> "${SHUNIT_CMDERRFILE}"
}

tearDown() {
    cd "${SHUNIT_TMPDIR:-/tmp}" && \
        rm -fr ./* && rm -fr ./.git
    cd "${GBG_DIR:-/tmp}" || \
        fail "Unable to cd back to GBG_DIR"
}

