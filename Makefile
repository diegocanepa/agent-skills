## =============================================================================
##  Agent Skills — Agents Install / Uninstall
##
##  Skills are installed separately via the npx CLI:
##    npx skills add diegocanepa/agent-skills --agent <tool>
##
##  This Makefile only manages agent personas:
##    make install    → interactive: choose tool + scope, installs agents
##    make uninstall  → interactive: removes installed agents
##    make list       → show installed agents and their locations
##    make help       → show this message
## =============================================================================

SHELL := /bin/bash

# ─── Source directory ─────────────────────────────────────────────────────────
AGENTS_SRC := agents

# ─── Agent install locations per tool ────────────────────────────────────────
#
#  Convention:
#    TOOL_PROJECT_AGENTS  →  <repo>/<tool-dir>/agents   (project scope)
#    TOOL_GLOBAL_AGENTS   →  ~/<tool-dir>/agents         (global scope)

## GitHub Copilot
COPILOT_PROJECT_AGENTS  := .github/agents
COPILOT_GLOBAL_AGENTS   := $(HOME)/.copilot/agents

## Cursor
CURSOR_PROJECT_AGENTS   := .cursor/agents
CURSOR_GLOBAL_AGENTS    := $(HOME)/.cursor/agents

## Claude Code
CLAUDE_PROJECT_AGENTS   := .claude/agents
CLAUDE_GLOBAL_AGENTS    := $(HOME)/.claude/agents

## Antigravity (Gemini)
ANTIGRAVITY_PROJECT_AGENTS  := .agent/agents
ANTIGRAVITY_GLOBAL_AGENTS   := $(HOME)/.agent/agents

## OpenAI Codex
CODEX_PROJECT_AGENTS    := .codex/agents
CODEX_GLOBAL_AGENTS     := $(HOME)/.codex/agents

# ─── Agent file extension per tool ────────────────────────────────────────────
#  Copilot uses .agent.md; all others use plain .md
COPILOT_AGENT_EXT       := .agent.md
CURSOR_AGENT_EXT        := .md
CLAUDE_AGENT_EXT        := .md
ANTIGRAVITY_AGENT_EXT   := .md
CODEX_AGENT_EXT         := .md

# ─── Main targets ─────────────────────────────────────────────────────────────

.PHONY: help install uninstall list _do_install _do_uninstall _list_location

help:
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║       Agent Skills — Agent Installer         ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo ""
	@echo "  make install    Install agent personas for a chosen tool"
	@echo "  make uninstall  Remove installed agent personas"
	@echo "  make list       Show installed agents and locations"
	@echo "  make help       Show this message"
	@echo ""
	@echo "  Supported tools: copilot | cursor | claude | antigravity | codex"
	@echo "  Scope:           project (current repo) | global (home directory)"
	@echo ""
	@echo "  💡 To install skills, use:"
	@echo "     npx skills add diegocanepa/agent-skills --agent <tool>"
	@echo ""

# ─── Install ──────────────────────────────────────────────────────────────────

install:
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║          Agent Personas Installer            ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo ""
	@echo "Select your tool:"
	@echo "  1) GitHub Copilot"
	@echo "  2) Cursor"
	@echo "  3) Claude Code"
	@echo "  4) Antigravity (Gemini)"
	@echo "  5) OpenAI Codex"
	@echo ""
	@read -p "Tool [1-5]: " tool_choice; \
	echo ""; \
	echo "Select scope:"; \
	echo "  1) Project  (installs into current repository)"; \
	echo "  2) Global   (installs into your home directory)"; \
	echo ""; \
	read -p "Scope [1-2]: " scope_choice; \
	echo ""; \
	case $$tool_choice in \
		1) TOOL=copilot     ;; \
		2) TOOL=cursor      ;; \
		3) TOOL=claude      ;; \
		4) TOOL=antigravity ;; \
		5) TOOL=codex       ;; \
		*) echo "❌  Invalid tool choice."; exit 1 ;; \
	esac; \
	case $$scope_choice in \
		1) SCOPE=project ;; \
		2) SCOPE=global  ;; \
		*) echo "❌  Invalid scope choice."; exit 1 ;; \
	esac; \
	$(MAKE) _do_install TOOL=$$TOOL SCOPE=$$SCOPE

