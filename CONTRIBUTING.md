# Contributing Guidelines

## How to Contribute

This is a personal profile repository. Contributions are limited to:

- Bug fixes for broken links
- Accessibility improvements
- Spelling/grammar corrections
- Image optimization

## Before Submitting

1. Run linting: `make lint`
2. Verify all links work: `make validate-links`
3. Check formatting: `make fix`

## Commit Message Format

```
type(scope): description

type: chore|docs|fix|refactor
scope: readme|assets|links|structure
```

Examples:
- `fix(links): update broken certification URL`
- `docs(readme): add new project entry`
- `chore(structure): reorganize assets directory`
