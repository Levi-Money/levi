SHELL=/bin/bash
VENDOR=vendor
BIN=.bin
PACKAGES=packages
DENO_VERSION=1.11.2
DENO_INSTALLER_VERSION=0.1.4
DEPLOYCTL_VERSION=0.3.0
PURS_VERSION=0.14.4
SPAGO_VERSION=0.20.3
# If some hash is missing on the upstream, one can use
# the following command get the hash: shasum <file>
PURS_HASH=02b11e76de5cf0c4262ab69586ccc5de89c9afea
SPAGO_HASH=886071f3edfd10aa3c3c8a3d97ad076feb94cfe7
export DENO_INSTALL_ROOT=${VENDOR}/deno
export PATH := ${PWD}/${BIN}:${PATH}

DENO_PKGS = ${PACKAGES}/portal
SPAGO_PKGS = ${PACKAGES}/app

DENO_ALL = $(foreach PKG,$(DENO_PKGS),$(addsuffix /$(BIN),$(PKG)))
SPAGO_ALL = $(foreach PKG,$(SPAGO_PKGS),$(addsuffix /$(BIN),$(PKG))) $(foreach PKG,$(SPAGO_PKGS),$(addsuffix /.spago,$(PKG)))

### all ###
.PHONY: all
all: $(BIN)/deno $(BIN)/deployctl $(BIN)/purs $(BIN)/spago $(DENO_ALL) $(SPAGO_ALL)

### vendor ###
$(VENDOR):
	mkdir $@

.PHONY: $(VENDOR)/clean
$(VENDOR)/clean: $(VENDOR)/deployctl/clean $(VENDOR)/deno/clean $(VENDOR)/purescript/clean $(BIN)/clean
	-rmdir ${VENDOR}

### **/*/bin ###
$(BIN):
	mkdir $@

.PHONY: $(BIN)/clean
$(BIN)/clean: $(BIN)/deployctl/clean $(BIN)/deno/clean $(BIN)/purs/clean $(BIN)/spago/clean
	-rmdir ${BIN}

%/.bin: $(BIN)
	ln -s ../../$(BIN) $@

.PHONY: %/.bin/clean
%/.bin/clean: $(BIN)/clean
	-rm $(@D)

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

### bash ###
.PHONY: bash
bash: all
	bash

### build ###
.PHONY: build
build: $(PACKAGES)/app/index.js

### PureScript  ###

### **/.spago (spago install) ###
%/.spago: packages.dhall %/spago.dhall %/.bin | $(BIN)/spago
	cd $(@D); spago install;
	touch $@

.PHONY: %/.spago/clean %/$(BIN)/clean
%/.spago/clean:
	-rm -rf $(@D)

### **/output (spago build) ###
%/output: %/.spago | $(BIN)/spago
	cd $(@D); spago build;

.PHONY: %/output/clean
%/output/clean: %/.spago/clean
	-rm -r $(@D)

### **/index.js (spago bundle-app) ###
%/index.js: %/.spago | $(BIN)/spago
	cd $(@D); spago bundle-app;

.PHONY: %/index.js/clean
%/index.js/clean: %/output/clean
	-rm $(@D)

### clean ###
.PHONY: clean
clean: $(VENDOR)/clean $(PACKAGES)/app/index.js/clean

### help ###
.PHONY: help
help:
	@echo "Usage: make { all | build | clean | help }" 1>&2 && false