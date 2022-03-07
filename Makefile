.PHONY: image test

IMAGE_NAME ?= codeclimate/codeclimate-yamllint

SLIM_IMAGE_NAME ?= codeclimate/codeclimate-yamllint:slim


image:
	docker build --rm -t $(IMAGE_NAME) .

slim: image
	docker-slim build --tag $(SLIM_IMAGE_NAME) --http-probe=false --exec 'yamllint . && yamllint --version' --mount "$$PWD/tests/example:/work" --workdir '/work' --include-path '/usr/lib/python3.9/site-packages/yamllint' --include-path '/usr/lib/python3.9/site-packages/yaml' --include-path '/usr/lib/python3.9/site-packages/pathspec' $(IMAGE_NAME) && prettier --write slim.report.json

test: slim
	container-structure-test test --image $(IMAGE_NAME) --config tests/container-test-config.yaml && container-structure-test test --image $(SLIM_IMAGE_NAME) --config tests/container-test-config.yaml
