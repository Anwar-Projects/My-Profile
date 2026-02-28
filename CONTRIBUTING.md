# Contributing Guidelines

Thank you for your interest in contributing to this profile repository!

## Overview

This is a personal profile repository with dynamic content generation. Contributions help improve the quality, accessibility, and accuracy of the content.

## Content Management

### Editing Profile Content

**Important:** Do not edit `README.md` directly. Instead:

1. Edit `data/profile.yaml` - The single source of truth
2. Run `python scripts/generate_readme.py` to regenerate
3. Commit both files

### Profile Data Structure

The `data/profile.yaml` file contains these main sections:

- `personal` - Name, title, contact info
- `summary` - Professional summary (short and full)
- `objective` - Career objectives
- `skills` - Skills with associated projects
- `tools` - Tools categorized by type
- `certifications` - Professional certifications
- `awards` - Awards and recognition
- `projects` - Project descriptions
- `seo` - SEO metadata
- `themes` - Theme configuration
- `github_stats` - GitHub stats widget config
- `trophies` - GitHub trophies config

### Validation Rules

- **Required fields:** name, title, summary, at least 1 skill, at least 1 certification
- **Skill levels:** beginner, intermediate, advanced, expert
- **Status values:** planned, in-progress, completed
- **URLs:** Must be valid HTTPS URLs

## How to Contribute

### Types of Contributions

We welcome:

- 🐛 **Bug fixes** - Broken links, typos, incorrect data
- 📝 **Content updates** - New skills, certifications, projects
- ♿ **Accessibility improvements** - Alt text, semantic HTML
- 🎨 **Theme improvements** - Better styling, new themes
- 🚀 **Feature enhancements** - New generators, automations

### Contribution Workflow

1. **Fork the repository** (for external contributors)
2. **Create a branch**: `git checkout -b type/scope-description`
   - `fix/links` - Fix broken links
   - `docs/certifications` - Update certifications
   - `feat/theme` - Add new theme
   - `chore/deps` - Update dependencies
3. **Make your changes** following our guidelines
4. **Run validation**: `make lint && make validate`
5. **Commit** with conventional commit format
6. **Push** and create a Pull Request

## Commit Message Format

```
type(scope): description

[optional body]

[optional footer(s)]
```

### Types

- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Formatting, missing semi colons, etc
- `refactor` - Code refactoring
- `test` - Adding tests
- `chore` - Maintenance tasks

### Scopes

- `readme` - README updates
- `data` - YAML data changes
- `templates` - Template changes
- `ci` - CI/CD changes
- `links` - Link updates
- `assets` - Images and assets

### Examples

```
fix(links): update broken certification URL

docs(certifications): add new OSCP badge

feat(themes): add high-contrast theme

chore(ci): update GitHub Actions to v4
```

## Content Guidelines

### Writing Style

- Be concise and professional
- Use active voice
- Include relevant metrics when possible
- Keep descriptions under 200 characters

### Adding Certifications

```yaml
certifications:
  - name: "CERT-NAME"
    full_name: "Full Certification Name"
    issuer: "Issuing Organization"
    url: "https://credential-url"
    image: "https://badge-image-url"
    year: 2024
```

### Adding Projects

```yaml
projects:
  - name: "Project Name"
    description: "Brief description of the project"
    status: "completed"
    tags: ["tag1", "tag2"]
    tech: ["Technology1", "Technology2"]
```

### Adding Skills

```yaml
skills:
  - name: "Skill Name"
    project: "Associated Project"
    project_url: "https://project-url"  # optional
    status: "completed"
    level: "expert"
```

## Local Development

### Prerequisites

- Python 3.11+
- Node.js 20+

### Setup

```bash
# Install dependencies
make install
pip install pyyaml jinja2

# Validate data
python scripts/generate_readme.py --validate-only

# Generate README
python scripts/generate_readme.py --theme dark

# Run all checks
make lint
make validate-links
```

### Makefile Commands

| Command | Description |
|---------|-------------|
| `make help` | Show all available commands |
| `make install` | Install dependencies |
| `make lint` | Run all linters |
| `make fix` | Auto-fix markdown issues |
| `make validate-links` | Check for broken links |
| `make generate` | Generate README from template |

## Validation

All changes must pass:

1. ✅ YAML schema validation
2. ✅ Markdown linting
3. ✅ Link validation
4. ✅ Accessibility checks (where applicable)

### Pre-commit Checks

Run before committing:

```bash
python scripts/generate_readme.py --validate-only
python scripts/check_links.py
make lint
```

## Internationalization (i18n)

For multi-language support:

1. Create locale files in `locales/`
2. Follow the naming convention: `{lang}.yaml`
3. Include all required keys from the base schema

Example:
```yaml
# locales/ar.yaml
personal:
  name: "أنور محمد"
  title: "أخصائي أمن سيبراني"
```

## Code of Conduct

- Be respectful and constructive
- Focus on improving the content
- Provide clear rationale for changes
- Accept feedback gracefully

## Questions?

- Open an issue for questions
- Check existing issues before creating new ones
- Use discussions for broader topics

---

*Last updated: 2024-02-28*
