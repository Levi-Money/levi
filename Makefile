.PHONY: deps clean help

SHELL=/bin/bash
DEPS_INSTALL=deps
DEPS_BIN=${DEPS_INSTALL}/.bin
DENO_INSTALLER_VERSION=0.1.4
DENO_INSTALL=${DEPS_INSTALL}/deno
DENO_VERSION=1.11.2
export PATH := ${DEPS_BIN}:${PATH}

# All #
all: deps

# Deps #
deps: deps/setup deps/deno

deps/setup:
	mkdir ${DEPS_INSTALL}
	mkdir ${DEPS_BIN}

deps/setup/clean:
	rm -rf ${DEPS_BIN}
	rm -rf ${DEPS_INSTALL}

deps/deno: deps/setup
	curl -fsSL https://deno.land/x/install@v${DENO_INSTALLER_VERSION}/install.sh | DENO_INSTALL=${DENO_INSTALL} sh -s -- v${DENO_VERSION}

deps/deno/clean:
	rm -rf ${DENO_INSTALL}

deps/clean: deps/deno/clean deps/setup/clean

# Clean #
clean: deps/clean

# Help #
help:
	@echo "Usage: make { all | deps | clean | help }" 1>&2 && false