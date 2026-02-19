---
name: mr-description
description: Merge/Pull Request description templates and best practices for clear, reviewable code changes.
---

# Merge Request / Pull Request Description

## Overview
Comprehensive guidelines for writing clear, informative, and actionable MR/PR descriptions that facilitate effective code reviews and maintain project quality.

## Standard MR/PR Template

```markdown
## Description
[Brief overview of what this MR/PR does and why it's needed]

## Related Issue
Closes #[issue-number]
<!-- Or: Fixes #123, Refs #456, Resolves #789 -->

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Refactoring (no functional changes, code improvement)
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Test addition/update
- [ ] Configuration/infrastructure change

## Technical Details
<!-- Optional: Add technical implementation details if needed -->
- Architecture decisions
- Design patterns used
- Third-party integrations
- Database changes

## API Changes
<!-- If applicable -->
- [ ] Breaking changes documented
- [ ] API documentation updated
- [ ] OpenAPI/Swagger spec updated
- [ ] Backward compatibility maintained
- [ ] Deprecation warnings added (if applicable)

## Deployment Notes
<!-- Special considerations for deployment -->
- [ ] Requires environment variable changes
- [ ] Requires database migration
- [ ] Requires service restart
- [ ] Requires configuration update
- [ ] Can be deployed independently
- [ ] Requires coordinated deployment

### Environment Variables
<!-- List any new or changed environment variables -->
```bash
NEW_ENV_VAR=value  # Description
UPDATED_VAR=new_value  # What changed
```

## Rollback Plan
<!-- How to rollback if issues arise in production -->
1. Step to revert deployment
2. Database rollback procedure (if applicable)
3. Feature flag to disable (if applicable)

## Dependencies
<!-- List any dependencies on other MRs/PRs or external changes -->
- Depends on: #[PR-number]
- Blocked by: #[PR-number]
- Related to: #[PR-number]

## Reviewer Notes
<!-- Optional: Guide reviewers to specific areas -->
- Please pay special attention to: [specific files/logic]
- Open questions: [questions for reviewers]
- Known limitations: [temporary workarounds or TODOs]

## Follow-up Tasks
<!-- Tasks to be done in future MRs -->
- [ ] Task 1: [Description] - Issue #[number]
- [ ] Task 2: [Description] - Issue #[number]

## Additional Notes
<!-- Any other context or information -->
[Additional context, design decisions, alternative approaches considered, etc.]
```

## Title Format

### Structure
```
<type>: <concise description> (#<issue-number>)
```

### Examples
```
Good:
✅ feat: add user authentication system (#123)
✅ fix: resolve login timeout on slow connections (#456)
✅ refactor: extract payment service to separate module (#789)
✅ perf: optimize database queries for user search (#234)
✅ docs: update API documentation for v2 endpoints (#567)

Bad:
❌ Update code
❌ Fix bug
❌ New feature
❌ Changes
❌ PR for review
```

## Type-Specific Templates

### Feature MR Template

```markdown
## Description
This MR introduces [feature name] that allows users to [capability].

## Related Issue
Closes #123

## Type of Change
- [x] New feature (non-breaking change which adds functionality)

## Technical Implementation
- **Pattern**: Service-Repository pattern
- **Database**: Added `features` table with proper indexes
- **Validation**: Using Pydantic/struct tags for input validation
- **Error Handling**: Custom `FeatureError` exceptions

## API Changes
New endpoint added:
- `POST /api/v1/features` - Create feature
- `GET /api/v1/features/{id}` - Get feature
- `PUT /api/v1/features/{id}` - Update feature
- `DELETE /api/v1/features/{id}` - Delete feature

Documentation updated in OpenAPI spec.

## Deployment Notes
- Requires database migration
- No environment variable changes needed
- Can be deployed independently
```

### Bug Fix MR Template

```markdown
## Description
Fixes [specific issue] that was causing [problem description].

## Related Issue
Fixes #456

## Type of Change
- [x] Bug fix (non-breaking change which fixes an issue)

## Root Cause
The bug was caused by [explanation of root cause].

## Solution
[Explanation of how the fix works]

### Reproduction Steps (Before Fix)
1. Step to reproduce issue
2. Expected behavior vs actual behavior

### Verification (After Fix)
1. Same steps now work correctly
2. Edge cases handled properly
```

### Refactoring MR Template

```markdown
## Description
Refactors [component/module] to improve [code quality/performance/maintainability].

## Related Issue
Refs #789
## Motivation
This refactoring is needed to:
- Improve code readability
- Reduce code duplication
- Better separation of concerns
- Prepare for future feature X

## Functional Changes
**Important**: No functional changes. All existing behavior is preserved.
```

## Best Practices

### Description Section

**DO:**
✅ Explain what and why, not just how
✅ Provide context for reviewers
✅ Link to related documentation
✅ Mention design decisions
✅ Keep it concise but complete

**DON'T:**
❌ Leave it empty or write "see title"
❌ Just paste code snippets
❌ Write a novel (be concise)
❌ Use vague terms like "various fixes"

### Changes Made Section

**DO:**
✅ List specific, concrete changes
✅ Group related changes
✅ Use bullet points
✅ Mention both additions and deletions

