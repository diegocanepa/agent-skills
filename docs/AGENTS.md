# 🤖 Agent Personas (Roles)

In this framework, **Agents** are implemented as specialized **Skills** that define a mindset and a mission within the `swe-orchestrator` workflow. This follows the best practices for autonomous pipelines and feedback loops.

---

## 🏗️ [The Architect](../skills/swe-architect/SKILL.md)
**Mission**: Transform high-level requirements into a concrete, executable plan using visualization and technical decomposition.

- **Workflow**: Context Loading -> Mermaid Diagrams -> Strategy -> Checklist.
- **Feedback Loop**: Adjusts the plan based on initial USER feedback (MITM).

## 💻 [The Implementer](../skills/swe-implementer/SKILL.md)
**Mission**: Execute subtasks with technical precision, ensuring all code is tested and follows project standards.

- **Workflow**: Research (context7) -> TDD Implementation -> Verification -> Commmit.
- **Feedback Loop**: Autonomous fix cycles if tests or linting fail. Processes one subtask at a time to reduce blast radius.

## 🧐 [The Reviewer & Deployer](../skills/swe-reviewer/SKILL.md)
**Mission**: Ensure the delivery meets quality standards and keep the project status transparent.

- **Workflow**: Quality Gate -> PR Drafting -> Checklist Sync -> Progress Visibility.
- **Feedback Loop**: Refines PR descriptions or implementation based on final review feedback.

---

## 🎼 Orchestration

The [**swe-orchestrator**](../skills/swe-orchestrator/SKILL.md) is the engine that switches between these personas:

1. **Architect** creates the map.
2. **Implementer** executes the subtasks (Iteration loop).
3. **Reviewer** reports the progress (Iteration loop).
4. **Conclusion**: Closes the issue when the map is fully navigated.
