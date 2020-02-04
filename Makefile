#!/usr/bin/make -f

SHELL := /bin/bash
IMG_NAME := d_alpine_sickchill
IMG_REPO := nforceroh

.PHONY: all x86_64 end
all: x86_64

build:
	$(eval VERSION=$(shell curl --silent "https://api.github.com/repos/SickChill/SickChill/tags" |jq --raw-output '.[0].name' ) )
	@ echo "Building $(IMG_NAME):$(VERSION) image for $(ARCH)"
	docker build --rm=true --tag=$(IMG_REPO)/$(IMG_NAME) .
	docker tag $(IMG_REPO)/$(IMG_NAME) $(IMG_REPO)/$(IMG_NAME):$(VERSION)
	docker tag $(IMG_REPO)/$(IMG_NAME) $(IMG_REPO)/$(IMG_NAME):latest

gitcommit:
	

gitpush:
	git tag -a $(VERSION) -m "Update to $(VERSION)"
	git push --tags

push:
	docker push $(IMG_REPO)/$(IMG_NAME):$(VERSION)

end:
	@echo "Done!"