all: lint

.PHONY: fmt
fmt:
	@stylua lua
