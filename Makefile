.PHONY: deps help

SHELL=/bin/bash
VENDOR_INSTALL=deps
DENO_VERSION=0.1.4
DENO_INSTALL=${VENDOR_INSTALL}/deno

deps: deps/deno

deps/deno:
	mkdir -p deps
	curl -fsSL https://deno.land/x/install@v${DENO_VERSION}/install.sh | DENO_INSTALL=${DENO_INSTALL} sh

help:
	@echo "Usage: make { deps | help }" 1>&2 && false