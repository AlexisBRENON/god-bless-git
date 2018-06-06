#! /usr/bin/env sh

. "${GBG_DIR}/tests/util/setups.sh"
. "${GBG_DIR}/tests/util/utils.sh"

test_gbg_when_unspecified() {
    gbg_git_info
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # gbg_git_info is always defined
    assertTrue "[ ${num_gbg_variables} -gt 1 ]"
}

test_gbg_when_enabled() {
    gbg_git_info
    _git config --local gbg.enabled true
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # gbg_git_info is always defined
    assertTrue "[ ${num_gbg_variables} -gt 1 ]"
}

test_gbg_when_not_disabled() {
    gbg_git_info
    _git config --local gbg.disabled false
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # gbg_git_info is always defined
    assertTrue "[ ${num_gbg_variables} -gt 1 ]"
}

test_gbg_reset_when_not_enabled() {
    gbg_git_info
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    assertTrue \
        "gbg variables not set" \
        "[ ${num_gbg_variables} -gt 1 ]"

    _git config --local gbg.enabled false
    gbg_git_info
    num_gbg_variables=$(set | grep -E -c '^gbg_.*=')
    # gbg_git_info is always defined
    assertEquals \
        "gbg variables not deleted"\
        1 "${num_gbg_variables}"
}

. "${GBG_DIR}/tests/shunit2/shunit2"

