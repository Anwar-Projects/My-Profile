# ADR 002: GitHub Actions for Auto-Update

## Status
Accepted

## Context
Profile data changes need to be reflected in the README automatically. Manual updates are forgotten, leading to stale content. We need a reliable way to regenerate the README when data changes.

## Decision
Implement GitHub Actions workflow that:
1. Triggers on push to main branch
2. Runs weekly on schedule for stats refresh
3. Can be manually triggered via workflow_dispatch
4. Commits generated changes back to repository

## Workflow Triggers
- `push` - Data changes trigger regeneration
- `pull_request` - Validate before merge
- `schedule` - Weekly stats refresh
- `workflow_dispatch` - Manual trigger

## Consequences

### Positive
- Always up-to-date profile
- No manual intervention needed
- Weekly stats refresh keeps content fresh
- Validation prevents bad data from merging

### Negative
- Requires write permissions for bot
- Commit history includes bot commits
- Potential for merge conflicts

## Security Considerations
- Bot uses minimal permissions (contents: write)
- No secrets exposed in workflow
- Validation runs before generation

## Related
- ADR 001: Jinja2 Templating
- `.github/workflows/ci-advanced.yml`
