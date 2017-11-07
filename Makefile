VERSION := $(shell cat VERSION)
IMAGE   := hellonode:$(VERSION)

.PHONY: default build push run ci deploy

default: build run

build:
	@echo '> Building "hellonode" docker image...'
	@docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)

run:
	@echo '> Starting "hellonode" container...'
	@docker run -d $(IMAGE)

ci:
	@fly -t ci set-pipeline -p hellonode -c config/pipelines/review.yml -n
	@fly -t ci unpause-pipeline -p hellonode

deploy: build
	@helm install ./config/charts/hellonode --set "image.tag=$(VERSION)"
