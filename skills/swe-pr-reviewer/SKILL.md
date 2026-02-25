---
name: swe-pr-reviewer
description: "Reviews existing MRs/PRs, provides code feedback, responds to comments. Use ONLY for existing MRs - NOT for creating new ones (use swe-reviewer for that)."
---

# 🔍 SWE PR Reviewer

**Use this skill to review existing MRs/PRs or respond to review feedback.**

**Do NOT use for:**
- Creating new MRs (use [swe-reviewer](../swe-reviewer/SKILL.md))
- Implementing code (use [swe-implementer](../swe-implementer/SKILL.md))

---

## Quick Start

1. **Fetch MR details** - Get PR/MR info from GitHub/GitLab
2. **Analyze changes** - Review files for quality + bugs + security
3. **Draft comments** - For each issue: specific, actionable, reasoned
4. **MITM** - Get USER approval before posting
5. **Post review** - Submit with status: Approve / Changes Requested / Comment
6. **Respond to feedback** (if requested) - Address comments, push changes, re-review

---

## Analysis Checklist (Per File)

- ✅ **Architectural** - Aligns with design? Separation of concerns?
- ✅ **Code Quality** - SOLID? Error handling? Type safety? No code smells?
- ✅ **Bugs** - Edge cases? Null checks? Race conditions? Leaks?
- ✅ **Security** - Input validation? SQL injection? XSS? Secrets exposed?
- ✅ **Performance** - Efficient algorithms? Unnecessary loops? Indexing?
- ✅ **Tests** - Comprehensive? Edge cases? Maintainable?
- ✅ **Docs** - Complex logic documented?

---

## Comment Guidelines

**Good comment:**
- Specific: Points to exact code/line
- Actionable: Clear what needs to change
- Reasoned: Explains WHY
- Solution-oriented: Offers alternative or fix explanation
- Professional: Respectful tone

**Bad:** "This is bad" ❌  
**Good:** "This validation logic would benefit from extraction (lines 45-67) to make it independently testable. See: [example]" ✅

---

## Review Statuses

**Approve:** Code is good, ready to merge

**Changes Requested:** Critical issues must be fixed first  
→ Author makes changes + pushes new commits  
→ Return for re-review

**Comment:** Feedback/questions, but not blocking

---

## Responding to Feedback

When author makes changes:
1. Fetch updated MR
2. Review only the NEW changes
3. Verify issues were addressed
4. Re-submit review

---

## Tools

- GitHub/GitLab MCP: Get PR/MR details, post comments
- [backend-coder](../backend-coder/SKILL.md) - Code standards
- [vcs-issue-management](../vcs-issue-management/SKILL.md) - Read linked issues

---

## Use Case 1: Reviewing an Existing MR

**Goal:** Provide comprehensive, constructive code review.

### Steps:

1. **Fetch MR details**
   - Use GitHub/GitLab MCP tools to get MR information:
     - MR title and description
     - Changed files
     - Diff/changes
     - Existing comments
     - Status (open, approved, changes requested)

2. **Read related context**
   - Read the linked issue
   - Review architectural analysis (if available)


---

## Use Case: Review Existing MR

1. **Fetch MR** - Get details from GitHub/GitLab MCP
2. **Analyze** - Check each changed file against analysis checklist
3. **Draft comments** - For each issue, be specific + actionable + reasoned
4. **MITM** - Show USER the comments, get approval
5. **Post** - Reply to all, submit with status (Approve / Changes Requested / Comment)

---

## Use Case: Respond to Review Feedback

1. **Fetch comments** - Get all review threads
2. **Draft responses** - For each: acknowledge, clarify/fix, confirm
3. **MITM** - Show USER the responses, get approval
4. **Post responses** - Reply to each thread
5. **Make changes** (if needed) - Call swe-implementer, make fixes, push, update MR

---

## Review Statuses

- **Approve**: Code is good, ready to merge
- **Changes Requested**: Blocking issues must be fixed first
- **Comment**: Feedback only, not blocking
   - `auth.controller.ts`: 💡 Suggestion - extract validation
   - `auth.test.ts`: ❓ Question - missing edge case tests?
4. Draft 4 comments (1 blocking, 1 suggestion, 1 question, 1 praise)
5. Present to USER → Approved
6. Post review comments
7. Submit review: "Request Changes" due to blocking issue
8. Author responds and fixes issue
9. Re-review → Fixed ✅
10. Approve MR

---

## Example Response Flow

**Responding to review on MR #456**

1. Fetch review comments - 3 comments received
2. Analyze:
   - Comment 1: Blocking - missing salt in hashing → Need to fix
   - Comment 2: Suggestion - extract validation → Good idea
   - Comment 3: Question - edge case tests → Need to clarify
3. Draft responses:
   - Comment 1: "Good catch! Adding salt. Will use bcrypt.genSalt(10)."
   - Comment 2: "Great suggestion! I'll extract to UserValidator."
   - Comment 3: "Added in lines 45-60, testing null email and weak passwords."
4. Present to USER → Approved
5. Post responses
6. Make code changes:
   - Fix password hashing with salt
   - Extract validation logic
7. Commit and push
8. Update responses with commit hash
9. Mark conversations as resolved

---

## Specialized Skills Used

- [**backend-coder**](../backend-coder/SKILL.md) - Code quality standards for review
- [**vcs-issue-management**](../vcs-issue-management/SKILL.md) - Reading linked issues
- **GitHub/GitLab MCP** - Fetching MR details, posting comments, submitting reviews
