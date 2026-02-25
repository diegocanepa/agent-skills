# 🧠 Agent Skills

Collection of modular skills and agent personas for AI agents to enhance development workflows. This repository provides specialized instructions for tasks ranging from backend coding to full autonomous SDLC orchestration.

## 📂 Documentation

- **[Available Skills](./docs/SKILLS.md)**: Explore the list of development, VCS, and orchestration skills.
- **[Agent Personas](./docs/AGENTS.md)**: Specialized roles (Orchestrator, Architect, Implementer, Reviewer) for autonomous workflows.
- **[Required MCP Servers](./docs/MCP.md)**: Setup and configuration guides for GitHub, GitLab, and Context7.

---

## 📦 Installing Skills

Use the `skills` CLI to install skills into your agent:

```bash
# Install all skills from this repository
npx skills add diegocanepa/agent-skills --agent antigravity

# Install a specific skill
npx skills add diegocanepa/agent-skills --skill vcs-commit --agent antigravity
```

Supported agents: `antigravity`, `copilot`, `cursor`, `claude`, `codex`

---

## 🤖 Installing Agent

Agent define *who the AI is* during each phase of development (Orchestrator, Architect, Implementer, Reviewer). They are installed separately from skills using the Makefile.

```bash
# Interactive installer — choose your tool and scope
make install
```

### Install locations

| Tool | Project scope | Global scope |
|:-----|:-------------|:-------------|
| GitHub Copilot | `.github/agents/` | `~/.copilot/agents/` |
| Cursor | `.cursor/agents/` | `~/.cursor/agents/` |
| Claude Code | `.claude/agents/` | `~/.claude/agents/` |
| Antigravity | `.agent/agents/` | `~/.gemini/agents/` |
| OpenAI Codex | `.codex/agents/` | `~/.codex/agents/` |

> **Note:** GitHub Copilot agents are installed as `<name>.agent.md`. All other tools use `<name>.md`.

### Other Makefile commands

```bash
make uninstall  # Remove installed agent personas
make list       # Show all installed agents and their locations
make help       # Show available commands
```

---

## 🚀 Getting Started

1. Configure the [Required MCP Servers](./docs/MCP.md).
2. Install skills: `npx skills add diegocanepa/agent-skills --agent <tool>`
3. Install agent personas: `make install`
4. Your agent is ready — activate the **Orchestrator** on any GitHub issue to start the full SDLC workflow.