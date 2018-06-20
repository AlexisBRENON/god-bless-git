#! /usr/bin/env sh

. "./tests/util/setups.sh"

test_gbg_when_unspecified() {
    god_bless_git
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # god_bless_git is always defined
    assertTrue "[ ${num_gbg_variables} -gt 1 ]"
}

test_gbg_when_enabled() {
    god_bless_git
    _git config --local gbg.enabled true
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # god_bless_git is always defined
    assertTrue "[ ${num_gbg_variables} -gt 1 ]"
}

test_gbg_when_not_disabled() {
    god_bless_git
    _git config --local gbg.disabled false
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # god_bless_git is always defined
    assertTrue "[ ${num_gbg_variables} -gt 1 ]"
}

test_gbg_reset_when_not_enabled() {
    god_bless_git
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    assertTrue \
        "gbg variables not set" \
        "[ ${num_gbg_variables} -gt 1 ]"

    _git config --local gbg.enabled false
    god_bless_git
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # god_bless_git is always defined
    assertEquals \
        "gbg variables not deleted"\
        0 "${num_gbg_variables}"
}

SHUNIT_PARENT=$0
. "./tests/shunit2/shunit2"

