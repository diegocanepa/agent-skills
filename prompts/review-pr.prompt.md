---
name: review-pr
description: "Review a PR and report notes, warnings, and blockers."
argument-hint: "pr=number or url"
agent: swe-reviewer
---

Review the specified PR and deliver a structured report. If there are no findings, state that the PR is ready to merge.

PR:
- ${input:pr}
