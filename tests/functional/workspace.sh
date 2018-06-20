#! /usr/bin/env sh

. "./tests/util/setups.sh"

test_nulls_in_non_repo() {
    _make_it_non_repo
    god_bless_git
    assertNull \
        "modifications_num" \
        "${gbg_workspace_modifications_num:-}"
    assertNull \
        "has_modifications" \
        "${gbg_workspace_has_modifications:-}"
    assertNull \
        "deletions_num" \
        "${gbg_workspace_deletions_num:-}"
    assertNull \
        "has_deletions" \
        "${gbg_workspace_has_deletions:-}"
    assertNull \
        "untracked_num" \
        "${gbg_workspace_untracked_num:-}"
    assertNull \
        "has_untracked" \
        "${gbg_workspace_has_untracked:-}"
    assertNull \
        "ignored_num" \
        "${gbg_workspace_ignored_num:-}"
    assertNull \
        "has_ignored" \
        "${gbg_workspace_has_ignored:-}"
}

test_has_no_modifications_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_workspace_has_modifications}"
    assertEquals 0 "${gbg_workspace_modifications_num}"
}

test_has_modifications_and_num() {
    _make_history 2
    echo "foo" > master_f1
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_modifications}"
    assertEquals 1 "${gbg_workspace_modifications_num}"
    echo "bar" > master_f2
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_modifications}"
    assertEquals 2 "${gbg_workspace_modifications_num}"
}

test_has_no_deletions_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_workspace_has_deletions}"
    assertEquals 0 "${gbg_workspace_deletions_num}"
}

test_has_deletions_and_num() {
    _make_history 2
    rm master_f1
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_deletions}"
    assertEquals 1 "${gbg_workspace_deletions_num}"
    rm master_f2
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_deletions}"
    assertEquals 2 "${gbg_workspace_deletions_num}"
}

test_has_no_untracked_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_workspace_has_untracked}"
    assertEquals 0 "${gbg_workspace_untracked_num}"
}

test_has_untracked_and_num() {
    _make_history 2
    touch untracked_1
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_untracked}"
    assertEquals 1 "${gbg_workspace_untracked_num}"
    touch untracked_2
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_untracked}"
    assertEquals 2 "${gbg_workspace_untracked_num}"
}

test_has_no_ignored_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_workspace_has_ignored}"
    assertEquals 0 "${gbg_workspace_ignored_num}"
}

test_has_ignored_and_num() {
    _make_history 2
    echo "ignored*" > .gitignore
    touch ignored_1
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_ignored}"
    assertEquals 1 "${gbg_workspace_ignored_num}"
    touch ignored_2
    god_bless_git
    assertEquals "true" "${gbg_workspace_has_ignored}"
    assertEquals 2 "${gbg_workspace_ignored_num}"
}

SHUNIT_PARENT=$0
. "./tests/shunit2/shunit2"

