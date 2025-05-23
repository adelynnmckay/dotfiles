.PHONY: install
install: lnsrc

.PHONY: test
test: pytest

include $$HOME/lib/lnsrc.mk
