.PHONY: deps clean help

SHELL=/bin/bash
DEPS=deps
BIN=bin
DENO_VERSION=1.11.2
DENO_INSTALLER_VERSION=0.1.4
export DENO_INSTALL_ROOT=${DEPS}/deno
export PATH := ${BIN}:${PATH}

### All ###
all: deps

### Env ###
env:
	export PATH
	export DENO_INSTALL_ROOT

### Dirs ###
dirs: env
	mkdir -p ${DEPS}
	mkdir -p ${BIN}

dirs/clean:
	rm -r ${BIN}
	rm -r ${DEPS}

### Deps ###
deps: dirs deps/deno deps/deployctl

deps/deno: dirs
	curl -fsSL https://deno.land/x/install@v${DENO_INSTALLER_VERSION}/install.sh | DENO_INSTALL=${DENO_INSTALL_ROOT} sh -s -- v${DENO_VERSION}
	ln -s ../${DEPS}/deno/bin/deno ${BIN}
	deno --version

deps/deno/clean:
	rm ${BIN}/deno
	rm -r ${DEPS}/deno

deps/deployctl: deps/deno
	deno install --allow-read --allow-write --allow-env --allow-net --allow-run --no-check -f https://deno.land/x/deploy/deployctl.ts
	ln -s ../${DEPS}/deno/bin/deployctl ${BIN}

deps/deployctl/clean:
	rm ${BIN/deployctl
	rm ${DEPS}/deno/bin/deployctl

deps/clean: deps/deployctl/clean deps/deno/clean

### Clean ###
clean: deps/clean dirs/clean

### Help ###
help:
	@echo "Usage: make { all | deps | clean | help }" 1>&2 && false