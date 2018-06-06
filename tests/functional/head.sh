#! /usr/bin/env sh

. "${GBG_DIR}/tests/util/setups.sh"
. "${GBG_DIR}/tests/util/utils.sh"

test_nulls_in_non_repo() {
    _make_it_non_repo
    gbg_git_info

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
    gbg_git_info
    assertEquals "HEAD" "${gbg_head_hash:-undefined}"
}

test_head_hash_after_commit() {
    _make_one_commit
    gbg_git_info
    assertNotEquals "HEAD" "${gbg_head_hash:-}"
    assertNotNull "${gbg_head_hash}"
    assertEquals 40 "${#gbg_head_hash}"
}

test_head_branch_in_init() {
    gbg_git_info
    assertEquals "HEAD" "${gbg_head_branch:-undefined}"
}

test_head_branch_after_commit() {
    _make_one_commit
    gbg_git_info
    assertEquals "master" "${gbg_head_branch}"
}

test_head_branch_on_branches() {
    _make_branches
    gbg_git_info
    assertEquals "master" "${gbg_head_branch}"
    _git checkout b1
    gbg_git_info
    assertEquals "b1" "${gbg_head_branch}"
}

test_head_tag_in_init() {
    gbg_git_info
    assertEquals "false" "${gbg_head_is_on_tag}"
    assertEquals 1 "$(set | grep -c '^gbg_head_tag=')"
    assertEquals "" "${gbg_head_tag:-}"
}

test_head_tag_after_commit() {
    _make_history 2
    gbg_git_info
    assertEquals "false" "${gbg_head_is_on_tag}"
    assertEquals 1 "$(set | grep -c '^gbg_head_tag=')"
    assertEquals "" "${gbg_head_tag:-}"
}

test_head_tag_on_tag() {
    _make_one_commit
    gbg_git_info
    assertEquals "true" "${gbg_head_is_on_tag}"
    assertEquals "master_init" "${gbg_head_tag}"
}

test_head_detached_in_init() {
    gbg_git_info
    assertEquals "true" "${gbg_head_is_detached}"
}

test_head_not_detached_after_commit() {
    _make_history 2
    gbg_git_info
    assertEquals "false" "${gbg_head_is_detached}"
}

test_head_detached_after_checkout() {
    _make_history 10
    _git checkout HEAD~3
    gbg_git_info
    assertEquals "true" "${gbg_head_is_detached}"
}

. "${GBG_DIR}/tests/shunit2/shunit2"

