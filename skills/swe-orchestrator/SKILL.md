---
name: swe-workflow-orchestrator
description: "High-level autonomous orchestrator for the SDLC. Coordinates specialized personas (Architect, Implementer, Reviewer)."
---

# 🎼 SWE Workflow Orchestrator

This orchestrator manages the high-level development lifecycle by alternating between specialized **Personas** (Skills). It ensures feedback loops are respected at every phase.

## 🔄 The Master Workflow

### Phase 1: Planning (Role: [Architect](../swe-architect/SKILL.md))
- **Objective**: Requirement gathering and planning.
- **Goal**: Execution Plan + Mermaid Diagram + Iterative Checklist.
- **MITM**: MUST confirm the plan with the USER.

### Phase 2: Implementation (Role: [Implementer](../swe-implementer/SKILL.md))
- **Objective**: Code and local verification.
- **Feedback Loop**: Research -> Implementation -> Testing. Autonomous retries if tests fail.
- **Goal**: Atomic commits for the specific subtask.

### Phase 3: Delivery & Review (Role: [Reviewer](../swe-reviewer/SKILL.md))
- **Objective**: Quality gate and tracking.
- **Goal**: PR Creation + Checklist Update.
- **MITM**: MUST confirm the delivery state with the USER.

---

## 🚦 Loop Transitions
1. **The Architect** maps the world.
2. **The Implementer** builds the path.
3. **The Reviewer** checks the quality.
4. **Recur**: Repeat Phase 2 and 3 for every subtask in the checklist until the main issue is resolved.

## Guidelines
- **Role Identity**: Strictly assume the description and mindset of each [Persona](../../docs/AGENTS.md) during its phase.
- **Persistence**: Ensure the main issue remains the "Single Source of Truth" by updating its subtask checklist frequently.
- **Feedback Loops**: Do not scale up a problem. If a subtask cannot be completed as planned, invoke the **Architect** persona again to adjust the plan.

## Specialized Role Skills
- [**SWE Architect**](../swe-architect/SKILL.md)
- [**SWE Implementer**](../swe-implementer/SKILL.md)
- [**SWE Reviewer**](../swe-reviewer/SKILL.md)
