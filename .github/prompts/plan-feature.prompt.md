---
name: plan-feature
description: "Generate a complete technical plan and save architecture-plan.md."
argument-hint: "issue=URL or short description"
agent: swe-architect
---

Use the provided information to produce a complete architectural plan. If requirements are missing or ambiguous, ask focused clarification questions before finalizing the plan.

Input:
- Issue or description: ${input:issue}

Required output:
- A markdown file named `architecture-plan.md` at the workspace root containing:
  - Technical approach
  - Mermaid diagram
  - A checklist of subtasks with PR strategy and explicit dependencies
  - A rollout table
