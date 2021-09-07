SHELL=/bin/bash
VENDOR=vendor
BIN=bin
DENO_VERSION=1.11.2
DENO_INSTALLER_VERSION=0.1.4
DEPLOYCTL_VERSION=0.3.0
PURS_VERSION=0.14.3
SPAGO_VERSION=0.20.3
# If some hash is missing on the upstream, one can use
# the following command get the hash: shasum <file>
PURS_HASH=530c2455a5112c209d33aaf93b8836c61897dd6a
SPAGO_HASH=886071f3edfd10aa3c3c8a3d97ad076feb94cfe7
export DENO_INSTALL_ROOT=${VENDOR}/deno
export PATH := ${PWD}/${BIN}:${PATH}

### all ###
.PHONY: all
all: $(BIN)/deno $(BIN)/deployctl $(BIN)/purs $(BIN)/spago

### vendor ###
$(VENDOR):
	mkdir $@

.PHONY: $(VENDOR)/clean
$(VENDOR)/clean: $(VENDOR)/deployctl/clean $(VENDOR)/deno/clean $(VENDOR)/purescript/clean $(BIN)/clean
	-rmdir ${VENDOR}

### bin ###
$(BIN):
	mkdir $@

.PHONY: $(BIN)/clean
$(BIN)/clean: $(BIN)/deployctl/clean $(BIN)/deno/clean $(BIN)/purs/clean $(BIN)/spago/clean
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

### **/*/purescript ###
$(VENDOR)/purescript: | $(VENDOR)
	curl -o /tmp/purescript_linux64.tar.gz -fSL https://github.com/purescript/purescript/releases/download/v${PURS_VERSION}/linux64.tar.gz
	shasum /tmp/purescript_linux64.tar.gz | grep ${PURS_HASH}
	tar -xzf /tmp/purescript_linux64.tar.gz -C ${VENDOR}
	chmod +x ${VENDOR}/purescript/purs
	rm /tmp/purescript_linux64.tar.gz

.PHONY: $(VENDOR)/purescript/clean
$(VENDOR)/purescript/clean:
	-rm -r ${VENDOR}/purescript

### **/*/purs ###
$(BIN)/purs: | $(BIN) $(VENDOR)/purescript
	ln -s ../${VENDOR}/purescript/purs ${BIN}/purs
	purs --version

.PHONY: $(BIN)/purs/clean
$(BIN)/purs/clean:
	-rm ${BIN}/purs

### **/*/spago ###
$(BIN)/spago: | $(BIN)
	curl -o /tmp/spago_Linux.tar.gz -fSL https://github.com/purescript/spago/releases/download/${SPAGO_VERSION}/Linux.tar.gz
	shasum /tmp/spago_Linux.tar.gz | grep ${SPAGO_HASH}
	tar -xzf /tmp/spago_Linux.tar.gz -C ${BIN}
	chmod +x ${BIN}/spago
	rm /tmp/spago_Linux.tar.gz
	spago --version

.PHONY: $(BIN)/spago/clean
$(BIN)/spago/clean:
	-rm ${BIN}/spago

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