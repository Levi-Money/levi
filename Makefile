.PHONY: deps clean help

SHELL=/bin/bash
DEPS_INSTALL=deps
DEPS_BIN=${DEPS_INSTALL}/.bin
DENO_VERSION=0.1.4
DENO_INSTALL=${DEPS_INSTALL}/deno

# All #
all: deps

# Deps #
deps: deps/dirs deps/deno

deps/dirs:
	mkdir ${DEPS_INSTALL}
	mkdir ${DEPS_BIN}

deps/deno: deps/dirs
	curl -fsSL https://deno.land/x/install@v${DENO_VERSION}/install.sh | DENO_INSTALL=${DENO_INSTALL} sh

# Clean #
clean:
	rm -rf ${DENO_INSTALL}
	rm -rf ${DEPS_BIN}
	rm -rf ${DEPS_INSTALL}

# Help #
help:
	@echo "Usage: make { all | deps | clean | help }" 1>&2 && false