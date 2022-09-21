all: lint

.PHONY: fmt
fmt:
	@stylua lua/

.PHONY: lint
lint:
	@luacheck lua/

.PHONY: test
test:
	nvim --headless -c "PlenaryBustedDirectory lua/tests/ { minimal_init = 'lua/tests/minimal_init.vim' }"
