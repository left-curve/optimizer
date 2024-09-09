# Docker name (DN) for the image
DN_OPTIMIZER := "leftcurve/optimizer"
DOCKER_TAG := 0.17.0-rc.0

# Native arch
BUILDARCH := $(shell uname -m)

# Build the native CPU arch images
.PHONY: build
build: build-$(BUILDARCH)

.PHONY: build-x86_64
build-x86_64:
	docker buildx build --pull --platform linux/amd64 -t $(DN_OPTIMIZER):$(DOCKER_TAG) --target rust-optimizer --load .

.PHONY: build-arm64
build-arm64:
	docker buildx build --pull --platform linux/arm64/v8 -t $(DN_OPTIMIZER)-arm64:$(DOCKER_TAG) --target rust-optimizer --load .

.PHONY: publish-x86_64
publish-x86_64: build-x86_64
	docker push $(DN_OPTIMIZER):$(DOCKER_TAG)

.PHONY: publish-arm64
publish-arm64: build-arm64
	docker push $(DN_OPTIMIZER)-arm64:$(DOCKER_TAG)
