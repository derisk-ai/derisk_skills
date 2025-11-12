.DEFAULT_GOAL := prepare

.PHONY: help
help: # Show avaliable make targets.
	@echo "Available make targets:"
	@awk 'BEGIN {FS = ":.*#"} /^[a-zA-Z_-]+:.*#/{printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: prepare
prepare: download-deps ## Sync and prepare all dependencies.
	uv sync --frozen


.PHONY: format
format: ## Auto-format Python sources with ruff.
	uv run ruff check --fix
	uv run ruff format

.PHONY: check
check: ## Run linting and type checks
	uv run ruff check
	uv run ruff format --check
	uv run pyright

.PHONY: test
test: ## Run all tests.
	uv run pytest tests -vv

# .PHONY: build
# build: ## Build the standalone executable with PyInstaller
# 	uv run pyinstaller derisk.spec

.PHONY: ai-test
ai-test: ## Run the test suite with DeRisk CLI.
	uv run tests/tests_cli.py

