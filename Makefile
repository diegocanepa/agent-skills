.PHONY: install uninstall install-claude install-cursor install-augment install-copilot uninstall-claude uninstall-cursor uninstall-augment uninstall-copilot

CLAUDE_SKILLS_DIR := $(HOME)/.claude/skills
CURSOR_SKILLS_DIR := $(HOME)/.cursor/skills
AUGMENT_SKILLS_DIR := $(HOME)/.augment/skills
COPILOT_SKILLS_DIR := $(HOME)/.github-copilot/skills
MARKER_FILE := .agent-skills-managed

# Find all skill directories (those containing SKILL.md)
SKILL_FOLDERS := $(patsubst skills/%/SKILL.md,%,$(wildcard skills/*/SKILL.md))

install: install-claude install-cursor install-augment install-copilot

install-claude:
	@echo "Installing skills to Claude..."
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Warning: uncommitted changes detected"; \
	fi
	@mkdir -p $(CLAUDE_SKILLS_DIR)
	@# Remove previously managed skills that no longer exist in the repo
	@for dir in $(CLAUDE_SKILLS_DIR)/*/; do \
		if [ -f "$$dir$(MARKER_FILE)" ]; then \
			skill=$$(basename "$$dir"); \
			if [ ! -d "$(CURDIR)/skills/$$skill" ]; then \
				rm -rf "$$dir"; \
				echo "  Removed obsolete: $$skill"; \
			fi; \
		fi; \
	done
	@# Install current skills with marker
	@for skill in $(SKILL_FOLDERS); do \
		rm -rf "$(CLAUDE_SKILLS_DIR)/$$skill"; \
		cp -r "$(CURDIR)/skills/$$skill" "$(CLAUDE_SKILLS_DIR)/$$skill"; \
		touch "$(CLAUDE_SKILLS_DIR)/$$skill/$(MARKER_FILE)"; \
		echo "  ✓ $$skill"; \
	done
	@echo "Claude installation complete!"

install-cursor:
	@echo "Installing skills to Cursor..."
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Warning: uncommitted changes detected"; \
	fi
	@mkdir -p $(CURSOR_SKILLS_DIR)
	@# Remove previously managed skills that no longer exist in the repo
	@for dir in $(CURSOR_SKILLS_DIR)/*/; do \
		if [ -f "$$dir$(MARKER_FILE)" ]; then \
			skill=$$(basename "$$dir"); \
			if [ ! -d "$(CURDIR)/skills/$$skill" ]; then \
				rm -rf "$$dir"; \
				echo "  Removed obsolete: $$skill"; \
			fi; \
		fi; \
	done
	@# Install current skills with marker
	@for skill in $(SKILL_FOLDERS); do \
		rm -rf "$(CURSOR_SKILLS_DIR)/$$skill"; \
		cp -r "$(CURDIR)/skills/$$skill" "$(CURSOR_SKILLS_DIR)/$$skill"; \
		touch "$(CURSOR_SKILLS_DIR)/$$skill/$(MARKER_FILE)"; \
		echo "  ✓ $$skill"; \
	done
	@echo "Cursor installation complete!"

install-augment:
	@echo "Installing skills to Augment..."
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Warning: uncommitted changes detected"; \
	fi
	@mkdir -p $(AUGMENT_SKILLS_DIR)
	@# Remove previously managed skills that no longer exist in the repo
	@for dir in $(AUGMENT_SKILLS_DIR)/*/; do \
		if [ -f "$$dir$(MARKER_FILE)" ]; then \
			skill=$$(basename "$$dir"); \
			if [ ! -d "$(CURDIR)/skills/$$skill" ]; then \
				rm -rf "$$dir"; \
				echo "  Removed obsolete: $$skill"; \
			fi; \
		fi; \
	done
	@# Install current skills with marker
	@for skill in $(SKILL_FOLDERS); do \
		rm -rf "$(AUGMENT_SKILLS_DIR)/$$skill"; \
		cp -r "$(CURDIR)/skills/$$skill" "$(AUGMENT_SKILLS_DIR)/$$skill"; \
		touch "$(AUGMENT_SKILLS_DIR)/$$skill/$(MARKER_FILE)"; \
		echo "  ✓ $$skill"; \
	done
	@echo "Augment installation complete!"

install-copilot:
	@echo "Installing skills to GitHub Copilot..."
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Warning: uncommitted changes detected"; \
	fi
	@mkdir -p $(COPILOT_SKILLS_DIR)
	@# Remove previously managed skills that no longer exist in the repo
	@for dir in $(COPILOT_SKILLS_DIR)/*/; do \
		if [ -f "$$dir$(MARKER_FILE)" ]; then \
			skill=$$(basename "$$dir"); \
			if [ ! -d "$(CURDIR)/skills/$$skill" ]; then \
				rm -rf "$$dir"; \
				echo "  Removed obsolete: $$skill"; \
			fi; \
		fi; \
	done
	@# Install current skills with marker
	@for skill in $(SKILL_FOLDERS); do \
		rm -rf "$(COPILOT_SKILLS_DIR)/$$skill"; \
		cp -r "$(CURDIR)/skills/$$skill" "$(COPILOT_SKILLS_DIR)/$$skill"; \
		touch "$(COPILOT_SKILLS_DIR)/$$skill/$(MARKER_FILE)"; \
		echo "  ✓ $$skill"; \
	done
	@echo "GitHub Copilot installation complete!"

uninstall: uninstall-claude uninstall-cursor uninstall-augment uninstall-copilot

uninstall-claude:
	@echo "Uninstalling skills from Claude..."
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(CLAUDE_SKILLS_DIR)/$$skill" ]; then \
			rm -rf "$(CLAUDE_SKILLS_DIR)/$$skill"; \
			echo "  ✗ $$skill"; \
		fi; \
	done
	@echo "Claude uninstallation complete!"

uninstall-cursor:
	@echo "Uninstalling skills from Cursor..."
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(CURSOR_SKILLS_DIR)/$$skill" ]; then \
			rm -rf "$(CURSOR_SKILLS_DIR)/$$skill"; \
			echo "  ✗ $$skill"; \
		fi; \
	done
	@echo "Cursor uninstallation complete!"

uninstall-augment:
	@echo "Uninstalling skills from Augment..."
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(AUGMENT_SKILLS_DIR)/$$skill" ]; then \
			rm -rf "$(AUGMENT_SKILLS_DIR)/$$skill"; \
			echo "  ✗ $$skill"; \
		fi; \
	done
	@echo "Augment uninstallation complete!"

uninstall-copilot:
	@echo "Uninstalling skills from GitHub Copilot..."
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(COPILOT_SKILLS_DIR)/$$skill" ]; then \
			rm -rf "$(COPILOT_SKILLS_DIR)/$$skill"; \
			echo "  ✗ $$skill"; \
		fi; \
	done
	@echo "GitHub Copilot uninstallation complete!"

list:
	@echo "Available skills:"
	@for skill in $(SKILL_FOLDERS); do \
		echo "  - $$skill"; \
	done

status:
	@echo "Installation status:"
	@echo ""
	@echo "Claude ($(CLAUDE_SKILLS_DIR)):"
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(CLAUDE_SKILLS_DIR)/$$skill" ]; then \
			echo "  ✓ $$skill"; \
		else \
			echo "  ✗ $$skill (not installed)"; \
		fi; \
	done
	@echo ""
	@echo "Cursor ($(CURSOR_SKILLS_DIR)):"
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(CURSOR_SKILLS_DIR)/$$skill" ]; then \
			echo "  ✓ $$skill"; \
		else \
			echo "  ✗ $$skill (not installed)"; \
		fi; \
	done
	@echo ""
	@echo "Augment ($(AUGMENT_SKILLS_DIR)):"
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(AUGMENT_SKILLS_DIR)/$$skill" ]; then \
			echo "  ✓ $$skill"; \
		else \
			echo "  ✗ $$skill (not installed)"; \
		fi; \
	done
	@echo ""
	@echo "GitHub Copilot ($(COPILOT_SKILLS_DIR)):"
	@for skill in $(SKILL_FOLDERS); do \
		if [ -d "$(COPILOT_SKILLS_DIR)/$$skill" ]; then \
			echo "  ✓ $$skill"; \
		else \
			echo "  ✗ $$skill (not installed)"; \
		fi; \
	done

help:
	@echo "Agent Skills Manager"
	@echo ""
	@echo "Usage:"
	@echo "  make install              Install skills to all agents (Claude, Cursor, Augment, Copilot)"
	@echo "  make install-claude       Install skills to Claude only"
	@echo "  make install-cursor       Install skills to Cursor only"
	@echo "  make install-augment      Install skills to Augment only"
	@echo "  make install-copilot      Install skills to GitHub Copilot only"
	@echo ""
	@echo "  make uninstall            Uninstall skills from all agents"
	@echo "  make uninstall-claude     Uninstall skills from Claude only"
	@echo "  make uninstall-cursor     Uninstall skills from Cursor only"
	@echo "  make uninstall-augment    Uninstall skills from Augment only"
	@echo "  make uninstall-copilot    Uninstall skills from GitHub Copilot only"
	@echo ""
	@echo "  make list                 List all available skills"
	@echo "  make status               Show installation status for all agents"
	@echo "  make help                 Show this help message"
	@echo ""
	@echo "Skills directory: $(CURDIR)/skills"
	@echo "Total skills: $(words $(SKILL_FOLDERS))"