_do_install:
	@TOOL="$(TOOL)"; SCOPE="$(SCOPE)"; \
	case "$$TOOL-$$SCOPE" in \
		copilot-project)     AGENTS_DEST="$(COPILOT_PROJECT_AGENTS)";     EXT="$(COPILOT_AGENT_EXT)"     ;; \
		copilot-global)      AGENTS_DEST="$(COPILOT_GLOBAL_AGENTS)";      EXT="$(COPILOT_AGENT_EXT)"     ;; \
		cursor-project)      AGENTS_DEST="$(CURSOR_PROJECT_AGENTS)";      EXT="$(CURSOR_AGENT_EXT)"      ;; \
		cursor-global)       AGENTS_DEST="$(CURSOR_GLOBAL_AGENTS)";       EXT="$(CURSOR_AGENT_EXT)"      ;; \
		claude-project)      AGENTS_DEST="$(CLAUDE_PROJECT_AGENTS)";      EXT="$(CLAUDE_AGENT_EXT)"      ;; \
		claude-global)       AGENTS_DEST="$(CLAUDE_GLOBAL_AGENTS)";       EXT="$(CLAUDE_AGENT_EXT)"      ;; \
		antigravity-project) AGENTS_DEST="$(ANTIGRAVITY_PROJECT_AGENTS)"; EXT="$(ANTIGRAVITY_AGENT_EXT)" ;; \
		antigravity-global)  AGENTS_DEST="$(ANTIGRAVITY_GLOBAL_AGENTS)";  EXT="$(ANTIGRAVITY_AGENT_EXT)" ;; \
		codex-project)       AGENTS_DEST="$(CODEX_PROJECT_AGENTS)";       EXT="$(CODEX_AGENT_EXT)"       ;; \
		codex-global)        AGENTS_DEST="$(CODEX_GLOBAL_AGENTS)";        EXT="$(CODEX_AGENT_EXT)"       ;; \
		*) echo "❌  Unknown combination: $$TOOL-$$SCOPE"; exit 1 ;; \
	esac; \
	echo "🔧 Installing agents for: $$TOOL [$$SCOPE]"; \
	echo ""; \
	mkdir -p "$$AGENTS_DEST"; \
	for agent_dir in $(AGENTS_SRC)/*/; do \
		agent_name=$$(basename $$agent_dir); \
		src="$$agent_dir/AGENT.md"; \
		dest="$$AGENTS_DEST/$$agent_name$$EXT"; \
		if [ -f "$$src" ]; then \
			cp "$$src" "$$dest"; \
			echo "  ✅ $$agent_name → $$dest"; \
		fi; \
	done; \
	echo ""; \
	echo "✅ Done! Agents installed in: $$AGENTS_DEST"

# ─── Uninstall ────────────────────────────────────────────────────────────────

uninstall:
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║         Agent Personas Uninstaller           ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo ""
	@echo "Select your tool:"
	@echo "  1) GitHub Copilot"
	@echo "  2) Cursor"
	@echo "  3) Claude Code"
	@echo "  4) Antigravity (Gemini)"
	@echo "  5) OpenAI Codex"
	@echo ""
	@read -p "Tool [1-5]: " tool_choice; \
	echo ""; \
	echo "Select scope:"; \
	echo "  1) Project  (removes from current repository)"; \
	echo "  2) Global   (removes from home directory)"; \
	echo ""; \
	read -p "Scope [1-2]: " scope_choice; \
	echo ""; \
	case $$tool_choice in \
		1) TOOL=copilot     ;; \
		2) TOOL=cursor      ;; \
		3) TOOL=claude      ;; \
		4) TOOL=antigravity ;; \
		5) TOOL=codex       ;; \
		*) echo "❌  Invalid tool choice."; exit 1 ;; \
	esac; \
	case $$scope_choice in \
		1) SCOPE=project ;; \
		2) SCOPE=global  ;; \
		*) echo "❌  Invalid scope choice."; exit 1 ;; \
	esac; \
	$(MAKE) _do_uninstall TOOL=$$TOOL SCOPE=$$SCOPE

_do_uninstall:
	@TOOL="$(TOOL)"; SCOPE="$(SCOPE)"; \
	case "$$TOOL-$$SCOPE" in \
		copilot-project)     AGENTS_DEST="$(COPILOT_PROJECT_AGENTS)"     ;; \
		copilot-global)      AGENTS_DEST="$(COPILOT_GLOBAL_AGENTS)"      ;; \
		cursor-project)      AGENTS_DEST="$(CURSOR_PROJECT_AGENTS)"      ;; \
		cursor-global)       AGENTS_DEST="$(CURSOR_GLOBAL_AGENTS)"       ;; \
		claude-project)      AGENTS_DEST="$(CLAUDE_PROJECT_AGENTS)"      ;; \
		claude-global)       AGENTS_DEST="$(CLAUDE_GLOBAL_AGENTS)"       ;; \
		antigravity-project) AGENTS_DEST="$(ANTIGRAVITY_PROJECT_AGENTS)" ;; \
		antigravity-global)  AGENTS_DEST="$(ANTIGRAVITY_GLOBAL_AGENTS)"  ;; \
		codex-project)       AGENTS_DEST="$(CODEX_PROJECT_AGENTS)"       ;; \
		codex-global)        AGENTS_DEST="$(CODEX_GLOBAL_AGENTS)"        ;; \
		*) echo "❌  Unknown combination: $$TOOL-$$SCOPE"; exit 1 ;; \
	esac; \
	echo ""; \
	echo "🔧 Uninstalling agents for: $$TOOL [$$SCOPE]"; \
	if [ -d "$$AGENTS_DEST" ]; then \
		rm -rf "$$AGENTS_DEST"; \
		echo "  🗑  Removed: $$AGENTS_DEST"; \
	else \
		echo "  ⚠️  Not found, skipping: $$AGENTS_DEST"; \
	fi; \
	echo ""; \
	echo "✅ Done."

# ─── List ─────────────────────────────────────────────────────────────────────

list:
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║           Installed Agent Personas           ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo ""
	@echo "Checking all known install locations..."
	@echo ""
	@$(MAKE) _list_location LABEL="Copilot (project)"     AGENTS_DEST="$(COPILOT_PROJECT_AGENTS)"
	@$(MAKE) _list_location LABEL="Copilot (global)"      AGENTS_DEST="$(COPILOT_GLOBAL_AGENTS)"
	@$(MAKE) _list_location LABEL="Cursor (project)"      AGENTS_DEST="$(CURSOR_PROJECT_AGENTS)"
	@$(MAKE) _list_location LABEL="Cursor (global)"       AGENTS_DEST="$(CURSOR_GLOBAL_AGENTS)"
	@$(MAKE) _list_location LABEL="Claude (project)"      AGENTS_DEST="$(CLAUDE_PROJECT_AGENTS)"
	@$(MAKE) _list_location LABEL="Claude (global)"       AGENTS_DEST="$(CLAUDE_GLOBAL_AGENTS)"
	@$(MAKE) _list_location LABEL="Antigravity (project)" AGENTS_DEST="$(ANTIGRAVITY_PROJECT_AGENTS)"
	@$(MAKE) _list_location LABEL="Antigravity (global)"  AGENTS_DEST="$(ANTIGRAVITY_GLOBAL_AGENTS)"
	@$(MAKE) _list_location LABEL="Codex (project)"       AGENTS_DEST="$(CODEX_PROJECT_AGENTS)"
	@$(MAKE) _list_location LABEL="Codex (global)"        AGENTS_DEST="$(CODEX_GLOBAL_AGENTS)"

_list_location:
	@if [ -d "$(AGENTS_DEST)" ]; then \
		echo "  📍 $(LABEL) → $(AGENTS_DEST)/"; \
		ls "$(AGENTS_DEST)" 2>/dev/null | sed 's/^/       • /'; \
		echo ""; \
	fi
