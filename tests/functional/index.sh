#! /usr/bin/env sh

. "./tests/util/setups.sh"

test_nulls_in_non_repo() {
    _make_it_non_repo
    god_bless_git
    assertNull \
        "modifications_num" \
        "${gbg_index_modifications_num:-}"
    assertNull \
        "has_modifications" \
        "${gbg_index_has_modifications:-}"
    assertNull \
        "moves_num" \
        "${gbg_index_moves_num:-}"
    assertNull \
        "has_moves" \
        "${gbg_index_has_moves:-}"
    assertNull \
        "deletions_num" \
        "${gbg_index_deletions_num:-}"
    assertNull \
        "has_deletions" \
        "${gbg_index_has_deletions:-}"
    assertNull \
        "additions_num" \
        "${gbg_index_additions_num:-}"
    assertNull \
        "has_additions" \
        "${gbg_index_has_additions:-}"
}

test_has_no_modifications_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_index_has_modifications}"
    assertEquals 0 "${gbg_index_modifications_num}"
}

test_has_modifications_and_num() {
    _make_history 2
    echo "foo" > master_f1
    _git add master_f1
    god_bless_git
    assertEquals "true" "${gbg_index_has_modifications}"
    assertEquals 1 "${gbg_index_modifications_num}"
    echo "bar" > master_f2
    _git add master_f2
    god_bless_git
    assertEquals "true" "${gbg_index_has_modifications}"
    assertEquals 2 "${gbg_index_modifications_num}"
}

test_has_no_moves_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_index_has_moves}"
    assertEquals 0 "${gbg_index_moves_num}"
}

test_has_moves_and_num() {
    _make_history 2
    _git mv master_f1 moves_f1
    god_bless_git
    assertEquals "true" "${gbg_index_has_moves}"
    assertEquals 1 "${gbg_index_moves_num}"
    _git mv master_f2 moves_f2
    god_bless_git
    assertEquals "true" "${gbg_index_has_moves}"
    assertEquals 2 "${gbg_index_moves_num}"
}

test_has_no_deletions_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_index_has_deletions}"
    assertEquals 0 "${gbg_index_deletions_num}"
}

test_has_deletions_and_num() {
    _make_history 2
    _git rm master_f1
    god_bless_git
    assertEquals "true" "${gbg_index_has_deletions}"
    assertEquals 1 "${gbg_index_deletions_num}"
    _git rm master_f2
    god_bless_git
    assertEquals "true" "${gbg_index_has_deletions}"
    assertEquals 2 "${gbg_index_deletions_num}"
}

test_has_no_additions_and_num() {
    _make_history
    god_bless_git
    assertEquals "false" "${gbg_index_has_additions}"
    assertEquals 0 "${gbg_index_additions_num}"
}

test_has_additions_and_num() {
    _make_history 2
    echo "new1" > new1
    _git add new1
    god_bless_git
    assertEquals "true" "${gbg_index_has_additions}"
    assertEquals 1 "${gbg_index_additions_num}"
    echo "new2" > new2
    _git add new2
    god_bless_git
    assertEquals "true" "${gbg_index_has_additions}"
    assertEquals 2 "${gbg_index_additions_num}"
}

SHUNIT_PARENT=$0
. "./tests/shunit2/shunit2"

