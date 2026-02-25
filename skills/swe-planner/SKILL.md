---
name: swe-planner
description: "Phase 2: Creates detailed implementation plans with subtasks based on architectural analysis. Creates and manages .plan/ tracking files."
---

# 📋 SWE Planner (Phase 2)

## Mission
Transform the architectural analysis into an actionable, step-by-step implementation plan with clearly defined subtasks. Create a persistent tracking file in the repository for progress monitoring.

## Prerequisites
- Phase 1 ([swe-architect](../swe-architect/SKILL.md)) must be completed
- Architectural analysis must be posted and approved in the issue

## Scope
**In Scope:**
- Breaking down architecture into implementable subtasks
- Defining execution order and dependencies
- Specifying files, scope, and tests for each subtask
- Creating `.plan/` tracking file in the repository
- Estimating complexity and identifying quality gates

**Out of Scope:**
- Architectural decisions (handled by [swe-architect](../swe-architect/SKILL.md))
- Code implementation (handled by [swe-implementer](../swe-implementer/SKILL.md))
- Code review (handled by [swe-reviewer](../swe-reviewer/SKILL.md))

## Workflow & Feedback Loop

### Step 1: Read Architectural Analysis
Use [vcs-issue-management](../vcs-issue-management/SKILL.md) to:
- Read the issue and locate the architectural analysis comment
- Understand the technical approach
- Review the Mermaid diagram
- Identify components and dependencies

### Step 2: Decompose into Subtasks
Break down the architecture into concrete, actionable subtasks:

**Subtask Criteria:**
- **Atomic**: Each subtask should be independently implementable
- **Testable**: Clear success criteria and tests
- **Ordered**: Logical sequence considering dependencies
- **Scoped**: Specific files and components affected
- **Estimated**: Rough complexity (S/M/L or hours)

**Decomposition Strategy:**
1. Identify natural boundaries (modules, features, layers)
2. Consider dependencies (database → business logic → API → UI)
3. Keep related changes together
4. Aim for 3-8 subtasks (too few = too complex, too many = fragmented)

### Step 3: Define Execution Strategy
Determine:
- **Order of execution**: Which subtasks must be done first
- **Dependencies**: What each subtask depends on
- **Parallelization opportunities**: What can be done in parallel
- **Integration points**: When components need to be integrated

### Step 4: Specify Quality Gates
Define the quality criteria that must be met:
- Unit test coverage requirements
- Integration test requirements
- Linting and code style standards
- Documentation requirements
- Performance benchmarks (if applicable)

### Step 5: Draft Implementation Plan
Prepare a comment following the **Implementation Plan template** from [vcs-issue-management/references/swe-templates.md](../vcs-issue-management/references/swe-templates.md).

Include:
- Link to architectural analysis
- Execution strategy summary
- Detailed subtask list with:
  - Clear description
  - Affected files
  - Scope of work
  - Tests to create/update
- Quality gates
- Reference to `.plan/` file

### Step 6: Create .plan/ Tracking File
Create a persistent tracking file in the target repository:

**File location:** `.plan/[issue-number]-[feature-name].md`

Follow the template from [vcs-issue-management/references/plan-tracking.md](../vcs-issue-management/references/plan-tracking.md).

**Initial content:**
- Architecture summary with link to analysis comment
- Implementation plan with link to plan comment  
- Subtasks with status "Not Started"
- Quality gates checklist
- Empty sections for progress, blockers, notes

**How to create:**
1. Determine issue number from the issue
2. Create feature slug from issue title (lowercase, hyphens)
3. Create the file in `.plan/` directory
4. Commit using [vcs-commit](../vcs-commit/SKILL.md) with message: `docs: create implementation plan for #[issue-number]`

### Step 7: MITM Validation
**STOP** - Present both the drafted comment AND the .plan/ file to the USER:
> "Here is the implementation plan broken down into [N] subtasks. I've also created a tracking file at `.plan/[filename].md`. Does this plan make sense? Should I adjust the subtask breakdown or execution order?"

**Feedback Loop:**
- If USER requests changes → Revise plan and/or .plan/ file → Present again
- If USER approves → Proceed to post

### Step 8: Post to Issue
Once approved:
1. Post the implementation plan comment to the issue using [vcs-issue-management](../vcs-issue-management/SKILL.md)
2. Ensure the .plan/ file is committed to the repository

**End of Phase 2** - Hand off to [swe-implementer](../swe-implementer/SKILL.md) for implementation.

## Success Criteria
- [ ] Architectural analysis read and understood
- [ ] Feature decomposed into 3-8 clear, actionable subtasks
- [ ] Each subtask has files, scope, and tests defined
- [ ] Execution order and dependencies identified
- [ ] Quality gates specified
- [ ] `.plan/[issue-number]-[feature-name].md` created in repository
- [ ] .plan/ file committed with proper commit message
- [ ] Implementation plan comment drafted using proper template
- [ ] USER approval obtained
- [ ] Implementation plan posted to issue

## Communication
Always use the **📋 Implementation Plan** template from [vcs-issue-management/references/swe-templates.md](../vcs-issue-management/references/swe-templates.md).

## Handoff
After posting the implementation plan:
- Notify the orchestrator that Phase 2 is complete
- Provide the path to the `.plan/` file
- The next step is Phase 3: [swe-implementer](../swe-implementer/SKILL.md) will execute subtasks one by one

## Best Practices

### Subtask Sizing
- **Too small**: If it's just 1-2 lines of code, combine with related work
- **Too large**: If it touches >5 files or takes >4 hours, split it
- **Just right**: Completable in one focused session, clear scope

### Ordering Subtasks
1. **Foundation first**: Database models, core types, interfaces
2. **Business logic**: Services, utilities, core functionality
3. **Integration**: APIs, controllers, endpoints
4. **UI/UX**: Frontend components, views
5. **Polish**: Error handling, edge cases, documentation

### Dependencies
- Be explicit about what each subtask needs
- If subtask B depends on subtask A, note it clearly
- Consider creating a dependency diagram if complex

## Example Subtask (Good)
```markdown
- [ ] **Subtask 2: Implement User Authentication Service**
  - **Files:** `src/services/auth.service.ts`, `src/models/user.model.ts`
  - **Scope:** Create authentication service with login/logout methods, JWT generation, password hashing
  - **Tests:** Unit tests for auth service methods, integration test for login flow
  - **Dependencies:** Subtask 1 (User model must exist)
  - **Complexity:** M (2-3 hours)
```

## Example Subtask (Bad)
```markdown
- [ ] Implement authentication stuff
```

## Specialized Skills Used
- [**vcs-issue-management**](../vcs-issue-management/SKILL.md) - Read issue, post plan
- [**vcs-commit**](../vcs-commit/SKILL.md) - Commit .plan/ file
- [**backend-coder**](../backend-coder/SKILL.md) - Best practices for task decomposition
