# 🧠 Agent Skills

Collection of modular skills for AI agents to enhance development workflows.

### 🚀 Available Skills

| Skill | Description |
| :--- | :--- |
| **[backend-coder](./backend-coder/SKILL.md)** | SOLID development, design patterns, and clean architecture. |
| **[branch-naming](./branch-naming/SKILL.md)** | Standardized Git branch naming conventions. |
| **[commit-guidelines](./commit-guidelines/SKILL.md)** | Conventional commits and intelligent staging. |
| **[github-issues](./github-issues/SKILL.md)** | MCP-powered GitHub issue management. |
| **[golang](./golang/SKILL.md)** | Idiomatic Go patterns, concurrency, and error handling. |
| **[mr-description](./mr-description/SKILL.md)** | Templates for clear, reviewable MR/PR descriptions. |
| **[python](./python/SKILL.md)** | Modern Python with type hints and PEP standards. |
| **[software-engineer-workflow](./software-engineer-workflow/SKILL.md)** | End-to-end software engineer lifecycle. |

### 🔄 Remote/Proxy Skills

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
*Syncs skills to `~/.claude/skills/`, `~/.augment/skills/`, and `~/.gemini/antigravity/skills/`.*

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