.PHONY: help lint lint-md lint-html fix fix-md validate-links install clean

help: ## Show this help
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'

install: ## Install linting dependencies
	@echo "Installing dependencies..."
	@if command -v npm >/dev/null 2>&1; then \
		npm install -g markdownlint-cli htmlhint 2>/dev/null || echo "npm install skipped - install manually"; \
	else \
		echo "npm not found. Please install Node.js/npm."; \
	fi

lint: lint-md lint-html ## Run all linters

lint-md: ## Lint markdown files
	@echo "Linting markdown..."
	@if command -v markdownlint >/dev/null 2>&1; then \
		markdownlint "*.md" 2>/dev/null || echo "Markdown linting found issues"; \
	else \
		echo "markdownlint not installed. Run: make install"; \
	fi

lint-html: ## Lint HTML files
	@echo "Linting HTML..."
	@if command -v htmlhint >/dev/null 2>&1; then \
		htmlhint "*.html" 2>/dev/null || echo "HTML linting found issues"; \
	else \
		echo "htmlhint not installed. Run: make install"; \
	fi

fix: fix-md ## Auto-fix linting issues

fix-md: ## Auto-fix markdown issues
	@echo "Auto-fixing markdown..."
	@if command -v markdownlint >/dev/null 2>&1; then \
		markdownlint --fix "*.md" 2>/dev/null || true; \
	else \
		echo "markdownlint not installed"; \
	fi

validate-links: ## Check for broken/placeholder links
	@echo "Checking links..."
	@grep -rEo '(https?|ftp)://[^[:space:]\"]+' --include="*.md" --include="*.html" . 2>/dev/null | \
		grep -v "shields.io" | grep -v "camo.githubusercontent" | sed 's/^/[LINK] /' || true
	@echo "Note: Manual verification recommended for external URLs"

clean: ## Clean temporary files
	@rm -f /tmp/urls.txt
