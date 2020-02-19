#!/usr/bin/make -f

SHELL := /bin/bash
IMG_NAME := d_alpine-sickchill
IMG_REPO := nforceroh
VERSION := $(shell cat .tag )

.PHONY: all build push gitcommit gitpush
all: build push gitcommit gitpush

build:
	$(eval VERSION=$(shell curl --silent "https://api.github.com/repos/SickChill/SickChill/tags" |jq --raw-output '.[0].name' ) )
	echo "$(VERSION)" >.tag
	@ echo "Building $(IMG_NAME):$(VERSION) image"
	docker build --rm=true --tag=$(IMG_REPO)/$(IMG_NAME) .
	docker tag $(IMG_REPO)/$(IMG_NAME) $(IMG_REPO)/$(IMG_NAME):$(VERSION)
	docker tag $(IMG_REPO)/$(IMG_NAME) $(IMG_REPO)/$(IMG_NAME):latest

gitcommit:
	git push

gitpush:
	@ echo "Building $(IMG_NAME):$(VERSION) image"
	git tag -a $(VERSION) -m "Update to $(VERSION)"
	git push --tags

push:
	@ echo "Building $(IMG_NAME):$(VERSION) image"
	docker push $(IMG_REPO)/$(IMG_NAME):$(VERSION)

end:
	@echo "Done!"