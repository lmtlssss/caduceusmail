PYTHONPATH ?= src
VERSION := $(shell cat VERSION)
NAME := caduceusmail

.PHONY: test smoke doctor bundle clean

test:
	PYTHONPATH=$(PYTHONPATH) python3 -m pytest -q

smoke:
	bash ./scripts/caduceusmail-sandbox-smoke.sh

doctor:
	PYTHONPATH=$(PYTHONPATH) python3 ./scripts/caduceusmail-doctor.py --json

bundle:
	mkdir -p dist
	rm -f dist/$(NAME)-$(VERSION).zip
	zip -r dist/$(NAME)-$(VERSION).zip . -x 'dist/*' -x '.git/*' -x '__pycache__/*' -x '.pytest_cache/*' -x '.venv/*' -x 'credentials/*.txt'

clean:
	rm -rf .pytest_cache dist
