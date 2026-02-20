---
name: software-engineer-workflow
description: 'Autonomous orchestrator for the SDLC using specialized agent personas (Architect, Implementer, Reviewer).'
---

# Software Engineer Workflow (Multi-Agent SDLC)

This skill orchestrates the end-to-end development cycle by rotating between specialized **Agent Personas**.

## 🔄 The Multi-Agent Cycle

### 1. Analysis & Planning
- **Agent**: [The Architect](../../agents/architect/ROLE.md)
- **Goal**: Analyze the issue, define the execution plan, and post an iterative checklist.
- **MITM**: Wait for USER approval of the plan.

### 2. Implementation Loop
- **Agent**: [The Implementer](../../agents/implementer/ROLE.md)
- **Goal**: For each subtask, create a branch, implementation code, and verify with tests.
- **Loop**: ` रिसर्च (Research) -> Implementation -> Verification -> Commit `.

### 3. Quality & Delivery
- **Agent**: [The Reviewer](../../agents/reviewer/ROLE.md)
- **Goal**: Create the PR/MR, update the progress checklist, and ensure sync.
- **MITM**: Wait for USER approval of the PR and progress update.

## ➕ Role Transitions
The agent must proactively switch its mindset (persona) according to the phase:
1. **Architect** creates the map.
2. **Implementer** walks the path (one subtask at a time).
3. **Reviewer** sends the report.
4. **Repeat** until all subtasks in the checklist are finished.

## Specialized Skills Used
- [Issue Creator](../vcs-issue-creator/SKILL.md)
- [Issue Management](../vcs-issue-management/SKILL.md)
- [Branching](../vcs-branch/SKILL.md)
- [Commit Standards](../vcs-commit/SKILL.md)
- [Change Request](../vcs-change-request/SKILL.md)
- [Backend Coder](../backend-coder/SKILL.md)
