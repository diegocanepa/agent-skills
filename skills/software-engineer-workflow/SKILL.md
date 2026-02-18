---
name: software-engineer-workflow
description: Complete workflow for a software engineer from issue analysis to merge request creation, including branch naming, commits, and MR descriptions.
---

# Software Engineer Workflow

## Overview
End-to-end workflow for processing issues and delivering code changes through merge/pull requests. This skill integrates with version control systems (GitLab/GitHub) and follows industry best practices.

## Workflow Steps

### 1. Read and Analyze Issue

**Objective**: Understand the problem, requirements, and acceptance criteria.

**Actions**:
- Use MCP (Model Context Protocol) to fetch issue details from GitLab or GitHub
- Read issue title, description, and all comments
- Identify the issue type: bug fix, feature, refactor, documentation
- Extract acceptance criteria and requirements
- Check for linked issues or dependencies

**Questions to Answer**:
- [ ] What is the problem or feature request?
- [ ] Who is the stakeholder/requester?
- [ ] What are the acceptance criteria?
- [ ] Are there any constraints or dependencies?
- [ ] What is the priority/urgency?
- [ ] Are there design documents or RFCs linked?

**Example MCP Usage**:
```bash
# GitHub
mcp_github_get_issue --owner=<org> --repo=<repo> --issue_number=<number>

# GitLab
mcp_gitlab_get_issue --project_id=<id> --issue_iid=<iid>
```

### 2. Impact Analysis

**Objective**: Determine which files, modules, and systems will be affected.

**Actions**:
- Use `list_dir` and `file_search` to explore the codebase
- Use `read_file` to understand current implementation
- Use `grep_search` or `semantic_search` to find related code
- Identify all files that need changes
- Check for tests that need updates
- Review dependencies and side effects

**Analysis Checklist**:
- [ ] Which modules/files need to be modified?
- [ ] Are there existing tests that cover this area?
- [ ] Will this change break existing functionality?
- [ ] Are there database migrations needed?
- [ ] Are there API contract changes?
- [ ] Do we need to update documentation?

### 3. Break Down into Iterations

**Objective**: Determine if the issue can be split into smaller, manageable MRs.

**Criteria for Splitting**:
- Each MR should be **independently reviewable**
- Each MR should **pass all tests**
- Each MR should **not break existing functionality**
- Ideal MR size: **< 400 lines changed**

**Common Split Patterns**:
1. **Refactoring First**: Prepare the codebase (extract functions, clean up)
2. **Foundation Then Feature**: Build infrastructure, then add feature
3. **Backend Then Frontend**: API changes first, UI changes second
4. **By Component**: Split by logical components or modules

**Example Split**:
```
Issue: Add user authentication system

MR 1: Add User model and database migration
MR 2: Implement authentication repository layer
MR 3: Add authentication service with business logic
MR 4: Add authentication API endpoints
MR 5: Add tests for authentication flow
```

**Decision Tree**:
- **Small change (<200 lines)**: Single MR
- **Medium change (200-800 lines)**: Consider 2-3 MRs
- **Large change (>800 lines)**: Must split into multiple MRs

### 4. Create Branch

**Objective**: Create a properly named branch from the latest master/main.

**Actions**:
```bash
# Pull latest changes from main branch
git checkout main
git pull origin main

# Create new branch
git checkout -b <branch-name>
```

**Branch Naming Convention** (See `skills/branch-naming/branch-naming.md`):

**Format**: `<type>/<issue-number>-<short-description>`

**Types**:
- `feature/` - New feature
- `bugfix/` - Bug fix
- `hotfix/` - Urgent production fix
- `refactor/` - Code refactoring
- `docs/` - Documentation changes
- `test/` - Test additions or fixes
- `chore/` - Maintenance tasks

**Examples**:
```bash
feature/123-add-user-authentication
bugfix/456-fix-login-timeout
refactor/789-extract-payment-service
docs/101-update-api-documentation
test/202-add-integration-tests
```

**Rules**:
- Use lowercase
- Separate words with hyphens (kebab-case)
- Keep it concise but descriptive
- Always include issue number
- Max length: 50 characters

### 5. Implement Changes with Incremental Commits

**Objective**: Make small, focused commits that tell a story.

**Best Practices**:
- Commit early and often
- Each commit should be atomic (one logical change)
- Each commit should pass tests (if possible)
- Write meaningful commit messages

**Commit Message Format** (See `skills/commit-guidance/commit-guidance.md`):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `test`: Adding or updating tests
- `docs`: Documentation changes
- `style`: Code style changes (formatting, missing semicolons, etc.)
- `perf`: Performance improvements
- `chore`: Maintenance tasks

**Examples**:
```bash
# Good commits
git commit -m "feat(auth): add User model with email and password fields"
git commit -m "test(auth): add unit tests for User model validation"
git commit -m "refactor(auth): extract password hashing to separate service"
git commit -m "fix(auth): handle null email in user validation"

# Bad commits
git commit -m "changes"
git commit -m "wip"
git commit -m "fixed stuff"
```

**Commit Workflow**:
```bash
# 1. Make changes
# 2. Review changes
git diff

# 3. Stage specific files
git add <file1> <file2>

# 4. Commit with message
git commit -m "feat(auth): add User model"

# 5. Continue with next change
# Repeat until feature is complete
```

