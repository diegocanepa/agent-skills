# Feature Plan Tracking (`.plan/` directory)

## Purpose
The `.plan/` directory contains living documents that track the implementation progress of features. These files are **created in the target repository** (not in the skills repository) and serve as a persistent state for the SWE workflow.

---

## File Naming Convention

```
.plan/[issue-number]-[feature-name].md
```

**Examples:**
- `.plan/123-user-authentication.md`
- `.plan/456-payment-gateway-integration.md`
- `.plan/789-refactor-database-layer.md`

---

## Template

```markdown
# Feature: [Feature Name]

**Issue:** #[issue-number]  
**Status:** [Planning / In Progress / Review / Completed / Blocked]  
**Created:** [YYYY-MM-DD]  
**Last Updated:** [YYYY-MM-DD]

---

## 🏗️ Architecture Summary

**Approach:** [Brief summary of the technical approach from swe-architect]

**Key Components:**
- [Component 1]
- [Component 2]
- [Component N]

**References:**
- [Link to architectural analysis comment in issue]
- [Link to technical documentation]

---

## 📋 Implementation Plan

[Brief summary of the implementation strategy from swe-planner]

**References:**
- [Link to implementation plan comment in issue]

---

## ✅ Subtasks Progress

### Subtask 1: [Name]
- **Status:** [Not Started / In Progress / Completed / Blocked]
- **Branch:** `[branch-name]`
- **Files:** `path/to/file1.ts`, `path/to/file2.ts`
- **Assignee:** [If applicable]
- **Started:** [YYYY-MM-DD]
- **Completed:** [YYYY-MM-DD]
- **Commit:** [commit-hash]
- **MR/PR:** [Link if created]
- **Notes:** [Any relevant notes or decisions made during implementation]

### Subtask 2: [Name]
- **Status:** [Not Started / In Progress / Completed / Blocked]
- **Branch:** `[branch-name]`
- **Files:** `path/to/file3.ts`
- **Assignee:** [If applicable]
- **Started:** [YYYY-MM-DD]
- **Completed:** [YYYY-MM-DD]
- **Commit:** [commit-hash]
- **MR/PR:** [Link if created]
- **Notes:** [Any relevant notes or decisions made during implementation]

### Subtask N: [Name]
- **Status:** [Not Started / In Progress / Completed / Blocked]
- **Branch:** `[branch-name]`
- **Files:** `path/to/fileN.ts`
- **Assignee:** [If applicable]
- **Started:** [YYYY-MM-DD]
- **Completed:** [YYYY-MM-DD]
- **Commit:** [commit-hash]
- **MR/PR:** [Link if created]
- **Notes:** [Any relevant notes or decisions made during implementation]

---

## 📊 Progress Overview

**Overall Progress:** [X/Y] subtasks completed ([XX]%)

| Subtask | Status | MR/PR | Merged |
|---------|--------|-------|--------|
| Subtask 1 | ✅ Completed | [#123](link) | ✅ |
| Subtask 2 | ⚙️ In Progress | - | - |
| Subtask 3 | 📝 Not Started | - | - |

---

## 🔍 Quality Gates

- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Linting passes (0 errors)
- [ ] Code coverage maintained/improved
- [ ] Documentation updated
- [ ] All MRs reviewed and approved
- [ ] All MRs merged to main

---

## 🚧 Blockers & Issues

### Active Blockers
[List any current blockers]

### Resolved Issues
- **[YYYY-MM-DD]:** [Description of issue] - [How it was resolved]

---

## 📝 Implementation Notes

### Key Decisions
- **[YYYY-MM-DD]:** [Decision made and rationale]
- **[YYYY-MM-DD]:** [Decision made and rationale]

### Technical Learnings
- [Any important learnings or gotchas discovered during implementation]

### Deviations from Plan
- **[YYYY-MM-DD]:** [What changed from original plan and why]

---

## 🔗 Related Links

- **Issue:** [Link to GitHub/GitLab issue]
- **Architectural Analysis:** [Link to comment]
- **Implementation Plan:** [Link to comment]
- **MRs/PRs:**
  - [Link to MR 1]
  - [Link to MR 2]
- **Documentation:** [Links to relevant docs]

---

## 📅 Timeline

| Date | Event |
|------|-------|
| [YYYY-MM-DD] | Feature planning started |
| [YYYY-MM-DD] | Architecture approved |
| [YYYY-MM-DD] | Implementation plan approved |
| [YYYY-MM-DD] | Subtask 1 completed |
| [YYYY-MM-DD] | Subtask 2 completed |
| [YYYY-MM-DD] | All MRs merged |
| [YYYY-MM-DD] | Feature completed |

---

**Last Updated by:** [swe-skill-name]  
**Next Update:** [Expected date of next update]
```

---

## Workflow Integration

### When to Create
- **Trigger:** After `swe-planner` creates the implementation plan
- **Created by:** `swe-planner` skill
- **Location:** `.plan/[issue-number]-[feature-name].md` in the target repository

### When to Update
- **After each subtask completion** - `swe-implementer` updates status, commit, dates
- **After MR creation** - `swe-reviewer` adds MR links and status
- **After MR merge** - `swe-orchestrator` marks as merged
- **When blockers occur** - Any skill adds to blockers section
- **On status changes** - Update the status field at the top

### Update Responsibility

| Phase | Skill | Updates |
|-------|-------|---------|
| Planning | `swe-planner` | Creates file, fills architecture & plan sections |
| Implementation | `swe-implementer` | Updates subtask status, commits, notes |
| Review | `swe-reviewer` | Adds MR links, quality gate checks |
| Merge | `swe-orchestrator` | Marks merged, updates progress |
| Completion | `swe-orchestrator` | Final status update |

---

## Example Usage

A feature tracked in issue #456 for payment gateway integration would:

1. **swe-architect** analyzes → Comments in issue
2. **swe-planner** creates plan → Comments in issue + Creates `.plan/456-payment-gateway-integration.md`
3. **swe-implementer** works on Subtask 1 → Updates `.plan/456-payment-gateway-integration.md` with status, commit
4. **swe-reviewer** creates MR → Updates `.plan/456-payment-gateway-integration.md` with MR link
5. **swe-orchestrator** after merge → Updates `.plan/456-payment-gateway-integration.md` marking subtask complete
6. Repeat 3-5 for each subtask
7. **swe-orchestrator** final completion → Updates `.plan/456-payment-gateway-integration.md` with completed status

---

## Benefits

✅ **Persistence** - State survives across sessions  
✅ **Visibility** - Clear progress tracking in the repo  
✅ **History** - Timeline of decisions and changes  
✅ **Context** - Quick reference for anyone picking up the work  
✅ **Automation-friendly** - Structured format for programmatic updates
