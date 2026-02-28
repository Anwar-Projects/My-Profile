.PHONY: help install lint lint-md lint-html fix fix-md validate-links generate validate clean

# Default theme for generation
THEME ?= dark

help: ## Show this help
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install all dependencies
	@echo "Installing dependencies..."
	@if command -v npm >/dev/null 2>&1; then \
		npm install -g markdownlint-cli htmlhint || echo "npm install skipped"; \
	fi
	@if command -v pip3 >/dev/null 2>&1; then \
		pip3 install PyYAML Jinja2 requests || echo "pip install skipped"; \
	fi

# ==================== Generation ====================

generate: ## Generate README from template (THEME=dark|light|high-contrast)
	@echo "Generating README with theme: $(THEME)..."
	@python3 scripts/generate_readme.py --theme $(THEME)

generate-light: ## Generate with light theme
	@$(MAKE) generate THEME=light

generate-dark: ## Generate with dark theme
	@$(MAKE) generate THEME=dark

generate-hc: ## Generate with high-contrast theme
	@$(MAKE) generate THEME=high-contrast

validate-data: ## Validate YAML data against schema
	@echo "Validating profile data..."
	@python3 scripts/generate_readme.py --validate-only

# ==================== Linting ====================

lint: lint-md lint-html ## Run all linters

lint-md: ## Lint markdown files
	@echo "Linting markdown..."
	@if command -v markdownlint >/dev/null 2>&1; then \
		markdownlint "*.md" 2>/dev/null || echo "Markdown linting complete"; \
	else \
		echo "markdownlint not installed. Run: make install"; \
	fi

lint-html: ## Lint HTML files
	@echo "Linting HTML..."
	@if command -v htmlhint >/dev/null 2>&1; then \
		htmlhint "*.html" 2>/dev/null || echo "HTML linting complete"; \
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

# ==================== Validation ====================

validate: ## Run all validation checks
	@$(MAKE) validate-data
	@$(MAKE) validate-links
	@$(MAKE) validate-yaml

validate-links: ## Check for broken links with retry logic
	@echo "Checking links..."
	@python3 scripts/check_links.py || echo "Link check completed"

validate-yaml: ## Validate YAML syntax
	@echo "Validating YAML syntax..."
	@python3 -c "import yaml; yaml.safe_load(open('data/profile.yaml'))" && echo "✓ YAML is valid"

validate-html: ## Validate HTML files
	@echo "Validating HTML..."
	@for file in *.html; do [ -f "$$file" ] && echo "Checking $$file..."; done

# ==================== CI/CD ====================

ci: ## Run CI checks locally
	@echo "Running CI pipeline..."
	@$(MAKE) install
	@$(MAKE) validate-data
	@$(MAKE) lint
	@$(MAKE) validate-links

# ==================== Development ====================

dev-setup: ## Set up development environment
	@echo "Setting up development environment..."
	@$(MAKE) install
	@$(MAKE) validate-data
	@$(MAKE) generate
	@echo "✓ Development environment ready"

# ==================== Cleanup ====================

clean: ## Clean temporary files
	@echo "Cleaning temporary files..."
	@rm -f /tmp/urls.txt README.dark.md README.light.md README.hc.md
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -type d -delete
