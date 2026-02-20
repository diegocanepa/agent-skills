---
name: swe-workflow
description: 'Master orchestrator for the software development life cycle. Connects issue creation, branching, coding, committing, and change requests.'
---

# Software Engineer Workflow (SDLC)

This skill orchestrates the end-to-end process of a feature or fix by inter-connecting specialized VCS skills.

## 1. Requirement & Analysis
- **Analyze**: Use `vcs-issue-management` to read and clarify the task.
- **Execution Plan**: 
  - If the issue lacks a clear execution plan, update its description to include one.
  - If a plan already exists, leave it as is.
- **New Tasks**: If the task is new, use `vcs-issue-creator` to document it properly.

## 2. Decomposition & Iteration
- **Breakdown**: Analyze if the issue can be split into smaller, independent subtasks.
- **Iterative Plan**: If decomposing, post a single comment in the original issue using `vcs-issue-management` announcing the iterative delivery with the details of it.
- **Task Tracking**: Include a checklist of subtasks in that comment. **Association**: As tasks are completed, update the checklist with links to their corresponding MR/PR.
- **Strategy**: Plan for **incremental Change Requests** (<400 lines) for each subtask.

## 3. Planning & Setup
- **Issue Life Cycle**: Use `vcs-issue-management` to assign the task and post a `Planning` update with the breakdown.
- **Branching**: Create a new branch for the specific subtask following `vcs-branch`.

## 4. Implementation
- **Documentation**: Use `backend-coder` to fetch updated language/framework documentation via context MCP tools.
- **Clean Code**: Follow SOLID principles and patterns defined in `backend-coder`.
- **Atomic Commits**: Save progress using the `vcs-commit` guidelines.
- **Reporting**: Use `vcs-issue-management` to post `Status Updates` or report `Blockers`.

## 5. Verification
- **Testing**: Run local tests and linters as defined in the fetched documentation.
- **Final Polish**: Ensure no secrets or debug logs are left behind.

## 6. Delivery (Iterative Change Request)
- **Submit**: Create a Pull Request (GitHub) or Merge Request (GitLab) using `vcs-change-request` for the completed subtask.
- **Reference**: Link the subtask in the description and **update the checklist** in the iterative plan comment, adding the link to this new MR/PR.
- **Repeat**: Go back to Step 3 for the next subtask until the main issue is resolved.

## General Guidelines
- **Conciseness**: Avoid excessive or redundant comments. 
- **Efficiency**: Do not post duplicate information across multiple comments. Consolidate updates in existing threads or the main issue description.

## 7. Review & Closure
- **Feedback**: Respond to review comments using `vcs-issue-management` patterns.
- **Cleanup**: Once merged, close the issue and the change request.

## Quick Reference to Specialized Skills
- [Issue Creator](../vcs-issue-creator/SKILL.md)
- [Issue Management](../vcs-issue-management/SKILL.md)
- [Branching Strategy](../vcs-branch/SKILL.md)
- [Commit Standards](../vcs-commit/SKILL.md)
- [Change Request (PR/MR)](../vcs-change-request/SKILL.md)
