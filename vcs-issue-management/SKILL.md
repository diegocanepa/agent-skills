---
name: issue-management
description: 'Manage issue lifecycle: comments, state changes, assignments, and professional status updates for GitHub and GitLab.'
---

# VCS Issue Management (Agnostic)

## Workflow

1. **Information Gathering**: Read the latest comments and current state of the issue.
2. **Action Definition**: Determine if you need to comment, assign, change state, or update the description.
3. **Drafting**:
   - Use professional patterns from [references/communication.md](references/communication.md).
   - Use structured templates for status/blockers from [references/updates.md](references/updates.md).
4. **Execution**: Map to the correct platform tool (GitHub/GitLab).

## Tool Mapping

| Action | GitHub Tool (`mcp__github__`) | GitLab Tool (`mcp__gitlab__`) |
|--------|------------------------------|------------------------------|
| Comment | `add_issue_comment(owner, repo, issue_number, body)` | `create_issue_note(project_id, issue_iid, body)` |
| Change State | `update_issue(..., state: 'open'\|'closed')` | `edit_issue(..., state_event: 'reopen'\|'close')` |
| Assign | `update_issue(..., assignees: [u1])` | `edit_issue(..., assignee_ids: [id])` |
| Edit Body | `update_issue(..., body: '...')` | `edit_issue(..., description: '...')` |

## Strategic Updates

- **Blockers**: Post an immediate update using the Blocker template if progress stops.
- **Delays**: Notify stakeholders as soon as a delay is detected with a revised ETA.
- **Planning**: Propose an approach before starting complex work to get early feedback.
- **Professionalism**: Always maintain a solution-oriented tone.

## Guidelines
- **Be Concise**: Avoid repetitive or redundant comments.
- **Context Awareness**: Link relevant commits, PRs, or other issues.
- **State Hygiene**: Close issues promptly when work is completed and verified.
