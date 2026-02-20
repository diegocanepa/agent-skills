# 🧠 Agent Skills

Collection of modular skills for AI agents to enhance development workflows.

### 🚀 Available Skills

| Skill | Description |
| :--- | :--- |
| **[swe-workflow](./skills/swe-workflow/SKILL.md)** | Master orchestrator for the software development life cycle. |
| **[backend-coder](./skills/backend-coder/SKILL.md)** | SOLID principles, clean architecture, and context-driven documentation. |
| **[vcs-branch](./skills/vcs-branch/SKILL.md)** | Standardized Git branch naming and strategy. |
| **[vcs-commit](./skills/vcs-commit/SKILL.md)** | Conventional commits following best practices and safety protocols. |
| **[vcs-issue-creator](./skills/vcs-issue-creator/SKILL.md)** | Expert issue creation for GitHub and GitLab using structured templates. |
| **[vcs-issue-management](./skills/vcs-issue-management/SKILL.md)** | Manage issue lifecycle with professional communication and updates. |
| **[vcs-change-request](./skills/vcs-change-request/SKILL.md)** | Templates and guidelines for reviewable MR/PR descriptions. |
| **[skill-creator](./skills/skill-creator/SKILL.md)** | Helper to install the official skill creator from skills.sh. |

### �️ Required MCP Servers

The following MCP servers must be installed and configured for these skills to function at full capacity:

| Server | Description | Documentation |
| :--- | :--- | :--- |
| **GitHub** | Official GitHub platform interaction. | [mcp/github.md](./mcp/github.md) |
| **GitLab** | Official GitLab platform interaction. | [mcp/gitlab.md](./mcp/gitlab.md) |
| **Context7** | Dynamic documentation & context provider. | [mcp/context7.md](./mcp/context7.md) |

### �🔄 Remote/Proxy Skills

You can create a "Proxy Skill" in this repo that automatically triggers an external installation when you run `make install`. This is perfect if you want to keep your manual skills and external skills managed from one place.

To do this, create a `SKILL.md` with a special comment:

```markdown
---
name: external-skill
description: Proxy for an external skill
---
# Installation: npx -y skills add some-org/repo --skill some-skill --agent {AGENT}
```

When you run `make install`, the Makefile will detect that line and execute it for you.

### 🌐 External Skills (Manual Import)

### ⚙️ Installation

```bash
git clone <repo-url>
cd agent-skills
make install
```
*Syncs skills to `~/.claude/skills/`, `~/.augment/skills/`, or `~/.gemini/antigravity/skills/`. The script will ask you to select the target platform during installation.*

### ➕ Adding a Skill

1. Create a folder with a `SKILL.md` file:
```
my-skill/
└── SKILL.md
```

2. Add frontmatter and content:
```markdown
---
name: my-skill
description: Brief description for the Agent to decide when to apply it.
---
# My Skill
[Patterns, examples, and guidance]
```

3. Merge to `main` and run `make install`.

### 🗑 Uninstall
```bash
make uninstall
```