---
name: start-implementation
description: "Implement the next approved subtask from the plan."
argument-hint: "subtask=name or exact text from the plan"
agent: swe-implementer
---

Implement the specified subtask and follow the full implementation flow. Include tests and open a PR linked to the main issue.

Subtask:
- ${input:subtask}
