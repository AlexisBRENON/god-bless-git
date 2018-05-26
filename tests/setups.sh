#! /usr/bin/env sh

oneTimeSetUp() {
    . ./init.sh
    SHUNIT_CMDOUTFILE="${GBG_DIR:-.}/tests/out.txt"
    export SHUNIT_CMDOUTFILE
    echo "" > "${SHUNIT_CMDOUTFILE}"
}

setUp() {
    cd "${SHUNIT_TMPDIR}" || fail "Unable to cd to tmpdir '${SHUNIT_TMPDIR}'"
    git init . >> "${SHUNIT_CMDOUTFILE}"
}

tearDown() {
    cd "${SHUNIT_TMPDIR:-/tmp}" && rm -fr ./* && rm -fr ./.git
    cd "${GBG_DIR:-/tmp}" || fail "Unable to cd back to GBG_DIR"
}

