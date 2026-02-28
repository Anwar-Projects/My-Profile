# Architecture Documentation

## Overview
This repository uses a dynamic generation approach to maintain a professional GitHub profile README with multiple output formats and themes.

## System Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ data/       │────>│ scripts/    │────>│ README.md   │
│ profile.yaml│     │ generate_*  │     │ (generated) │
└─────────────┘     └─────────────┘     └─────────────┘
       │                   ▲
       │             ┌─────┴─────┐
       │             │ templates/│
       │             │ *.j2      │
       │             └───────────┘
       │
       ▼
┌─────────────┐
│ locales/    │
│ i18n files  │
└─────────────┘
```

## Components

### Data Layer
- `data/profile.yaml` - Single source of truth
- `data/schema.json` - Validation schema

### Generation Layer
- `scripts/generate_readme.py` - Main generator
- `scripts/check_links.py` - Link validator
- `templates/README.md.j2` - Jinja2 template

### Output Layer
- `README.md` - Generated GitHub profile
- Future: `resume.md`, `linkedin.md`

### CI/CD Layer
- `.github/workflows/ci-advanced.yml` - Comprehensive checks
- `.github/workflows/auto-update.yml` - Scheduled updates

## Theme System
Themes defined in `data/profile.yaml`:
- `dark` - GitHub dark mode
- `light` - GitHub light mode
- `high-contrast` - Accessibility optimized

## Internationalization
Multi-language support via `locales/{lang}/messages.yaml`:
- `en` - English (default)
- `ar` - Arabic

## Validation Pipeline
1. YAML syntax validation
2. Schema validation
3. Link checking
4. Markdown linting
5. Accessibility checks

## Security Considerations
- No secrets in generated output
- Link validation prevents malicious URLs
- Theme CSS is static (no XSS vectors)
