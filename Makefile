.DEFAULT_GOAL := help

.PHONY: help
help: ## Print Makefile help.
	@grep -Eh '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-28s\033[0m %s\n", $$1, $$2}'


venv: ## Create python3 virtual environment
	python3 -m venv venv

.PHONY: requirements
requirements: .requirements ## Install and configure required environment
.requirements: venv
	. venv/bin/activate && pip3 install -r requirements.txt
	touch .requirements

.PHONY: install-hosts-file
generate-hosts-file:
	. venv/bin/activate && python3 updateHostsFile.py

.PHONY: install-hosts-file
install-hosts-file:
	. venv/bin/activate && python3 updateHostsFile.py --auto --replace
