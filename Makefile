VERSION := $(shell cat VERSION)
IMAGE   := gcr.io/helios-devel/hellonode:$(VERSION)

default: build run

build:
	@echo '> Building "." docker image...'
	@docker build -t $(IMAGE) .

run:
	@echo '> Starting "." container...'
	@docker run -d $(IMAGE)

ci:
	@fly -t ci set-pipeline -p . -c config/pipelines/review.yml --load-vars-from config/pipelines/secrets.yml -n
	@fly -t ci unpause-pipeline -p .

deploy:
	@helm install ./config/charts/. --set "image.tag=$(VERSION)"
