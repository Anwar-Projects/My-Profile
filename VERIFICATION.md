# Verification Commands

## Quick Start

### 1. Generate README from Template
```bash
python3 scripts/generate_readme.py --theme dark
python3 scripts/generate_readme.py --theme light
python3 scripts/generate_readme.py --theme high-contrast
```

### 2. Validate Data
```bash
make validate-data
# or
python3 scripts/generate_readme.py --validate-only
```

### 3. Run CI Checks
```bash
make ci
```

## Detailed Verification

### Data Validation
```bash
# Validate YAML syntax
make validate-yaml

# Validate against JSON schema
python3 -c "import json, yaml; schema=json.load(open('data/schema.json')); data=yaml.safe_load(open('data/profile.yaml')); print('✓ Schema valid')"
```

### Link Checking
```bash
# Check all links with retry logic
make validate-links
# or
python3 scripts/check_links.py
```

### Linting
```bash
# Install linting tools
make install

# Lint all files
make lint

# Fix auto-fixable issues
make fix
```

### Theme Preview
```bash
# Generate all theme variants
make preview-themes
# Creates: README.dark.md, README.light.md, README.hc.md
```

## GitHub Actions Verification

### Test CI Workflow Locally
```bash
# Act (if installed)
act -j generate
act -j validate
```

### Trigger Auto-Update
```bash
# Trigger via GitHub CLI
g workflow run auto-update.yml
```

## Content Updates

### Adding a New Skill
1. Edit `data/profile.yaml`
2. Add to `skills:` section:
```yaml
- name: "New Skill"
  project: "Project Name"
  project_url: "https://..."
  status: "planned"  # or in-progress, completed
  level: "expert"    # or beginner, intermediate, advanced
```
3. Run `make generate`
4. Commit both files

### Adding a Certification
1. Edit `data/profile.yaml`
2. Add to `certifications:` section:
```yaml
- name: "CERT-NAME"
  full_name: "Full Name"
  issuer: "Issuer"
  url: "https://credential-url"
  image: "https://badge-image"
  year: 2024
```
3. Run `make generate`

### Adding a Project
1. Edit `data/profile.yaml`
2. Add to `projects:` section:
```yaml
- name: "Project Name"
  description: "Description"
  status: "completed"
  tags: ["tag1", "tag2"]
  tech: ["Tech1", "Tech2"]
```
3. Run `make generate`

## All Make Commands

```bash
make help              # Show all commands
make install           # Install dependencies
make generate          # Generate README (THEME=dark|light|high-contrast)
make generate-dark     # Generate with dark theme
make generate-light    # Generate with light theme
make generate-hc       # Generate with high-contrast theme
make validate-data     # Validate YAML data
make lint              # Run all linters
make validate-links    # Check broken links
make ci                # Run full CI pipeline
make clean             # Clean temporary files
make dev-setup         # Setup dev environment
make preview-themes    # Generate all themes
make adr-list          # List ADRs
make changelog         # Generate changelog
```

## Troubleshooting

### "No module named yaml"
```bash
apt-get install python3-yaml python3-jinja2
# or
pip3 install PyYAML Jinja2
```

### Template Errors
```bash
# Test templates compile
python3 -c "
import jinja2
env = jinja2.Environment(loader=jinja2.FileSystemLoader('templates'))
template = env.get_template('README.md.j2')
print('✓ Templates compile successfully')
"
```

### Link Check Failures
```bash
# Some links may fail due to rate limiting
# The script already has retry logic (3 attempts)
# For critical links, verify manually

python3 scripts/check_links.py | grep "✗"
```
