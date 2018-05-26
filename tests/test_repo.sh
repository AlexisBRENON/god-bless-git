#! /usr/bin/env sh

# Test repo related informations

. ./tests/setups.sh
. ./tests/utils.sh

test_is_a_git_repo() {
    gbg_git_info
    assertEquals "true" "${gbg_is_a_git_repo:-}"
}

test_is_not_a_git_repo() {
    _make_it_non_repo
    gbg_git_info
    assertEquals "false" "${gbg_is_a_git_repo:-}"
}

test_nulls_in_non_repo() {
    _make_it_non_repo
    gbg_git_info

    assertEquals 1 "$(set | grep -c '^gbg_repo_git_dir=')"
    assertEquals "" "${gbg_repo_git_dir:-}"

    assertEquals 1 "$(set | grep -c '^gbg_repo_top_level=')"
    assertEquals "" "${gbg_repo_top_level:-}"

    assertEquals 1 "$(set | grep -c '^gbg_repo_just_init=')"
    assertEquals "" "${gbg_repo_just_init:-}"

    assertEquals 1 "$(set | grep -c '^gbg_repo_has_stashes=')"
    assertEquals "" "${gbg_repo_has_stashes:-}"
}

test_git_dir_at_root() {
    gbg_git_info
    assertEquals "${SHUNIT_TMPDIR}/.git" "${gbg_repo_git_dir}"
}

test_git_dir_in_subdir() {
    _make_subdir
    cd sub1/sub11 || fail
    gbg_git_info
    assertEquals "${SHUNIT_TMPDIR}/.git" "${gbg_repo_git_dir}"
}

test_git_top_level_at_root() {
    gbg_git_info
    assertEquals "${SHUNIT_TMPDIR}" "${gbg_repo_top_level}"
}

test_git_top_level_in_subdir() {
    _make_subdir
    cd sub1/sub11 || fail
    gbg_git_info
    assertEquals "${SHUNIT_TMPDIR}" "${gbg_repo_top_level}"
}

test_just_init_in_init() {
    gbg_git_info
    assertEquals "true" "${gbg_repo_just_init:-}"
}

test_not_just_init_after_commit() {
    _make_one_commit
    gbg_git_info
    assertEquals "false" "${gbg_repo_just_init:-}"
}

test_not_has_stash_in_init() {
    gbg_git_info
    assertEquals "false" "${gbg_repo_has_stashes:-}"
}

test_not_has_stash_after_commit() {
    _make_one_commit
    gbg_git_info
    assertEquals "false" "${gbg_repo_has_stashes:-}"
}

test_has_stash() {
    _make_one_commit
    echo "f1.2" >> f1
    git stash >> "${SHUNIT_CMDOUTFILE}"
    gbg_git_info
    assertEquals "true" "${gbg_repo_has_stashes:-}"
}

test_0_stashes_num_if_not_has_stash() {
    gbg_git_info
    assertEquals 0 "${gbg_repo_stashes_num:-}"
}

test_num_stashes() {
    _make_one_commit
    echo "f1.2" >> f1
    git stash >> "${SHUNIT_CMDOUTFILE}"
    gbg_git_info
    assertEquals 1 "${gbg_repo_stashes_num:-}"
    echo "f1.3" >> f1
    git stash >> "${SHUNIT_CMDOUTFILE}"
    gbg_git_info
    assertEquals 2 "${gbg_repo_stashes_num:-}"
    git stash drop >> "${SHUNIT_CMDOUTFILE}"
    gbg_git_info
    assertEquals 1 "${gbg_repo_stashes_num:-}"
}

. ./tests/shunit2/shunit2

