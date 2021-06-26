.PHONY: deps help

SHELL=/bin/bash
DEPS_INSTALL=deps
DENO_VERSION=0.1.4
DENO_INSTALL=${DEPS_INSTALL}/deno

deps: deps/deno

deps/deno:
	mkdir -p ${DEPS_INSTALL}
	curl -fsSL https://deno.land/x/install@v${DENO_VERSION}/install.sh | DENO_INSTALL=${DENO_INSTALL} sh

clean:
	rm -rf ${DEPS_INSTALL}

help:
	@echo "Usage: make { deps | clean | help }" 1>&2 && false