**Example:**
```markdown
## Changes Made
### Backend
- Added `User` model with email, username, and password fields
- Implemented `UserRepository` for database operations
- Created `AuthService` with login/logout functionality

### API
- Added POST `/api/auth/login` endpoint
- Added POST `/api/auth/logout` endpoint
- Updated OpenAPI specification

### Tests
- Added unit tests for `AuthService`
- Added integration tests for auth endpoints
- Coverage increased from 75% to 89%
```

### Testing Section

**DO:**
✅ Be specific about what was tested
✅ Mention test coverage changes
✅ Describe edge cases tested
✅ Include manual testing scenarios

**Example:**
```markdown
## Testing
- [x] Unit tests added (92% coverage)
- [x] Integration tests added
- [x] Manual testing completed

### Test Scenarios
1. **Happy path**: User logs in with valid credentials → Success
2. **Invalid password**: User logs in with wrong password → 401 error
3. **Non-existent user**: Login with unknown email → 404 error
4. **SQL injection**: Attempted SQL injection in email field → Safely handled
5. **Rate limiting**: Multiple failed attempts → Account locked after 5 tries
```

### Screenshots/Videos

**When to Include:**
- UI changes
- User-facing features
- Visual bug fixes
- New screens or components

**How to Include:**
```markdown
## Screenshots

### Before
![Before](url-to-image)
*Description: Login page had misaligned button*

### After
![After](url-to-image)
*Description: Login button now properly aligned*

### Demo Video
[Watch demo](url-to-video)
```

## Size Guidelines

### Ideal MR Size
- **Small**: < 200 lines changed
  - Quick to review
  - Easy to understand
  - Low risk

- **Medium**: 200-400 lines changed
  - Reasonable review time
  - May need multiple reviewers

- **Large**: 400-800 lines changed
  - Should be split if possible
  - Requires detailed description
  - Longer review time

- **Too Large**: > 800 lines changed
  - **Should be split into multiple MRs**
  - Very difficult to review properly
  - High risk of bugs slipping through

### When Large MRs are Acceptable
- Generated code (migrations, auto-generated API clients)
- Large refactoring with clear scope
- Moving files/renaming
- Dependency updates with lock file changes

## Labels and Metadata

### Recommended Labels
```
Priority:
- priority: critical
- priority: high
- priority: medium
- priority: low

Type:
- type: feature
- type: bugfix
- type: refactor
- type: docs

Status:
- status: draft
- status: ready-for-review
- status: changes-requested
- status: approved

Size:
- size: XS (< 50 lines)
- size: S (50-200 lines)
- size: M (200-400 lines)
- size: L (400-800 lines)
- size: XL (> 800 lines)
```

### Assignees and Reviewers
```markdown
Assignee: @author
Reviewers: @tech-lead @domain-expert
Approvals required: 2
```

## Draft vs Ready for Review

### When to Use Draft
- Work in progress
- Seeking early feedback
- Not ready for full review
- CI/CD not yet passing

### When to Mark Ready for Review
- All development complete
- All tests passing
- Self-review done
- CI/CD passing
- Description complete

## Review Request Guidelines

### Before Requesting Review
- [ ] Self-review completed
- [ ] All tests passing locally
- [ ] CI/CD pipeline passing
- [ ] No merge conflicts
- [ ] Description is complete
- [ ] Screenshots added (if UI changes)
- [ ] Code is formatted
- [ ] No debug code or comments

### Requesting Changes
When reviewer requests changes:
1. Address all comments
2. Make changes in new commits (easier to review)
3. Respond to each comment
4. Re-request review when done

## Common Mistakes

### 1. Empty or Vague Description
```markdown
❌ Description: Updates

✅ Description:
This MR adds user authentication using JWT tokens.
Includes login endpoint, token validation middleware,
and password hashing service.
```

### 2. No Testing Information
```markdown
❌ Testing: Tested locally

✅ Testing:
- [x] Unit tests added (15 new tests, 92% coverage)
- [x] Integration tests for login flow
- [x] Manual testing: tested login with valid/invalid credentials
- [x] All 156 tests passing
```

### 3. Missing Context
```markdown
❌ Changes Made: Updated code

✅ Changes Made:
- Replaced bcrypt with argon2 for password hashing (more secure)
- Added password strength validation (min 8 chars, 1 uppercase, 1 number)
- Implemented rate limiting on login endpoint (5 attempts per 15 min)
```

## Quick Reference

### MR Description Checklist
- [ ] Clear, descriptive title
- [ ] Issue reference (Closes/Fixes/Refs #number)
- [ ] Type of change selected
- [ ] Changes listed specifically
- [ ] Testing details provided
- [ ] Screenshots added (if applicable)
- [ ] Deployment notes included (if needed)
- [ ] All checklist items addressed
- [ ] Self-review completed

### Minimal Acceptable Template
```markdown
## Description
[What this MR does]

## Related Issue
Closes #[number]

## Changes Made
- [Change 1]
- [Change 2]

## Testing
- [x] Tests added/updated
- [x] All tests passing
```

## References

- GitHub Pull Request Best Practices
- GitLab Merge Request Guidelines
- Code Review Best Practices
- Conventional Commits
- Semantic Versioning