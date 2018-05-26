
TESTS := $(wildcard tests/test_*.sh)

tests: $(TESTS)

.PHONY: $(TESTS)
$(TESTS): tests/shunit2
	sh $@
	
tests/shunit2:
	git clone https://github.com/kward/shunit2.git tests/shunit2

