# SWE Workflow Templates

Professional templates for the standardized Software Engineering workflow. Use these templates when updating issues during the SWE lifecycle.

---

## 🏗️ Architectural Analysis (Phase 1)

**Posted by:** `swe-architect`  
**Purpose:** Document technical approach and architectural decisions

```markdown
## 🏗️ Architectural Analysis

**Objective:** [Brief description of what needs to be accomplished]

### Technical Approach
[Detailed explanation of the technical strategy, including:]
- Components affected
- Architectural patterns to follow
- Key technical decisions and rationale
- Dependencies and integrations
- Potential risks and mitigations

### System Design

[Mermaid diagram - flowchart, sequence, or component diagram showing the solution]

### Technical Considerations
- **Performance:** [Expected impact on performance]
- **Security:** [Security implications and measures]
- **Scalability:** [How this scales]
- **Maintainability:** [Impact on code maintainability]

### References
- [Link to relevant documentation]
- [Link to similar implementations]
- [Link to design patterns used]

---

> 📝 **Next Step:** Implementation plan will be defined in Phase 2

> ⏳ Awaiting USER approval before proceeding to planning phase
```

---

## 📋 Implementation Plan (Phase 2)

**Posted by:** `swe-planner`  
**Purpose:** Break down implementation into actionable subtasks

```markdown
## 📋 Implementation Plan

**Based on:** [Link to architectural analysis comment]

### Execution Strategy
[1-2 paragraphs explaining the implementation approach, including order of execution and dependencies between subtasks]

### Subtasks

- [ ] **Subtask 1:** [Clear, actionable description]
  - **Files:** `path/to/file1.ts`, `path/to/file2.ts`
  - **Scope:** [What will be implemented]
  - **Tests:** [What tests need to be created/updated]
  
- [ ] **Subtask 2:** [Clear, actionable description]
  - **Files:** `path/to/file3.ts`
  - **Scope:** [What will be implemented]
  - **Tests:** [What tests need to be created/updated]

- [ ] **Subtask N:** [Clear, actionable description]
  - **Files:** `path/to/fileN.ts`
  - **Scope:** [What will be implemented]
  - **Tests:** [What tests need to be created/updated]

### Quality Gates
- [ ] All unit tests pass
- [ ] Integration tests pass
- [ ] Linting passes (0 errors)
- [ ] Code coverage maintained/improved
- [ ] Documentation updated

### Tracking
Implementation progress is tracked in: `.plan/[issue-number]-[feature-name].md`

---

> 🚀 Ready to begin implementation

> ⏳ Awaiting USER approval to start Phase 3
```

---

## ⚙️ Subtask Progress Update

**Posted by:** `swe-implementer` via `swe-orchestrator`  
**Purpose:** Update progress after completing a subtask

```markdown
### ⚙️ Subtask Completed: [Subtask Name]

**Branch:** `[branch-name]`  
**Commit:** [commit-hash]

#### Changes Made
- [List of key changes]
- [Modified files]
- [New functionality added]

#### Validation
- ✅ Unit tests: [X passed / Y total]
- ✅ Integration tests: [X passed / Y total]
- ✅ Linting: 0 errors
- ✅ Code coverage: [XX]%

#### Next Steps
- [ ] Continue with Subtask N
- [ ] Ready for review

---

**Progress:** [X/Y] subtasks completed ([XX]%)
```

---

## 🔍 Review & MR Creation (Phase 4)

**Posted by:** `swe-reviewer`  
**Purpose:** Announce MR creation and final review

```markdown
## 🔍 Code Review Complete

### Quality Verification
- ✅ Architectural consistency verified
- ✅ All subtasks implemented
- ✅ All tests passing
- ✅ Code follows [backend-coder](../backend-coder/SKILL.md) standards
- ✅ No linting errors
- ✅ Branch synced with main

### Merge Request
**MR:** [Link to MR/PR]  
**Branch:** `[branch-name]` → `main`

#### Summary of Changes
[Brief description of what was implemented]

#### Files Changed
- `path/to/file1.ts` - [Description]
- `path/to/file2.ts` - [Description]

#### Review Points
[Key areas reviewers should focus on]

---

> ✅ Ready for merge pending final approval
```

---

## 🎯 Feature Completion

**Posted by:** `swe-orchestrator`  
**Purpose:** Close the loop when everything is merged

```markdown
## 🎉 Feature Completed

All subtasks have been implemented, reviewed, and merged.

### Implementation Summary
- **Total subtasks:** [N]
- **MRs created:** [M]
- **Files modified:** [X]
- **Tests added:** [Y]

### Deliverables
- [✅] Subtask 1: [Link to MR]
- [✅] Subtask 2: [Link to MR]
- [✅] Subtask N: [Link to MR]

### Verification
- ✅ All tests passing in main
- ✅ Feature verified in [environment]
- ✅ Documentation updated

---

**Closing this issue as completed.**
```

---

## 📊 Status Update (During Implementation)

**Posted by:** `swe-orchestrator` or `swe-implementer`  
**Purpose:** Periodic progress updates

```markdown
### 📊 Progress Update - [Date]

**Current Phase:** [Phase name]  
**Progress:** [X/Y] subtasks completed ([XX]%)

#### Completed This Week
- ✅ [Subtask name] - [Link to commit/MR]
- ✅ [Subtask name] - [Link to commit/MR]

#### In Progress
- ⚙️ [Subtask name] - [Brief status]

#### Next Up
- ⏭️ [Subtask name]

#### Blockers
- [None / List blockers if any]

**Status:** On track / Delayed / Blocked
```

---

## 🛑 Blocker Report (If Issues Arise)

**Posted by:** Any SWE skill when blocked  
**Purpose:** Escalate blockers immediately

```markdown
### 🛑 BLOCKER - [Brief Description]

**Blocked Task:** [Subtask name or phase]  
**Impact:** [High/Medium/Low]

#### Details
[Detailed explanation of what is blocking progress]

#### Impact Assessment
- **Timeline:** [How this affects the schedule]
- **Dependencies:** [What else is affected]
- **Severity:** [Why this is critical]

#### Required Action
[Specific action needed to unblock]

#### Temporary Mitigation
[If applicable, what is being done in the meantime]

---

> ⏳ Awaiting resolution before proceeding
```

---

## Usage Guidelines

1. **Always use Markdown formatting** - Titles, lists, code blocks
2. **Always include emojis** - For visual clarity and quick scanning
3. **Always link to related items** - MRs, commits, other comments
4. **Always wait for USER approval** - Before posting to the issue
5. **Keep updates concise** - Focus on relevant information
6. **Maintain professional tone** - Solution-oriented, clear, collaborative

## Template Selection Guide

| Situation | Template to Use |
|-----------|-----------------|
| Starting a new feature | Architectural Analysis |
| After architecture approval | Implementation Plan |
| Completed a subtask | Subtask Progress Update |
| Created MR | Review & MR Creation |
| Everything merged | Feature Completion |
| Regular update needed | Status Update |
| Something is blocking | Blocker Report |
