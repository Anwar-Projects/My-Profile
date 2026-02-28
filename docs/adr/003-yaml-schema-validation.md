# ADR 003: YAML Schema Validation

## Status
Accepted

## Context
Profile data consistency is critical for reliable generation. Manual validation is error-prone and doesn't catch all issues early.

## Decision
Implement JSON Schema validation for `data/profile.yaml`:
1. Create `data/schema.json` defining all fields
2. Validate in CI before generation
3. Validate locally via `make validate-data`

## Schema Highlights
- Required sections: personal, summary, skills, certifications
- Enumerated values for status and skill levels
- URI format validation for links
- Date validation for certifications

## Consequences

### Positive
- Catches data errors early
- Self-documenting schema
- IDE support via schema

### Negative
- Added complexity
- Schema must be kept in sync

## Implementation
- Schema file: `data/schema.json`
- Validation command: `make validate-data`
- CI check: Part of `ci-advanced.yml`
