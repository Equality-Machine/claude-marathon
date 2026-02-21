---
name: marathon-end
description: Complete and archive a long-running task. Creates comprehensive summary, consolidates learnings, and prepares the task for future reference. Use when finishing a task or when stopping work on it for the foreseeable future.
---

# Task End - Complete and Archive Long-Running Tasks

Properly close out a task when it's complete or when you're stopping work on it.

---

## What This Does

1. **Create Comprehensive Summary**: Document everything accomplished
2. **Consolidate Learnings**: Gather all insights from all sessions
3. **Archive Deliverables**: Organize final outputs
4. **Document Outcomes**: Record what worked and what didn't
5. **Prepare Handoff**: Make it easy for future you (or others) to understand

---

## Step 1: Gather Task Information

### Find All Sessions for This Task

```bash
CURRENT_DIR="$(pwd)"
TASK_SESSIONS=()

for session in $(ls -td workspace/session_* 2>/dev/null); do
  if [ -f "$session/session.json" ]; then
    WD=$(jq -r '.working_directory // empty' "$session/session.json" 2>/dev/null)
    if [ "$WD" = "$CURRENT_DIR" ]; then
      TASK_SESSIONS+=("$session")
    fi
  fi
done

echo "Found ${#TASK_SESSIONS[@]} sessions for this task"
```

### Review All Sessions

From each session, extract:
- `progress.md` - All completed work
- `learnings.md` - Technical insights
- `SUMMARY.md` - Session summaries
- Checkpoint notes
- Code snapshots

---

## Step 2: Create Task Summary Document

Create `workspace/session_CURRENT/TASK_SUMMARY.md`:

```markdown
# Task Summary: [Task Name]

**Completed**: [Date]
**Working Directory**: `[pwd]`
**Duration**: [X days/weeks]
**Total Sessions**: [N] sessions
**First Session**: [Date] - workspace/session_XXX
**Last Session**: [Date] - workspace/session_YYY

---

## 🎯 Task Objective

### Original Goal
[What was this task trying to achieve?]

### Success Criteria
- [x] Criterion 1
- [x] Criterion 2
- [ ] Criterion 3 (if not all met, explain why)

### Final Outcome
[What was actually delivered?]

---

## ✅ Accomplishments

### Major Features Implemented
1. **Feature A**
   - Description: [what it does]
   - Files: `src/feature-a.ts`, `tests/feature-a.test.ts`
   - Session: workspace/session_XXX

2. **Feature B**
   - Description: ...
   - Files: ...
   - Session: workspace/session_YYY

### Bugs Fixed
1. [Bug description] - Fixed in session_ZZZ
2. [Another bug] - Fixed in session_WWW

### Improvements Made
- [Performance optimization]
- [Code refactoring]
- [Documentation updates]

---

## 📊 Statistics

### Development Metrics
- **Sessions**: [N] sessions
- **Duration**: [X] days over [Y] calendar days
- **Files Modified**: [~N files]
- **Tests Added**: [N tests]
- **Documentation**: [Pages/sections added]

### Timeline
\`\`\`
[Session 1] - [Date] - Initial setup
[Session 2] - [Date] - Core implementation
[Session 3] - [Date] - Testing & refinement
[Session N] - [Date] - Final polish
\`\`\`

---

## 🔑 Key Technical Decisions

### Architecture Choices
1. **Decision**: [What was decided]
   - **Rationale**: [Why this choice]
   - **Alternatives Considered**: [What else was considered]
   - **Outcome**: [How did it work out]

2. **Decision**: ...

### Technology Stack
- **Language**: [e.g., TypeScript]
- **Framework**: [e.g., React, Express]
- **Libraries**: [Key dependencies]
- **Tools**: [Development tools used]

### Patterns & Approaches
[Design patterns, architectural patterns used]

---

## 💡 Consolidated Learnings

### Technical Discoveries
[Gather from all learnings.md files across sessions]

1. **Learning**: [Title]
   - **Context**: [When discovered]
   - **Insight**: [What was learned]
   - **Application**: [How to use this]

2. **Learning**: ...

### Best Practices Identified
- [Practice 1]
- [Practice 2]
- [Practice 3]

### Pitfalls to Avoid
- ❌ [Mistake 1] - [Why it's problematic]
- ❌ [Mistake 2] - [Why it's problematic]

### Useful Code Patterns
\`\`\`typescript
// Pattern name
// [Description of when to use this]
[code example]
\`\`\`

---

## 🚧 Known Issues & Limitations

### Unresolved Problems
1. **Issue**: [Description]
   - **Impact**: [How it affects functionality]
   - **Workaround**: [Temporary solution, if any]
   - **Future Fix**: [How to properly resolve]

### Technical Debt
- [Debt item 1] - [Why it exists, priority to fix]
- [Debt item 2]

### Limitations
- [What the implementation doesn't handle]
- [Edge cases not covered]

---

## 📦 Deliverables

### Code
- **Main Implementation**: `[key files]`
- **Tests**: `[test files]`
- **Configuration**: `[config files]`

### Documentation
- **API Docs**: [Location]
- **User Guide**: [Location]
- **Technical Specs**: [Location]

### Artifacts
- **Diagrams**: [If any]
- **Screenshots**: workspace/session_XXX/screenshots/
- **Logs**: workspace/session_XXX/logs/

---

## 🔄 If You Need to Resume This Task

### Quick Start
1. [First step to take]
2. [Second step]

### Key Files to Review
- `[file1.ts]` - [Why it's important]
- `[file2.ts]` - [Why it's important]

### Context to Understand
[Essential background knowledge needed]

### Next Logical Steps
If continuing this task, the next steps would be:
1. [Step 1]
2. [Step 2]

---

## 📚 References

### Documentation Links
- [Link 1]
- [Link 2]

### Related Issues/PRs
- [GitHub issue #123]
- [PR #456]

### External Resources
- [Tutorial or article that was helpful]

---

## 🎓 Reflections

### What Went Well
- [Success 1]
- [Success 2]

### What Could Be Improved
- [Improvement area 1]
- [Improvement area 2]

### Lessons for Future Tasks
- [Lesson 1]
- [Lesson 2]

---

## 📁 Session Archive

All sessions for this task:

| Session | Date | Duration | Key Work |
|:--------|:-----|:---------|:---------|
| workspace/session_XXX | [Date] | [Time] | [Summary] |
| workspace/session_YYY | [Date] | [Time] | [Summary] |
| workspace/session_ZZZ | [Date] | [Time] | [Summary] |

**Note**: Individual session files remain in their respective workspace directories.

---

**Task completed and documented**: [Timestamp]
**Archive status**: Ready for reference
**Next task**: [If applicable]
```

