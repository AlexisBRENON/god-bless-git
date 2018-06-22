#! /usr/bin/env sh

. "./tests/util/setups.sh"

test_nulls_in_non_repo() {
    _make_it_non_repo
    god_bless_git

    assertEquals \
        "head_hash undefined" \
        1 "$(set | grep -c '^gbg_head_hash=')"
    assertEquals \
        "head_hash" \
        "" "${gbg_head_hash:-}"

    assertEquals \
        "head_branch undefined" \
        1 "$(set | grep -c '^gbg_head_branch=')"
    assertEquals \
        "head_branch" \
        "" "${gbg_head_branch:-}"

    assertEquals \
        "head_tag undefined" \
        1 "$(set | grep -c '^gbg_head_tag=')"
    assertEquals \
        "head_tag" \
        "" "${gbg_head_tag:-}"

    assertEquals \
        "is_on_tag undefined" \
        1 "$(set | grep -c '^gbg_head_is_on_tag=')"
    assertEquals \
        "is_on_tag" \
        "" "${gbg_head_is_on_tag:-}"

    assertEquals \
        "head_is_detached undefined" \
        1 "$(set | grep -c '^gbg_head_is_detached=')"
    assertEquals \
        "head_is_detached" \
        "" "${gbg_head_is_detached:-}"
}

test_head_hash_in_init() {
    god_bless_git
    assertEquals "HEAD" "${gbg_head_hash:-undefined}"
}

test_head_hash_after_commit() {
    _make_one_commit
    god_bless_git
    assertNotEquals "HEAD" "${gbg_head_hash:-}"
    assertNotNull "${gbg_head_hash}"
    assertEquals 40 "${#gbg_head_hash}"
}

test_head_branch_in_init() {
    god_bless_git
    assertEquals "HEAD" "${gbg_head_branch:-undefined}"
}

test_head_branch_after_commit() {
    _make_one_commit
    god_bless_git
    assertEquals "master" "${gbg_head_branch}"
}

test_head_branch_on_branches() {
    _make_branches
    god_bless_git
    assertEquals "master" "${gbg_head_branch}"
    _git checkout b1
    god_bless_git
    assertEquals "b1" "${gbg_head_branch}"
}

test_head_branch_on_detached() {
    _make_history 10
    _git checkout HEAD~3
    god_bless_git
    assertEquals "HEAD" "${gbg_head_branch}"
}

test_head_tag_in_init() {
    god_bless_git
    assertEquals "false" "${gbg_head_is_on_tag}"
    assertEquals 1 "$(set | grep -c '^gbg_head_tag=')"
    assertEquals "" "${gbg_head_tag:-}"
}

test_head_tag_after_commit() {
    _make_history 2
    god_bless_git
    assertEquals "false" "${gbg_head_is_on_tag}"
    assertEquals 1 "$(set | grep -c '^gbg_head_tag=')"
    assertEquals "" "${gbg_head_tag:-}"
}

test_head_tag_on_tag() {
    _make_one_commit
    god_bless_git
    assertEquals "true" "${gbg_head_is_on_tag}"
    assertEquals "master_init" "${gbg_head_tag}"
}

test_head_detached_in_init() {
    god_bless_git
    assertEquals "true" "${gbg_head_is_detached}"
}

test_head_not_detached_after_commit() {
    _make_history 2
    god_bless_git
    assertEquals "false" "${gbg_head_is_detached}"
}

test_head_detached_after_checkout() {
    _make_history 10
    _git checkout HEAD~3
    god_bless_git
    assertEquals "true" "${gbg_head_is_detached}"
}

SHUNIT_PARENT=$0
. "./tests/shunit2/shunit2"

