---
name: swe-workflow-orchestrator
description: "Autonomous SDLC orchestrator. Coordinates the Architect, Implementer, and Reviewer personas using structured workflows and feedback loops. Use when starting any development task from an issue."
---

# 🎼 SWE Workflow Orchestrator

Orchestrate the full development lifecycle using specialized personas. Copy the progress checklist into your response and update it as you work through each phase.

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

Create a Mermaid diagram (flowchart or sequence) using `mermaid-diagrams`. Embed it in your response. Prefer a `flowchart` for feature work and a `sequenceDiagram` for API interactions.

**Step 3: Write the execution plan**

Update the issue description with:
- A brief technical summary of the approach (high-level, no code).
- The embedded Mermaid diagram.

**Step 4: Post the iterative checklist**

Add a comment to the issue with a subtask breakdown.

**Step 5: MITM — Request USER approval**

Present the diagram and checklist. Ask:
> "Here is the proposed architectural plan. Does this look correct? Should I adjust the scope or decomposition before implementing?"

**Feedback loop:** If the USER requests changes → revise diagram/plan → re-present for approval. Do NOT proceed to Phase 2 without explicit approval.

---

## Phase 2: Implementation (Persona → [SWE Implementer](../swe-implementer/SKILL.md))

Adopt the **Implementer** persona. Process **one subtask at a time**.

**Step 1: Branch setup**

Create or switch to the subtask branch using `vcs-branch`. Branch name must follow the convention defined in `vcs-branch`.

**Step 2: Research**

Use `backend-coder` + `context7` to fetch relevant documentation for any libraries or frameworks involved.

**Step 3: Implement**

Write the code following the standards in `backend-coder` (SOLID, type safety, error handling).

**Step 4: Validate — Feedback Loop**

Run tests and linters.

```
Validation Loop:
- [ ] Run lint → 0 errors?
- [ ] Run unit tests → all pass?
- [ ] Run integration tests (if applicable) → all pass?
```

If any check fails:
- Identify the error.
- Fix the code.
- Run validation again from the top.
- Only proceed when **all checks pass**.

**Step 5: Commit**

Save progress with an atomic commit using `vcs-commit`.

> Repeat Phase 2 for each remaining unchecked subtask.

---

## Phase 3: Delivery (Persona → [SWE Reviewer](../swe-reviewer/SKILL.md))

Adopt the **Reviewer** persona. Your goal is a clean delivery and transparent progress visibility.

**Step 1: Quality gate**

Verify the branch is synced with the base branch. Confirm all subtask criteria are met.

**Step 2: Draft the PR/MR**

Create the Pull/Merge Request using `vcs-change-request`. Link the PR to the main issue.

**Step 3: Update progress visibility**

Update the iterative checklist on the main issue:
- Mark the completed subtask with `[x]`.
- Add a link to the new PR/MR inline.

**Step 4: MITM — Request USER sign-off**

Present the PR description and updated checklist:
> "Subtask X is complete. Here is the PR and updated progress. Does everything look good to merge? Are there any remaining subtasks to address?"

**Feedback loop:** If USER requests adjustments → apply changes → re-present the PR.

---

## Loop Transitions & Completion

After Phase 3, return to Phase 2 for the next unchecked subtask.

```
For each subtask in checklist:
  → Phase 2 (Implementer) → Phase 3 (Reviewer) → Update checklist
```

**Done when all subtasks are checked.** Close the issue with a final summary comment using `vcs-issue-management`.

---

## Guardrails
- **Never skip MITM gates.** Always pause at Phase 1 Step 5 and Phase 3 Step 4.
- **Never bundle multiple subtasks in one PR.** One subtask = One branch = One PR.
- **If a subtask is blocked**, invoke the **Architect** persona again to re-plan, not the Implementer.
- **Update the checklist** after every subtask completion to keep the issue as the Single Source of Truth.
