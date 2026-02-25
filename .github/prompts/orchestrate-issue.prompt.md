---
name: orchestrate-issue
description: "Orchestrate the full workflow starting from an issue."
argument-hint: "issue=URL or short description"
agent: swe-orchestrator
---

Start the complete workflow:
1. Request a plan from the Planner and wait for user approval.
2. Coordinate implementation of subtasks according to PR strategy.
3. Request PR reviews and present findings to the user.

Issue:
- ${input:issue}
