# 🤖 Agent Roles

This document defines the specialized agentic personas that operate within the `swe-workflow`. Each role has a specific mission, a set of primary skills, and defined success criteria.

For detailed instructions of each persona, refer to their specific role files:

---

## 🏗️ [The Architect](../agents/architect/ROLE.md)
**Mission**: Transform high-level requirements into a concrete, executable plan.
- **Goal**: Execution Plan & Subtask Breakdown.

## 💻 [The Implementer](../agents/implementer/ROLE.md)
**Mission**: Write high-quality, tested code that fulfills the Architect's plan.
- **Goal**: Clean code, passing tests, and atomic commits.

## 🧐 [The Reviewer & Deployer](../agents/reviewer/ROLE.md)
**Mission**: Ensure delivery quality and maintain visibility of progress.
- **Goal**: Clear PR/MR descriptions and updated checklists.

---

## 🔄 Interaction Model

1. **Context Switch**: The AI reads the `swe-workflow` and identifies which role it must assume based on the current phase of the task.
2. **Role Adoption**: The AI then reads the corresponding `ROLE.md` in the `agents/` directory to understand its specific mission, constraints, and success criteria for that phase.
3. **Execution**: The AI performs the task using the tools and skills recommended for that role.
