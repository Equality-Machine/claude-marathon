---
name: marathon-review
description: Review previous sessions of the current task, analyze the current state, and create initial thinking document. Use when starting work on an existing long-running task or when context needs to be restored.
disable-model-invocation: false
---

# Task Review - Resume Long-Running Tasks

Use this skill when starting a new session to continue a long-running task.

## What This Skill Does

1. **Search Previous Sessions**: Find all sessions related to the current project/task
2. **Analyze Progress**: Review what has been accomplished and what remains
3. **Identify Blockers**: Understand current problems and obstacles
4. **Restore Context**: Load relevant information from previous sessions
5. **Create Initial Thinking**: Generate `00-initial-thinking.md` with comprehensive analysis

---

## Execution Steps

### Step 1: Find Previous Sessions

Find the current task workspace (most recent session in current directory):

```bash
CURRENT_DIR="$(pwd)"
SESSIONS=$(ls -td workspace/session_* 2>/dev/null)
```

Filter sessions for current project (if jq available):
```bash
for session in $SESSIONS; do
  if [ -f "$session/session.json" ]; then
    WD=$(jq -r '.working_directory // empty' "$session/session.json" 2>/dev/null)
    if [ "$WD" = "$CURRENT_DIR" ]; then
      echo "Found session: $session"
    fi
  fi
done
```

### Step 2: Review Key Files

From the most recent 2-3 sessions, read:
- `progress.md` - What was accomplished and what's pending
- `learnings.md` - Technical discoveries and best practices
- `SUMMARY.md` (if exists) - Overall task summary

### Step 3: Analyze Current State

Based on previous sessions, determine:

**Completed Work**:
- What features/functions have been implemented?
- What problems have been solved?
- What files have been modified?

**Current Status**:
- What was in progress when the last session ended?
- Are there any incomplete implementations?
- What's the last checkpoint?

**Pending Tasks**:
- What items are marked as "待处理" or "TODO"?
- What was planned but not started?
- What's the next logical step?

**Blockers**:
- Were there any unresolved errors?
- Are there technical challenges mentioned?
- Dependencies or external blockers?

### Step 4: Generate Initial Thinking

Create `workspace/session_CURRENT/00-initial-thinking.md` with:

```markdown
# Task Review - [Date]

**Task Name**: [Extract from previous sessions]
**Working Directory**: `[pwd]`
**Previous Sessions**: [Count] sessions found

---

## 📋 Task Overview

### Original Goal
[What is this task trying to achieve?]

### Timeline
- Started: [First session date]
- Last Activity: [Last session date]
- Duration: [X days/weeks]
- Sessions: [N sessions]

---

## ✅ Progress Summary

### Completed (from previous sessions)
- [x] Feature A - implemented in session_XXX
- [x] Bug fix B - resolved in session_YYY
- ...

### In Progress
- [ ] Feature C - partially implemented
  - Completed: [what's done]
  - Remaining: [what's left]

### Not Started
- [ ] Task D
- [ ] Task E

---

## 🎯 Current State Analysis

### What We Know
[Summary of the current implementation state]

### Technical Context
- Architecture: [key design decisions]
- Technologies: [frameworks, libraries used]
- File structure: [main files and their purposes]

### Recent Changes
[From last session's progress.md]

---

## ❓ Issues & Blockers

### Unresolved Problems
1. [Problem from previous session]
   - Context: ...
   - Attempted solutions: ...
   - Status: ...

### Technical Challenges
[Any difficult technical decisions or challenges]

---

## 💡 Next Steps

### Immediate Actions
1. [Most urgent next step]
2. [Second priority]
3. ...

### Strategy
[How should we approach the remaining work?]

### Questions to Resolve
- [ ] Question 1?
- [ ] Question 2?

---

## 📚 Key Learnings (from previous sessions)

[Copy important learnings from learnings.md that are still relevant]

---

## 🔍 Files to Review

[List of key files that need to be examined to continue work]

---

*Review completed: [timestamp]*
*Ready to continue task execution*
```

### Step 5: Present Summary to User

Show the user:
- 📊 **Task Statistics**: Sessions count, duration, completion percentage (estimate)
- 📁 **Latest Session**: Path to most recent session
- ✅ **Progress**: Quick summary of completed/pending work
- 🎯 **Next Step**: Clear recommendation for what to do next
- 📝 **Review Document**: Path to the generated initial thinking

---

## When to Use This Skill

**Use `/marathon-review` when**:
- Starting a new session to continue an existing long task
- You've been away from a task for a while and need to restore context
- Context was compressed and you need to remember where you were
- Switching between multiple long-running tasks
- User explicitly asks to "review the task" or "what's the status"

**Example triggers**:
- "Let's continue working on the authentication feature"
- "What was I working on last time?"
- "Review the current task status"
- "Where did we leave off?"

---

## Output Format

Present findings in this structure:

```
🔍 Task Review Complete

📊 Task Statistics
- Name: [Task name]
- Sessions: X sessions over Y days
- Completion: ~Z% (estimated)

📁 Recent Sessions
- Latest: workspace/session_20260220_143022_xxx (2 days ago)
- Previous: workspace/session_20260218_091530_yyy (4 days ago)

✅ Progress Summary
Completed:
- ✓ User authentication system
- ✓ Database schema design
- ✓ API endpoints (80% done)

In Progress:
- ⏳ Frontend integration (50% complete)

Pending:
- ⚪ Unit tests
- ⚪ Documentation

🎯 Next Steps
1. Complete frontend authentication flow
2. Add error handling for edge cases
3. Write integration tests

📝 Full Review Document
See: workspace/session_CURRENT/00-initial-thinking.md

💡 Recommendation
Start by reviewing src/auth/frontend.ts (last modified in previous session)
and continue implementing the login component.
```

---

## Notes

- This skill should **read** previous sessions but **not modify** them
- Focus on the most recent 2-3 sessions for detailed analysis
- Older sessions can be scanned for high-level progress only
- If no previous sessions exist, this becomes a task initialization
- Always create the initial thinking document even if starting fresh