---

## Step 3: Update Final Progress

Update `progress.md` with final status:

```markdown
---

## ✅ TASK COMPLETED - [Date]

### Final Status
All planned work has been completed and documented.

### Deliverables
- ✅ [List all deliverables]

### See Full Summary
📄 TASK_SUMMARY.md - Comprehensive task documentation

---
```

---

## Step 4: Consolidate Learnings

Update `learnings.md` with a final summary:

```markdown
---

## 📚 Task Completion Summary

This task is now complete. All learnings above have been:
- ✅ Tested in practice
- ✅ Documented with examples
- ✅ Consolidated into TASK_SUMMARY.md

For the complete story of this task, see: **TASK_SUMMARY.md**

---
```

---

## Step 5: Organize Workspace Files

Ensure workspace is well-organized:

- ✅ `TASK_SUMMARY.md` created
- ✅ `progress.md` marked complete
- ✅ `learnings.md` finalized
- ✅ Important files in `drafts/` clearly named
- ✅ Screenshots in `screenshots/` with descriptions
- ✅ Logs archived in `logs/` if relevant
- ✅ Temporary files cleaned up

---

## Step 6: Present Final Report to User

```
🎉 Task Complete - [Task Name]

📊 Task Statistics
- Duration: [X] days ([N] sessions)
- Files Modified: [~N] files
- Tests Added: [N] tests
- Lines of Code: [~N] (if measurable)

✅ Accomplishments
- ✓ [Major achievement 1]
- ✓ [Major achievement 2]
- ✓ [Major achievement 3]

💡 Key Learnings
- [Most valuable insight 1]
- [Most valuable insight 2]

⚠️  Known Issues
- [Issue 1] - [Severity/Impact]
- [Issue 2] - [Severity/Impact]

📦 Deliverables
- [Primary deliverable]
- [Secondary deliverables]

📁 Documentation
📄 Complete Task Summary: workspace/session_CURRENT/TASK_SUMMARY.md

🔄 Future Work
If resuming this task, start with:
[Clear next step]

---

Thank you for using Long Task Manager!
All task information has been preserved for future reference.
```

---

## When to Use `/marathon-end`

**Use when**:
- ✅ Task is completely finished and delivered
- ✅ Stopping work on task for foreseeable future
- ✅ Need to switch to a different project/task
- ✅ Want comprehensive documentation of work done
- ✅ Preparing for team handoff

**Don't use when**:
- ⏸️  Just taking a short break (use `/marathon-checkpoint`)
- 🔄 Switching focus temporarily (use `/marathon-checkpoint`)
- 📊 Task is ongoing (use `/marathon-checkpoint`)

---

## Task End vs Checkpoint

| Aspect | `/marathon-checkpoint` | `/marathon-end` |
|:-------|:------------------|:-----------|
| Purpose | Save progress | Archive task |
| Scope | Since last checkpoint | Entire task |
| Detail | Focused summary | Comprehensive |
| Learnings | Recent insights | All learnings |
| Sessions | Current only | All sessions |
| Frequency | Multiple per session | Once per task |

---

## Best Practices

1. **Be Thorough**: Future you will thank you for detailed documentation
2. **Consolidate**: Gather insights from all sessions
3. **Be Honest**: Document issues and limitations clearly
4. **Think Future**: What would someone need to continue this?
5. **Archive Well**: Organize files for easy future access
6. **Celebrate**: Acknowledge what was accomplished

---

## Optional: Create Git Tag (if applicable)

If this is a significant milestone:

```bash
git tag -a task-[task-name]-complete -m "Completed [task name]"
git push origin task-[task-name]-complete
```

---

**This task is complete. Well done!** 🎉
