#! /usr/bin/env make

TEST_SHELL := sh

FUNCTIONAL_TESTS := tests/functional/enable.sh \
	tests/functional/repo.sh \
	tests/functional/workspace.sh \
	tests/functional/index.sh \
	tests/functional/head.sh \
	tests/functional/upstream.sh
PROFILE_TESTS := tests/profile/timing.sh

tests: functional-tests profile

functional-tests: $(FUNCTIONAL_TESTS)

.PHONY: $(FUNCTIONAL_TESTS)
$(FUNCTIONAL_TESTS): tests/shunit2
	$(TEST_SHELL) -- $@
	
profile: $(PROFILE_TESTS)

.PHONY: $(PROFILE_TESTS)
$(PROFILE_TESTS): tests/shunit2
	$(TEST_SHELL) -- $@

tests/shunit2:
	git clone https://github.com/kward/shunit2.git tests/shunit2

lint:
	find . -name '*.sh' ! -path './tests/shunit2/*' -print0 | \
		xargs -0 shellcheck -x
	find . -name '*.sh' ! -path './tests/shunit2/*' -print0 | \
		xargs -0 bashate
