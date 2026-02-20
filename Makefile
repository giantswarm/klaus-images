# DO NOT EDIT. Generated with:
#
#    devctl
#
#    https://github.com/giantswarm/devctl/blob/6a704f7e2a8b0f09e82b5bab88f17971af849711/pkg/gen/input/makefile/internal/file/Makefile.template
#

include Makefile.*.mk

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z%\\\/_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

GO_VERSION ?= 1.25
REGISTRY ?= gsoci.azurecr.io/giantswarm
VERSION ?= dev

KLAUS_ANNOTATIONS = \
	--annotation "manifest:io.giantswarm.klaus.type=toolchain" \
	--annotation "manifest:io.giantswarm.klaus.version=$(VERSION)"

.PHONY: build-all
build-all: build-klaus-git build-klaus-git-debian build-klaus-go build-klaus-go-debian build-klaus-python build-klaus-python-debian ## Build all images locally.

.PHONY: build-klaus-git
build-klaus-git: ## Build klaus-git (Alpine).
	docker buildx build --load -t $(REGISTRY)/klaus-git:$(VERSION) \
		$(KLAUS_ANNOTATIONS) --annotation "manifest:io.giantswarm.klaus.name=git" \
		-f klaus-git/Dockerfile klaus-git

.PHONY: build-klaus-git-debian
build-klaus-git-debian: ## Build klaus-git-debian.
	docker buildx build --load -t $(REGISTRY)/klaus-git-debian:$(VERSION) \
		$(KLAUS_ANNOTATIONS) --annotation "manifest:io.giantswarm.klaus.name=git" \
		-f klaus-git/Dockerfile.debian klaus-git

.PHONY: build-klaus-go
build-klaus-go: ## Build klaus-go (Alpine).
	docker buildx build --load --build-arg GO_VERSION=$(GO_VERSION) -t $(REGISTRY)/klaus-go:$(VERSION) \
		$(KLAUS_ANNOTATIONS) --annotation "manifest:io.giantswarm.klaus.name=go" \
		-f klaus-go/Dockerfile klaus-go

.PHONY: build-klaus-go-debian
build-klaus-go-debian: ## Build klaus-go-debian.
	docker buildx build --load --build-arg GO_VERSION=$(GO_VERSION) -t $(REGISTRY)/klaus-go-debian:$(VERSION) \
		$(KLAUS_ANNOTATIONS) --annotation "manifest:io.giantswarm.klaus.name=go" \
		-f klaus-go/Dockerfile.debian klaus-go

.PHONY: build-klaus-python
build-klaus-python: ## Build klaus-python (Alpine).
	docker buildx build --load -t $(REGISTRY)/klaus-python:$(VERSION) \
		$(KLAUS_ANNOTATIONS) --annotation "manifest:io.giantswarm.klaus.name=python" \
		-f klaus-python/Dockerfile klaus-python

.PHONY: build-klaus-python-debian
build-klaus-python-debian: ## Build klaus-python-debian.
	docker buildx build --load -t $(REGISTRY)/klaus-python-debian:$(VERSION) \
		$(KLAUS_ANNOTATIONS) --annotation "manifest:io.giantswarm.klaus.name=python" \
		-f klaus-python/Dockerfile.debian klaus-python
