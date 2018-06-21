#! /usr/bin/env sh

# Test repo related informations

. "./tests/util/setups.sh"

test_is_a_git_repo() {
    god_bless_git
    assertEquals "true" "${gbg_is_a_git_repo:-}"
}

test_is_not_a_git_repo() {
    _make_it_non_repo
    god_bless_git
    assertEquals "false" "${gbg_is_a_git_repo:-}"
}

test_nulls_in_non_repo() {
    _make_it_non_repo
    god_bless_git

    assertEquals \
        "git_dir undefined" \
        1 "$(set | grep -c '^gbg_repo_git_dir=')"
    assertEquals \
        "git_dir" \
        "" "${gbg_repo_git_dir:-}"

    assertEquals \
        "top_level undefined" \
        1 "$(set | grep -c '^gbg_repo_top_level=')"
    assertEquals \
        "top_level" \
        "" "${gbg_repo_top_level:-}"

    assertEquals \
        "just_init undefined" \
        1 "$(set | grep -c '^gbg_repo_just_init=')"
    assertEquals \
        "just_init" \
        "" "${gbg_repo_just_init:-}"

    assertEquals \
        "has_stashes undefined" \
        1 "$(set | grep -c '^gbg_repo_has_stashes=')"
    assertEquals \
        "has_stashes" \
        "" "${gbg_repo_has_stashes:-}"
}

test_git_dir_at_root() {
    god_bless_git
    assertEquals "${SHUNIT_TMPDIR}/.git" "${gbg_repo_git_dir}"
}

test_git_dir_in_subdir() {
    _make_subdir
    cd sub1/sub11 || fail
    god_bless_git
    assertEquals "${SHUNIT_TMPDIR}/.git" "${gbg_repo_git_dir}"
}

test_git_top_level_at_root() {
    god_bless_git
    assertEquals "${SHUNIT_TMPDIR}" "${gbg_repo_top_level}"
}

test_git_top_level_in_subdir() {
    _make_subdir
    cd sub1/sub11 || fail
    god_bless_git
    assertEquals "${SHUNIT_TMPDIR}" "${gbg_repo_top_level}"
}

test_just_init_in_init() {
    god_bless_git
    assertEquals "true" "${gbg_repo_just_init:-}"
}

test_not_just_init_after_commit() {
    _make_one_commit
    god_bless_git
    assertEquals "false" "${gbg_repo_just_init:-}"
}

test_not_has_stash_in_init() {
    god_bless_git
    assertEquals "false" "${gbg_repo_has_stashes:-}"
}

test_not_has_stash_after_commit() {
    _make_one_commit
    god_bless_git
    assertEquals "false" "${gbg_repo_has_stashes:-}"
}

test_has_stash() {
    _make_one_commit
    echo "f1.2" >> master_f1
    git stash >> "${SHUNIT_CMDOUTFILE}"
    god_bless_git
    assertEquals "true" "${gbg_repo_has_stashes:-}"
}

test_0_stashes_num_if_not_has_stash() {
    god_bless_git
    assertEquals 0 "${gbg_repo_stashes_num:-}"
}

test_num_stashes() {
    _make_one_commit
    echo "f1.2" >> master_f1
    git stash >> "${SHUNIT_CMDOUTFILE}"
    god_bless_git
    assertEquals 1 "${gbg_repo_stashes_num:-}"
    echo "f1.3" >> master_f1
    git stash >> "${SHUNIT_CMDOUTFILE}"
    god_bless_git
    assertEquals 2 "${gbg_repo_stashes_num:-}"
    git stash drop >> "${SHUNIT_CMDOUTFILE}"
    god_bless_git
    assertEquals 1 "${gbg_repo_stashes_num:-}"
}

SHUNIT_PARENT=$0
. "./tests/shunit2/shunit2"
