
TESTS := $(wildcard tests/test_*.sh)

tests: $(TESTS)

.PHONY: $(TESTS)
$(TESTS): tests/shunit2
	sh $@
	
tests/shunit2:
	git clone https://github.com/kward/shunit2.git tests/shunit2

lint:
	find . -name '*.sh' ! -path './tests/shunit2/*' -print0 | \
		xargs -0 shellcheck -x
	find . -name '*.sh' ! -path './tests/shunit2/*' -print0 | \
		xargs -0 bashate
