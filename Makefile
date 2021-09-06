SHELL=/bin/bash
VENDOR=vendor
BIN=bin
DENO_VERSION=1.11.2
DENO_INSTALLER_VERSION=0.1.4
DEPLOYCTL_VERSION=0.3.0
export DENO_INSTALL_ROOT=${VENDOR}/deno
export PATH := ${PWD}/${BIN}:${PATH}

### all ###
.PHONY: all
all: $(BIN)/deno $(BIN)/deployctl

### vendor ###
$(VENDOR):
	mkdir $@

.PHONY: $(VENDOR)/clean
$(VENDOR)/clean: $(VENDOR)/deployctl/clean $(VENDOR)/deno/clean $(BIN)/clean
	-rmdir ${VENDOR}

### bin ###
$(BIN):
	mkdir $@

.PHONY: $(BIN)/clean
$(BIN)/clean: $(BIN)/deployctl/clean $(BIN)/deno/clean
	-rmdir ${BIN}

### **/*/deno ###
$(VENDOR)/deno: | $(VENDOR)
	curl -fsSL https://deno.land/x/install@v${DENO_INSTALLER_VERSION}/install.sh | DENO_INSTALL=${DENO_INSTALL_ROOT} sh -s -- v${DENO_VERSION}

.PHONY: $(VENDOR)/deno/clean
$(VENDOR)/deno/clean:
	-rm -r ${VENDOR}/deno

$(BIN)/deno: | $(BIN) $(VENDOR)/deno
	ln -s ../${VENDOR}/deno/bin/deno $@
	deno --version

.PHONY: $(BIN)/deno/clean
$(BIN)/deno/clean:
	-rm ${BIN}/deno

### **/*/deployctl ###
$(VENDOR)/deployctl: | $(BIN)/deno
	@deno install --allow-read --allow-write --allow-env --allow-net --allow-run --no-check -f https://deno.land/x/deploy@${DEPLOYCTL_VERSION}/deployctl.ts
	mkdir $@
	${VENDOR}/deno/bin/deployctl types > $@/deploy.d.ts

.PHONY: $(VENDOR)/deployctl/clean
$(VENDOR)/deployctl/clean:
	-rm ${VENDOR}/deployctl/deploy.d.ts
	-rm -r ${VENDOR}/deployctl
	-rm ${VENDOR}/deno/bin/deployctl

$(BIN)/deployctl: | $(BIN) $(VENDOR)/deployctl
	ln -s ../${VENDOR}/deno/bin/deployctl ${BIN}/deployctl
	deployctl --version

.PHONY: $(BIN)/deployctl/clean
$(BIN)/deployctl/clean:
	-rm ${BIN}/deployctl

### clean ###
.PHONY: clean
clean: $(VENDOR)/clean

### bash ###
.PHONY: bash
bash: all
	bash

### help ###
.PHONY: help
help:
	@echo "Usage: make { all | clean | help }" 1>&2 && false