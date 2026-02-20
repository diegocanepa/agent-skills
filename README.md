# 🧠 Agent Skills

Collection of modular skills for AI agents to enhance development workflows. This repository provides a set of specialized instructions and tools to make your agent more efficient in tasks ranging from backend coding to version control management.

## 📂 Documentation

- **[Available Skills](./docs/SKILLS.md)**: Explore the list of specialized development and VCS skills.
- **[Required MCP Servers](./docs/MCP.md)**: Setup and configuration guides for GitHub, GitLab, and Context7.

---

### 📦 Quick Installation

You can install all skills directly into your agent using the `skills` CLI:

```bash
# Install all skills from this repository
npx skills add diegocanepa/agent-skills --agent antigravity

# Install a specific skill
npx skills add diegocanepa/agent-skills --skill vcs-commit --agent antigravity
```

---

### � Getting Started

1. Configure the [Required MCP Servers](./docs/MCP.md).
2. Install the skills using the command above.
3. Your agent will now be able to use these skills based on the context of your requests.