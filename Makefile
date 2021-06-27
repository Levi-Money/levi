.PHONY: deps clean help

SHELL=/bin/bash
DEPS=deps
BIN=bin
DENO_VERSION=1.11.2
DENO_INSTALLER_VERSION=0.1.4
export PATH := ${BIN}:${PATH}

# All #
all: deps

# Dirs #
dirs:
	mkdir -p ${DEPS}
	mkdir -p ${BIN}
	export PATH

dirs/clean:
	rm -r ${BIN}
	rm -r ${DEPS}

# Deps #
deps: dirs deps/deno

deps/deno: dirs
	curl -fsSL https://deno.land/x/install@v${DENO_INSTALLER_VERSION}/install.sh | DENO_INSTALL=${DEPS}/deno sh -s -- v${DENO_VERSION}
	ln -s ../${DEPS}/deno/bin/deno ${BIN}

deps/deno/clean:
	rm ${BIN}/deno
	rm -r ${DEPS}/deno

deps/clean: deps/deno/clean

# Clean #
clean: deps/clean dirs/clean

# Help #
help:
	@echo "Usage: make { all | deps | clean | help }" 1>&2 && false