.DEFAULT_GOAL := help

.PHONY: help
help: ## Print Makefile help.
	@grep -Eh '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

venv: ## Create python3 virtual environment
	python3 -m venv venv

.PHONY: requirements
requirements: .requirements ## Install and configure required environment
.requirements: venv
	. venv/bin/activate && pip3 install -r requirements.txt
	touch .requirements

.PHONY: install-hosts-file
generate-hosts-file: ## Interactively generate a file in the current directory
	. venv/bin/activate && python3 updateHostsFile.py

.PHONY: install-hosts-file
install-hosts-file: ## Automatically generate the /etc/hosts file and create backup
	. venv/bin/activate && python3 updateHostsFile.py --auto --replace --backup

ORIGIN=git@github.com:danielhoherd/hosts.git
UPSTREAM=git@github.com:StevenBlack/hosts.git

.PHONY: remotes
remotes: ## Create git remotes.
	git remote add origin ${ORIGIN} 2> /dev/null || \
    git remote set-url origin ${ORIGIN}
	git remote add upstream ${UPSTREAM} 2> /dev/null || \
    git remote set-url upstream ${UPSTREAM}
