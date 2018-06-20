#! /usr/bin/env sh

. "./tests/util/setups.sh"

test_nulls_in_non_repo() {
    _make_it_non_repo
    god_bless_git

    assertNull \
        "has_upstream" \
        "${gbg_upstream_has_upstream:-}"
    assertNull \
        "upstream_name" \
        "${gbg_upstream_name:-}"
    assertNull \
        "upstream_commits_ahead_num" \
        "${gbg_upstream_commits_ahead_num:-}"
    assertNull \
        "gbg_upstream_has_commits_ahead" \
        "${gbg_upstream_has_commits_ahead:-}"
    assertNull \
        "gbg_upstream_commits_behind_num" \
        "${gbg_upstream_commits_behind_num:-}"
    assertNull \
        "gbg_upstream_has_commits_behind" \
        "${gbg_upstream_has_commits_behind:-}"
    assertNull \
        "gbg_upstream_has_diverged" \
        "${gbg_upstream_has_diverged:-}"
}

test_not_has_upstream() {
    god_bless_git

    assertEquals "false" "${gbg_upstream_has_upstream}"
    assertNull \
        "upstream_name" \
        "${gbg_upstream_name}"
}

test_has_upstream() {
    _make_history 1
    _make_upstream

    god_bless_git
    assertEquals "true" "${gbg_upstream_has_upstream}"
    assertEquals "origin/master" "${gbg_upstream_name}"

    _git remote rename origin o1
    god_bless_git
    assertEquals "true" "${gbg_upstream_has_upstream}"
    assertEquals "o1/master" "${gbg_upstream_name}"
}

test_null_commits_without_remote() {
    god_bless_git

    assertNull \
        "upstream_commits_ahead_num" \
        "${gbg_upstream_commits_ahead_num}"
    assertNull \
        "gbg_upstream_has_commits_ahead" \
        "${gbg_upstream_has_commits_ahead}"
    assertNull \
        "gbg_upstream_commits_behind_num" \
        "${gbg_upstream_commits_behind_num}"
    assertNull \
        "gbg_upstream_has_commits_behind" \
        "${gbg_upstream_has_commits_behind}"
    assertNull \
        "gbg_upstream_has_diverged" \
        "${gbg_upstream_has_diverged}"
}

test_no_commits() {
    _make_history 1
    _make_upstream

    god_bless_git
    assertEquals "false" "${gbg_upstream_has_commits_ahead}"
    assertEquals 0 "${gbg_upstream_commits_ahead_num}"
    assertEquals "false" "${gbg_upstream_has_commits_behind}"
    assertEquals 0 "${gbg_upstream_commits_behind_num}"
    assertEquals "false" "${gbg_upstream_has_diverged}"
}

test_commits_ahead() {
    _make_history 1
    _make_upstream

    _make_history 1
    god_bless_git
    assertEquals "true" "${gbg_upstream_has_commits_ahead}"
    assertEquals 1 "${gbg_upstream_commits_ahead_num}"
    assertEquals "false" "${gbg_upstream_has_commits_behind}"
    assertEquals 0 "${gbg_upstream_commits_behind_num}"
    assertEquals "false" "${gbg_upstream_has_diverged}"

    _make_history 1
    god_bless_git
    assertEquals "true" "${gbg_upstream_has_commits_ahead}"
    assertEquals 2 "${gbg_upstream_commits_ahead_num}"
}

test_commits_behind() {
    _make_history 3
    _make_upstream

    _git reset HEAD~
    god_bless_git
    assertEquals "false" "${gbg_upstream_has_commits_ahead}"
    assertEquals 0 "${gbg_upstream_commits_ahead_num}"
    assertEquals "true" "${gbg_upstream_has_commits_behind}"
    assertEquals 1 "${gbg_upstream_commits_behind_num}"
    assertEquals "false" "${gbg_upstream_has_diverged}"

    _git reset HEAD~
    god_bless_git
    assertEquals "true" "${gbg_upstream_has_commits_behind}"
    assertEquals 2 "${gbg_upstream_commits_behind_num}"
}

test_commits_diverged() {
    _make_history 3
    _make_upstream

    _git reset --hard HEAD~
    _make_history 1
    god_bless_git
    assertEquals "true" "${gbg_upstream_has_commits_ahead}"
    assertEquals 1 "${gbg_upstream_commits_ahead_num}"
    assertEquals "true" "${gbg_upstream_has_commits_behind}"
    assertEquals 1 "${gbg_upstream_commits_behind_num}"
    assertEquals "true" "${gbg_upstream_has_diverged}"

    _git reset --hard HEAD~2
    _make_history 2
    god_bless_git
    assertEquals "true" "${gbg_upstream_has_commits_ahead}"
    assertEquals 2 "${gbg_upstream_commits_ahead_num}"
    assertEquals "true" "${gbg_upstream_has_commits_behind}"
    assertEquals 2 "${gbg_upstream_commits_behind_num}"
    assertEquals "true" "${gbg_upstream_has_diverged}"
}

SHUNIT_PARENT=$0
. "./tests/shunit2/shunit2"

