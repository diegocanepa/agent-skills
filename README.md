# Agent Skills Repository

This repository contains a collection of development skills and best practices to be used across different projects, both professional and personal.

## 🚀 Quick Start

### One-Time Setup

1. Clone this repository to a permanent location:

```bash
cd ~/Documents/Projects  # or your preferred location
git clone <your-repo-url> agent-skills
cd agent-skills
```

2. (Optional) Add a global alias to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
# Add this line to ~/.zshrc
alias sync-skills='cd ~/Documents/Projects/agent-skills && git pull && make install && cd -'
```

3. Reload your shell:

```bash
source ~/.zshrc
```

Now you can sync skills from anywhere with:

```bash
sync-skills
```

### Installation

Install skills to all supported AI agents (Claude, Cursor, Augment, GitHub Copilot):

```bash
make install
```

### Install to Specific Agent

```bash
make install-claude      # Install to Claude only
make install-cursor      # Install to Cursor only
make install-augment     # Install to Augment only
make install-copilot     # Install to GitHub Copilot only
```

### Check Installation Status

```bash
make status              # Show installation status for all agents
make list                # List all available skills
```

### Uninstall

```bash
make uninstall           # Uninstall from all agents
make uninstall-claude    # Uninstall from Claude only
make uninstall-cursor    # Uninstall from Cursor only
make uninstall-augment   # Uninstall from Augment only
make uninstall-copilot   # Uninstall from GitHub Copilot only
```

---

## 🛠️ Contributing Skills

When adding a new skill:

1. Create a new folder under `skills/` with the skill name (kebab-case)
2. Add a `SKILL.md` file inside the folder
3. Include frontmatter with `name` and `description`
4. Follow the existing structure and format
5. Update this README with the new skill in the Available Skills section
6. Run `make install` to sync with your agents

### Skill Template

```markdown
---
name: your-skill-name
description: Brief description of what this skill does and when to use it.
---

# Skill Title

## Overview
Brief overview of the skill...

## Key Concepts
Main concepts and guidelines...

## Examples
Practical examples...
```

## 📦 Installation Directories

Skills are installed to the following directories:

- **Claude**: `~/.claude/skills/`
- **Cursor**: `~/.cursor/skills/`
- **Augment**: `~/.augment/skills/`
- **GitHub Copilot**: `~/.github-copilot/skills/`

Each installed skill includes a `.agent-skills-managed` marker file to track which skills are managed by this repository.

## 🔄 Updating Skills

After making changes to any skill:

1. Commit your changes to the repository
2. Run `make install` to sync updated skills to all agents
3. The Makefile will automatically remove obsolete skills and update existing ones

## ⚙️ Makefile Commands Reference

| Command | Description |
|---------|-------------|
| `make install` | Install all skills to all agents |
| `make install-claude` | Install to Claude only |
| `make install-cursor` | Install to Cursor only |
| `make install-augment` | Install to Augment only |
| `make install-copilot` | Install to GitHub Copilot only |
| `make uninstall` | Remove skills from all agents |
| `make uninstall-claude` | Remove from Claude only |
| `make uninstall-cursor` | Remove from Cursor only |
| `make uninstall-augment` | Remove from Augment only |
| `make uninstall-copilot` | Remove from GitHub Copilot only |
| `make list` | List all available skills |
| `make status` | Show installation status |
| `make help` | Show help message |

## 📝 License

This repository contains personal development skills and best practices. Feel free to use and adapt them for your own projects.