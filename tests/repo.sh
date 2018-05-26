#! /usr/bin/env sh

# Test repo related informations

oneTimeSetUp() {
  SHUNIT_CMDOUTFILE="${GBG_DIR:-.}/tests/out.txt"
  export SHUNIT_CMDOUTFILE
  echo "" > "${SHUNIT_CMDOUTFILE}"
}

setUp() {
  . ./init.sh
  cd "${SHUNIT_TMPDIR}" || fail "Unable to cd to tmpdir '${SHUNIT_TMPDIR}'"
  git init . >> "${SHUNIT_CMDOUTFILE}"
}

tearDown() {
  cd "${SHUNIT_TMPDIR:-/tmp}" && rm -fr ./* && rm -fr ./.git
  cd "${GBG_DIR:-/tmp}" || fail "Unable to cd back to GBG_DIR"
}

# HELPER FUNCTIONS

_make_it_non_repo() {
  cd "${SHUNIT_TMPDIR:-/tmp}" && rm -fr ./.git
  cd - > /dev/null || fail
}

_make_subdir() {
  mkdir sub1
  mkdir sub1/sub11
}

_make_one_commit() {
  echo "f1" > f1
  git add f1
  git commit -m "f1" >> "${SHUNIT_CMDOUTFILE}"
}

# TESTS

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

