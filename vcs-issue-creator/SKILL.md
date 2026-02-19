---
name: issue-creation
description: 'Expert issue creation for GitHub and GitLab. Uses standardized templates and labels to file clear, actionable bugs, features, and tasks.'
---

# Issue Creation Manager (VCS Agnostic)

## Workflow

1. **Platform Detection**: Detect if repository is GitHub or GitLab.
2. **Duplicity Check**: Use `search_issues` (GitHub) or `list_project_issues` (GitLab) to ensure the issue doesn't already exist.
3. **Template Selection**: Choose the best fit from [references/templates.md](references/templates.md).
4. **Tool Execution**: Use the platform-specific tool for creation.
5. **Confirmation**: Report the new issue URL/number.

## Creation Mapping

| Platform | Tool | Title Prefix | Body Field |
|----------|------|--------------|------------|
| **GitHub** | `mcp__github__create_issue` | `[Bug]`, `[Feature]`, etc. | `body` |
| **GitLab** | `mcp__gitlab__create_issue` | `[Bug]`, `[Feature]`, etc. | `description` |

## Parameters Reference

- **GitHub**: `owner`, `repo`, `title`, `body`, `labels`, `assignees`.
- **GitLab**: `project_id`, `title`, `description`, `labels`, `assignee_ids`.

## Guidelines

- **Search First**: Avoid creating duplicate issues.
- **Atomic Issues**: One problem or feature per issue.
- **Labels**: Apply relevant labels from [references/labels.md](references/labels.md).
- **Efficiency**: Skip optional template sections if they provide no value.
- **Clear Context**: Reference other issues or commits if relevant (e.g., `Part of #123`).