# ADR 001: Jinja2 Templating for README Generation

## Status
Accepted

## Context
The profile README needed to be maintainable and consistent. Manual updates were error-prone and led to inconsistencies between sections. We needed a way to:
- Maintain a single source of truth for profile data
- Support multiple output formats (GitHub, Resume, LinkedIn)
- Enable theme switching (dark/light/high-contrast)
- Automate updates via CI/CD

## Decision
Use Jinja2 templating with YAML data sources:

1. **YAML Data File** (`data/profile.yaml`) - Centralized configuration
2. **Jinja2 Templates** (`templates/*.j2`) - Reusable layouts
3. **Python Generator** (`scripts/generate_readme.py`) - Build tool

## Consequences

### Positive
- Single source of truth ensures consistency
- Easy to add new output formats (resume, LinkedIn)
- Theme support enables accessibility preferences
- Automated via GitHub Actions
- Version-controlled content history

### Negative
- Added dependency on Python ecosystem
- Requires learning Jinja2 for contributors
- Slightly more complex setup than static markdown

## Alternatives Considered

| Alternative | Pros | Cons |
|-------------|------|------|
| Static Markdown | Simple, no tooling | Manual updates, inconsistent |
| JavaScript/React | Rich interactivity | Overkill for static content |
| Go Templates | Fast, compiled | Less familiar to community |
| Custom DSL | Tailored | Maintenance burden |

## Related Decisions
- ADR 002: GitHub Actions for Auto-Update
- ADR 003: YAML Schema Validation

## References
- [Jinja2 Documentation](https://jinja.palletsprojects.com/)
- [YAML Specification](https://yaml.org/spec/)
