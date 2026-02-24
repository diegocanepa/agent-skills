# 🤖 Available Agents

Agent personas define *who the AI is* during each phase of development. Unlike skills (which define *how* to do something), agents define a **role, mission, and set of responsibilities** that the AI adopts autonomously.

Agents are installed via `make install`. See the [main README](../README.md#-installing-agent) for setup instructions.

---

## 🔄 SWE Workflow Agents

| Agent | Role | Description |
| :--- | :--- | :--- |
| **[swe-orchestrator](../agents/swe-orchestrator/AGENT.md)** | 🎼 Orchestrator | Drives the full SDLC lifecycle. Delegates to the right agent at each phase, manages the issue as the single source of truth, and enforces USER approval gates. |
| **[swe-architect](../agents/swe-architect/AGENT.md)** | 🏗️ Architect | Transforms requirements into a visual, approved technical plan. Produces Mermaid diagrams, subtask breakdowns, PR strategies, and rollout tables. |
| **[swe-implementer](../agents/swe-implementer/AGENT.md)** | 💻 Implementer | Executes one PR at a time: branch → research → implement → validate → commit → open PR. Does not scope or review — only builds and delivers. |
| **[swe-reviewer](../agents/swe-reviewer/AGENT.md)** | 🧐 Reviewer | Analyzes an open PR and reports findings (Notes, Warnings, Blockers) to the Orchestrator. Can also be invoked directly by the USER to check for teammate comments. |

---

## 🔁 How They Work Together

```
USER
 └── Orchestrator
       ├── Phase 1 → Architect   → Plan + Rollout strategy + USER approval
       ├── Phase 2 → Implementer → Branch + Code + Validate + Commit + Open PR
       ├── Phase 3 → Reviewer    → Analyze PR + Report findings
       │             Orchestrator → Update issue checklist + USER decision
       └── (repeat Phase 2–3 per PR) → Completion comment → Ask USER to close
```

Each agent has a **single, focused responsibility**:

| Agent | Does | Does NOT |
| :--- | :--- | :--- |
| Orchestrator | Delegates, tracks issue, manages gates | Write code, create plans |
| Architect | Plans, diagrams, rollout strategy | Implement, review |
| Implementer | Code, tests, commits, opens PR | Scope, review, update issue |
| Reviewer | Analyze PR, report findings | Update issue, create PRs, implement |
