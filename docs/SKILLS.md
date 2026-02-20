# 🚀 Available Skills

These modular skills enhance development workflows across GitHub and GitLab.

## 🎼 Orchestration
| Skill | Description |
| :--- | :--- |
| **[swe-orchestrator](../skills/swe-orchestrator/SKILL.md)** | Master orchestrator using specialized [Agent Personas](./AGENTS.md). |
| **[swe-architect](../skills/swe-architect/SKILL.md)** | Technical planning, Mermaid diagrams, and requirement breakdown. |
| **[swe-implementer](../skills/swe-implementer/SKILL.md)** | Development loop: Research, TDD, Implementation, and Persistence. |
| **[swe-reviewer](../skills/swe-reviewer/SKILL.md)** | PR quality gate, checklist synchronization, and visibility. |

## 🛠️ Specialized Development Skills
| Skill | Description |
| :--- | :--- |
| **[backend-coder](../skills/backend-coder/SKILL.md)** | SOLID principles, clean architecture, and context-driven documentation. |
| **[mermaid-diagrams](../skills/mermaid-diagrams/SKILL.md)** | Create architecture diagrams using text-based Mermaid syntax. |

## 📦 Version Control Systems (VCS)
| Skill | Description |
| :--- | :--- |
| **[vcs-branch](../skills/vcs-branch/SKILL.md)** | Standardized Git branch naming and strategy. |
| **[vcs-commit](../skills/vcs-commit/SKILL.md)** | Conventional commits following best practices and safety protocols. |
| **[vcs-issue-creator](../skills/vcs-issue-creator/SKILL.md)** | Expert issue creation for GitHub and GitLab using structured templates. |
| **[vcs-issue-management](../skills/vcs-issue-management/SKILL.md)** | Manage issue lifecycle with professional communication and updates. |
| **[vcs-change-request](../skills/vcs-change-request/SKILL.md)** | Templates and guidelines for reviewable MR/PR descriptions. |

## ⚙️ Utilities
| Skill | Description |
| :--- | :--- |
| **[skill-creator](../skills/skill-creator/SKILL.md)** | Helper to install the official skill creator from skills.sh. |

---

## 🔄 Remote/Proxy Skills

You can create a "Proxy Skill" in this repo that automatically triggers an external installation when you run `npx skills add`. This is perfect if you want to keep your manual skills and external skills managed from one place.

To do this, create a `SKILL.md` with a special comment:

```markdown
---
name: external-skill
description: Proxy for an external skill
---
# Installation: npx -y skills add some-org/repo --skill some-skill --agent {AGENT}
```

When you run `npx skills add`, the tool will detect that line and execute it for you.
