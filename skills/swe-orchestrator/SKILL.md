---
name: swe-workflow-orchestrator
description: "Autonomous SDLC orchestrator. Coordinates the Architect, Implementer, and Reviewer personas using structured workflows, feedback loops, and issue-as-ledger tracking. Use when starting any development task from an issue."
---

# 🎼 SWE Workflow Orchestrator

Orchestrate the full development lifecycle using specialized personas. The **issue is the Single Source of Truth** — every phase transition MUST leave a comment on it.

Copy the progress checklist into your response and update it as you work through each phase.

---

## Master Progress Checklist

Copy this and track progress at the start of every task:

```
SWE Workflow Progress:
- [ ] Phase 1 — ARCHITECT: Plan reviewed and approved by USER
- [ ] Phase 2 — IMPLEMENTER: Subtask implemented, tested, and committed
- [ ] Phase 3 — REVIEWER: PR created and checklist updated
- [ ] (Repeat Phase 2–3 for each remaining subtask)
- [ ] DONE: All subtasks merged and issue closed
```

---

## Phase 1: Planning (Persona → [SWE Architect](../swe-architect/SKILL.md))

Adopt the **Architect** persona. Your goal is a USER-approved execution plan.

**Step 1: Gather context**

Read the issue using `vcs-issue-management`. Identify:
- The goal and acceptance criteria.
- Affected components and dependencies.

**Step 2: Visualize the solution**

Create a Mermaid diagram (flowchart or sequence) using `mermaid-diagrams`. Prefer a `flowchart` for feature work and a `sequenceDiagram` for API interactions.

**Step 3: Post the Architectural Plan comment**

Post a comment on the issue with the following format:

```markdown
## 🏗️ Architectural Plan

**Approach**: [One paragraph summary of the strategy — components, not code.]

[Mermaid diagram here]

## 📋 Iterative Delivery Plan

- [ ] Subtask 1: [Description]
- [ ] Subtask 2: [Description]
- [ ] Subtask N: [Description]

> ⏳ Awaiting USER approval to begin implementation.
```

**Step 4: MITM — Request USER approval**

Present the comment and ask:
> "Here is the proposed plan. Does this look correct? Should I adjust the scope or the subtask breakdown before I begin?"

**Feedback loop:** USER requests changes → revise comment → react again. Do NOT proceed to Phase 2 without explicit approval.

---

## Phase 2: Implementation (Persona → [SWE Implementer](../swe-implementer/SKILL.md))

Adopt the **Implementer** persona. Process **one subtask at a time**.

**Step 1: Announce the subtask**

Update the Architectural Plan comment: mark the current subtask as `⚙️ In progress...`.

**Step 2: Branch setup**

Create or switch to the subtask branch using `vcs-branch`.

**Step 3: Research**

Use [backend-coder](../backend-coder/SKILL.md) skill + `context7` mcp to fetch relevant documentation for libraries or frameworks involved.

**Step 4: Implement**

Write the code following the standards in [backend-coder](../backend-coder/SKILL.md) (SOLID, type safety, error handling).

**Step 5: Validate — Feedback Loop**

Run tests and linters:

```
Validation Loop:
- [ ] Run lint → 0 errors?
- [ ] Run unit tests → all pass?
- [ ] Run integration tests (if applicable) → all pass?
```

If any check fails:
- Identify the root cause.
- Fix the code.
- Run validation again from the top.
- Only proceed when **all checks pass**.

**Step 6: Commit**

Save progress with an atomic commit using `vcs-commit`.

> Repeat Phase 2 for each remaining unchecked subtask.

---

## Phase 3: Delivery (Persona → [SWE Reviewer](../swe-reviewer/SKILL.md))

Adopt the **Reviewer** persona.

**Step 1: Quality gate**

Verify the branch is synced with the base branch. Confirm all subtask criteria are met.

**Step 2: Create the PR/MR**

Create the Pull/Merge Request using `vcs-change-request`. Link the PR to the main issue.

**Step 3: Update the issue checklist**

Edit the Architectural Plan comment:
- Mark the subtask as `[x]` complete.
- Add the PR/MR link inline next to the subtask.

Example update:
```markdown
- [x] Subtask 1: [Description] → PR #42
```

**Step 4: Post a Delivery comment**

Post a new comment on the issue:

```markdown
## ✅ Subtask Complete: [Subtask Name]

- **Branch**: `feat/...`
- **PR/MR**: [Link]
- **Summary**: [What was done in 1–2 sentences]

> ⏳ Awaiting merge approval.
```

**Step 5: MITM — Request USER sign-off**

> "Subtask X is complete. Here is the PR and progress update on the issue. Ready to merge?"

**Feedback loop:** USER requests changes → fix → re-present.

---

## Loop Transitions & Completion

After Phase 3, return to Phase 2 for the next unchecked subtask.

```
For each subtask in checklist:
  → Phase 2 (Implementer) → Phase 3 (Reviewer) → update issue comment
```

When all subtasks are checked, close the issue with a **Closure comment**:

```markdown
## 🎉 Task Completed

All subtasks have been implemented and merged.

| Subtask | PR/MR | Status |
|:--------|:------|:-------|
| Subtask 1 | PR #42 | ✅ Merged |
| Subtask 2 | PR #43 | ✅ Merged |

> Issue closed.
```

---

## Exception Handling

For any situation that breaks the normal flow, **always post a comment** on the issue.

### 🚧 Blocked

Post when progress stops due to an external dependency or uncertainty:

```markdown
## 🚧 Blocked: [Subtask Name]

**Reason**: [Clear explanation of what is blocking progress.]
**Impact**: [What cannot proceed until this is resolved.]
**Next Action**: [What needs to happen to unblock — tagging a person, a decision, etc.]
```

### ⏪ Revert

Post when a subtask is reverted from the main branch:

```markdown
## ⏪ Reverted: [Subtask Name]

**Reason**: [Why the revert was necessary — test failure, regression, etc.]
**Revert Commit**: [Link]
**Next Steps**: [Re-plan and create a follow-up subtask, or adjust the Architectural Plan.]
```

### ⚠️ Partial Failure

Post when a task was partially implemented due to scope or technical constraints:

```markdown
## ⚠️ Partial Completion: [Subtask Name]

**Completed**: [What was done.]
**Not Completed**: [What was left out and why.]
**Impact**: [Estimated risk or degradation if any.]
**Follow-up**: [Link to new issue or next steps.]
```

---

## Guardrails
- **Never skip MITM gates.** Always pause at Phase 1 Step 4 and Phase 3 Step 5.
- **Never bundle multiple subtasks in one PR.** One subtask = One branch = One PR.
- **Always comment when transitioning phases.** The issue thread is the audit trail.
- **If a subtask is blocked**, post a Blocker comment and invoke the **Architect** to re-plan.
- **If validation fails > 3 times**, post a Blocker comment and surface the problem to the USER rather than looping silently.
