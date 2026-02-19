---
name: branch-naming
description: Git branch naming convention format for consistent version control workflow.
---

# Branch Naming Convention

## Format

```
<type>/<issue-number>-<short-description>
```

## Components

### Type (Required)
- `feature/` - New feature
- `bugfix/` or `fix/` - Bug fix  
- `hotfix/` - Urgent production fix
- `refactor/` - Code refactoring
- `docs/` - Documentation
- `test/` - Tests
- `chore/` - Maintenance
- `perf/` - Performance
- `ci/` - CI/CD changes

### Issue Number (Required when applicable)
- GitHub/GitLab: `123`
- Jira: `PROJ-123`

### Description (Required)
- Lowercase only
- Kebab-case (hyphens)
- 3-6 words max
- Max 50 chars total

## Examples

```bash
✅ feature/123-add-user-authentication
✅ bugfix/456-fix-login-timeout
✅ hotfix/789-critical-security-patch
✅ refactor/234-extract-payment-service
✅ docs/567-update-api-documentation
✅ test/890-add-integration-tests
✅ chore/update-dependencies

❌ fix-bug                    # No issue, too vague
❌ FEATURE-123                # Uppercase
❌ feature_123_add_auth       # Underscores
❌ my-feature                 # No issue, not descriptive
```

## Creating a Branch

```bash
git checkout main
git pull origin main
git checkout -b feature/123-add-user-auth
```

## References

- Git Flow
- GitHub Flow
