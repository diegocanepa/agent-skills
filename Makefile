.PHONY: add absorb

EXTERNAL_LOCS := .agent/skills .claude/skills .augment/skills .agents/skills

# Utility to add external skills using the official CLI
# Usage: make add SOURCE=user/repo [SKILL=name] [AGENT=antigravity]
add:
	@if [ -z "$(SOURCE)" ]; then echo "Error: Missing SOURCE. Usage: make add SOURCE=user/repo [SKILL=name] [AGENT=antigravity]"; exit 1; fi
	@AGENT=$${AGENT:-antigravity}; \
	if [ -n "$(SKILL)" ]; then \
		npx -y skills add $(SOURCE) --skill $(SKILL) --agent $$AGENT; \
	else \
		npx -y skills add $(SOURCE) --agent $$AGENT; \
	fi
	@$(MAKE) absorb

# Absorbs skills from agent-specific folders into the root repo (for local development)
absorb:
	@for loc in $(EXTERNAL_LOCS); do \
		if [ -d "$$loc" ]; then \
			for skill_path in "$$loc"/*-*; do \
				if [ -d "$$skill_path" ] && [ -f "$$skill_path/SKILL.md" ]; then \
					skill_name=$$(basename "$$skill_path"); \
					if [ -d "./skills/$$skill_name" ]; then \
						echo "Updating existing skill: $$skill_name"; \
						rm -rf "./skills/$$skill_name"; \
					else \
						echo "Absorbing new skill: $$skill_name"; \
					fi; \
					mv "$$skill_path" "./skills/$$skill_name"; \
				fi; \
			done; \
			rmdir "$$loc" 2>/dev/null || true; \
			parent=$$(dirname "$$loc"); \
			if [ "$$parent" != "." ]; then rmdir "$$parent" 2>/dev/null || true; fi; \
		fi; \
	done
