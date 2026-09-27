LAB ?=

PROLOG_FILES = $(shell find logical -name '*.pl' | sort)
FSHARP_FILES = $(shell find functional -name '*.fsx' | sort)
LAB_DIRS = $(shell find logical functional -mindepth 1 -maxdepth 1 -type d | sort)

PRE_COMMIT_CONFIG := .config/.pre-commit-config.yaml

-include .config/local.mk

.DEFAULT_GOAL := help

.PHONY: help setup tools format lint run smoke ci clean

help:
	@echo "make setup                                   restore .NET tools and install the pre-commit hook"
	@echo "make tools                                   restore .NET tools (Fantomas)"
	@echo "make run   LAB=logical/labN|functional/labN   run every program of the lab"
	@echo "make format                                  apply all formatters"
	@echo "make lint                                    pre-commit hooks, Fantomas, SWI-Prolog warnings"
	@echo "make smoke                                   run every lab and require exit code 0"
	@echo "make ci                                      everything CI runs"
	@echo "make clean                                   remove build outputs"

setup: tools
	pre-commit install -c $(PRE_COMMIT_CONFIG)

tools:
	dotnet tool restore

format: tools
	-pre-commit run -c $(PRE_COMMIT_CONFIG) --all-files
	dotnet fantomas $(FSHARP_FILES)

lint: tools
	pre-commit run -c $(PRE_COMMIT_CONFIG) --all-files --show-diff-on-failure
	dotnet fantomas --check $(FSHARP_FILES)
	@for file in $(PROLOG_FILES); do \
		echo "swipl check $$file"; \
		swipl --on-warning=status --on-error=status -g halt -t 'halt(1)' "$$file" < /dev/null > /dev/null || exit 1; \
	done

run:
	@test -n "$(LAB)" || (echo "LAB is required" >&2; exit 2)
	@for file in $(sort $(wildcard $(LAB)/*.pl)); do swipl "$$file" < /dev/null || exit 1; done
	@for file in $(sort $(wildcard $(LAB)/*.fsx)); do dotnet fsi --quiet "$$file" || exit 1; done

smoke:
	@for dir in $(LAB_DIRS); do \
		echo "smoke $$dir"; \
		$(MAKE) --no-print-directory run LAB=$$dir > /dev/null || exit 1; \
	done

ci: lint smoke

clean:
	rm -rf build bin obj