**Commit Size Guidelines**:
- **Ideal**: 1-5 files, < 100 lines changed
- **Acceptable**: 5-10 files, < 300 lines changed
- **Too Large**: > 10 files or > 500 lines (should be split)

### 6. Run Tests

**Objective**: Ensure all changes work correctly and don't break existing functionality.

**Test Checklist**:
- [ ] Run unit tests for modified code
- [ ] Run integration tests
- [ ] Run end-to-end tests (if applicable)
- [ ] Verify test coverage for new code
- [ ] Check for linting errors
- [ ] Verify type checking passes

**Commands** (adapt to your project):
```bash
# Python
pytest tests/
pytest --cov=src tests/
ruff check .
mypy src/

# Go
go test ./...
go test -race ./...
golangci-lint run

# JavaScript/TypeScript
npm test
npm run lint
npm run type-check
```

**Fix Failures**:
- If tests fail, analyze the output
- Fix issues in your code
- Make additional commits with fixes
- Re-run tests until all pass

### 7. Push Branch

**Objective**: Push your local branch to remote repository.

**Actions**:
```bash
# First push (set upstream)
git push -u origin <branch-name>

# Subsequent pushes
git push
```

**Before Pushing**:
- [ ] All tests pass locally
- [ ] Code is properly formatted
- [ ] No debug code or commented-out code
- [ ] No sensitive information (API keys, passwords)
- [ ] Commits are clean and well-organized

**Force Push (Use with Caution)**:
```bash
# Only if you need to rewrite history (after rebase, amend, etc.)
git push --force-with-lease
```

### 8. Create Merge/Pull Request

**Objective**: Create a clear, informative MR/PR for code review.

**Use MCP to Create MR/PR**:
```bash
# GitHub
mcp_github_create_pull_request \
  --owner=<org> \
  --repo=<repo> \
  --title="<title>" \
  --head=<branch> \
  --base=main \
  --body="<description>"

# GitLab
mcp_gitlab_create_merge_request \
  --project_id=<id> \
  --source_branch=<branch> \
  --target_branch=main \
  --title="<title>" \
  --description="<description>"
```

**MR/PR Title Format**:
```
<type>: <concise description> (#<issue-number>)
```

**Examples**:
```
feat: Add user authentication system (#123)
fix: Resolve login timeout issue (#456)
refactor: Extract payment service to separate module (#789)
```

**MR/PR Description Template** (See `skills/merge-request-description/merge-request-description.md`):

```markdown
## Description
Brief overview of what this MR does and why.

## Related Issue
Closes #<issue-number>

## Type of Change
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Refactoring (no functional changes)
- [ ] Documentation update

## Changes Made
- Change 1: Description
- Change 2: Description
- Change 3: Description

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed
- [ ] All tests pass locally

## Screenshots (if applicable)
[Add screenshots for UI changes]

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Tests added for new functionality
- [ ] All tests pass

## Deployment Notes
[Any special deployment considerations]

## Rollback Plan
[How to rollback if issues arise]
```

**MR Best Practices**:
- Keep MRs focused and small
- Link to related issues
- Provide context in description
- Add screenshots for UI changes
- Respond to review comments promptly
- Keep the MR updated with main branch

### 9. Code Review Process

**As MR Author**:
- [ ] Address all review comments
- [ ] Make requested changes in new commits
- [ ] Re-request review after changes
- [ ] Keep discussions professional and constructive

**Handling Review Comments**:
```bash
# Make changes based on feedback
git add <files>
git commit -m "refactor: address review comments - extract validation logic"
git push
```

**After Approval**:
- [ ] Ensure all CI/CD checks pass
- [ ] Rebase if needed to resolve conflicts
- [ ] Squash commits if required by team policy
- [ ] Merge the MR

## Quick Reference

### Complete Workflow Commands

```bash
# 1. Fetch issue (use MCP tool)

# 2. Pull latest and create branch
git checkout main
git pull origin main
git checkout -b feature/123-add-auth

# 3. Make changes and commit
git add src/auth/user.py
git commit -m "feat(auth): add User model"

# 4. Run tests
pytest tests/

# 5. Push branch
git push -u origin feature/123-add-auth

# 6. Create MR/PR (use MCP tool)

# 7. Address review comments and push
git add .
git commit -m "refactor: address review feedback"
git push
```

## Integration with Other Skills

This workflow references and depends on:
- **backend-coder.md**: Core development principles
- **branch-naming.md**: Branch naming conventions
- **commit-guidance.md**: Commit message standards
- **merge-request-description.md**: MR/PR template and best practices
- **python.md** or **golang.md**: Language-specific implementation

## Anti-Patterns to Avoid

1. **No Issue Analysis**: Starting to code without understanding the problem
2. **Massive MRs**: Creating MRs with >800 lines of changes
3. **Poor Commit Messages**: Using "wip", "changes", "fix"
4. **No Testing**: Pushing code without running tests
5. **Force Push on Shared Branches**: Rewriting history on collaborative branches
6. **Ignoring Review Comments**: Not addressing feedback
7. **No Description**: Creating MRs without context
8. **Working Directly on Main**: Never commit directly to main/master

## References

- GitHub Flow
- GitLab Flow
- Conventional Commits
- Code Review Best Practices
- Continuous Integration/Continuous Deployment (CI/CD)
