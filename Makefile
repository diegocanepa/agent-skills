.PHONY: install uninstall

CLAUDE_SKILLS_DIR := $(HOME)/.claude/skills
AUGMENT_SKILLS_DIR := $(HOME)/.augment/skills
ANTIGRAVITY_SKILLS_DIR := $(HOME)/.gemini/antigravity/skills
MARKER_FILE := .agent-skills-managed

# Target platforms in format DIR:AGENT_NAME
TARGETS := $(CLAUDE_SKILLS_DIR):claude-code $(AUGMENT_SKILLS_DIR):augment $(ANTIGRAVITY_SKILLS_DIR):antigravity

# Find all directories containing SKILL.md
# 1. Manual skills in root
# 2. External skills temporarily in .agent/skills, etc.
SKILL_FOLDERS := $(patsubst %/SKILL.md,%,$(wildcard */SKILL.md))
EXTERNAL_LOCS := .agent/skills .claude/skills .augment/skills .agents/skills skills

install: absorb
	@if [ -n "$$(git status --porcelain)" ]; then \
		echo "Error: uncommitted changes. Commit or stash before syncing."; \
		exit 1; \
	fi
	@git checkout main
	@git pull origin main
	@for pair in $(TARGETS); do \
		target=$${pair%%:*}; \
		agent=$${pair##*:}; \
		mkdir -p "$$target"; \
		# Remove previously managed skills that no longer exist in the repo \
		for dir in "$$target"/*/; do \
			if [ -f "$$dir$(MARKER_FILE)" ]; then \
				skill=$$(basename "$$dir"); \
				if [ ! -d "$(CURDIR)/$$skill" ]; then \
					rm -rf "$$dir"; \
					echo "Removed obsolete in $$agent: $$skill"; \
				fi; \
			fi; \
		done; \
		# Install current skills with marker \
		for skill in $(SKILL_FOLDERS); do \
			rm -rf "$$target/$$skill"; \
			cp -r "$(CURDIR)/$$skill" "$$target/$$skill"; \
			touch "$$target/$$skill/$(MARKER_FILE)"; \
			echo "Installed in $$agent: $$skill"; \
			# Check for recursive installation commands in SKILL.md \
			cmd=$$(grep -E '^# Installation: (npx|bash)' "$(CURDIR)/$$skill/SKILL.md" | head -n 1 | sed 's/^# Installation: //'); \
			if [ -n "$$cmd" ]; then \
				# Replace {AGENT} placeholder with the current agent name \
				final_cmd=$$(echo "$$cmd" | sed "s/{AGENT}/$$agent/g"); \
				echo "Executing remote installation for $$skill ($$agent): $$final_cmd"; \
				eval $$final_cmd; \
			fi; \
		done; \
	done

uninstall:
	@for target in $(TARGET_DIRS); do \
		for skill in $(SKILL_FOLDERS); do \
			if [ -d "$$target/$$skill" ]; then \
				rm -rf "$$target/$$skill"; \
				echo "Removed from $$(basename $$target): $$skill"; \
			fi; \
		done; \
	done

# Utility to add external skills from skills.sh or GitHub
# Usage: make add SOURCE=vercel-labs/agent-skills SKILL=web-design-guidelines
add:
	@if [ -z "$(SOURCE)" ]; then echo "Error: Missing SOURCE. Usage: make add SOURCE=... [SKILL=...]"; exit 1; fi
	@echo "Installing external skill(s) from $(SOURCE)..."
	@if [ -n "$(SKILL)" ]; then \
		npx -y skills add $(SOURCE) --skill $(SKILL) --agent antigravity; \
	else \
		npx -y skills add $(SOURCE) --agent antigravity; \
	fi
	@$(MAKE) absorb

# Absorbs skills from agent-specific folders into the root repo
absorb:
	@for loc in $(EXTERNAL_LOCS); do \
		if [ -d "$$loc" ]; then \
			for skill_path in "$$loc"/*; do \
				if [ -d "$$skill_path" ] && [ -f "$$skill_path/SKILL.md" ]; then \
					skill_name=$$(basename "$$skill_path"); \
					if [ -d "./$$skill_name" ]; then \
						echo "Updating existing skill: $$skill_name"; \
						rm -rf "./$$skill_name"; \
					else \
						echo "Absorbing new skill: $$skill_name"; \
					fi; \
					mv "$$skill_path" "./$$skill_name"; \
				fi; \
			done; \
			rmdir "$$loc" 2>/dev/null || true; \
			parent=$$(dirname "$$loc"); \
			if [ "$$parent" != "." ]; then rmdir "$$parent" 2>/dev/null || true; fi; \
		fi; \
	done

