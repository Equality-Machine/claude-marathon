---
name: marathon-checkpoint
description: Save a checkpoint during long-running task execution. Records current progress, state, and next steps. Use after completing a significant milestone or before switching focus.
disable-model-invocation: false
---

# Task Checkpoint - Save Progress During Long Tasks

Save your progress at critical points during long-running task execution.

---

## Quick Overview

Since you started, you've:
- ✅ Completed: [Quick summary]
- 🔧 Modified: [Key files changed]
- 💡 Solved: [Problems resolved]
- 📝 Learned: [New discoveries]

---

## Step 1: Review Recent Work

Summarize what happened since the last checkpoint (or session start):

**Completed Work**:
- What features/functions were implemented?
- What bugs were fixed?
- What refactoring was done?

**Files Modified**:
- List key files that were changed
- Note important code additions/deletions

**Problems Solved**:
- What blockers were resolved?
- What technical challenges were overcome?

**New Learnings**:
- Technical discoveries
- Best practices identified
- Things to avoid (pitfalls)

---

## Step 2: Update Progress File

Find current session workspace and update `progress.md`:

```markdown
---

## [HH:MM] Task Checkpoint

### Completed Since Last Checkpoint
- ✅ [Achievement 1]
- ✅ [Achievement 2]
- ✅ [Achievement 3]

### Current State
- 🎯 Working on: [Current focus]
- 📍 Location: [File/module being modified]
- 🔄 Progress: [X% complete / description]

### Technical Details
- **Approach**: [How you're solving the problem]
- **Challenges**: [Any difficulties encountered]
- **Decisions**: [Important technical decisions made]

### Next Steps
1. [Immediate next action]
2. [Follow-up task]
3. [Future consideration]

### Notes
[Any important context for future sessions]

---
```

---

## Step 3: Update Learnings (if applicable)

If new technical insights were gained, append to `learnings.md`:

```markdown
## [Date HH:MM] Checkpoint Learning

### Discovery: [Title]
**Context**: [When did you discover this?]
**Finding**: [What did you learn?]
**Application**: [How can this be used?]

**Code Example** (if applicable):
\`\`\`language
// example code
\`\`\`

**References**: [Links or file locations]

---
```

---

## Step 4: Create Checkpoint Snapshot (Optional)

For critical checkpoints, save a snapshot:

Create `workspace/session_*/drafts/checkpoint_HHMMSS.md`:

```markdown
# Checkpoint Snapshot - [HH:MM:SS]

## State Summary
[Brief description of current state]

## Key Code Snapshot

### File: [important-file.ext]
\`\`\`
[Copy critical code sections that represent current state]
\`\`\`

### File: [another-file.ext]
\`\`\`
[Another important piece]
\`\`\`

## Configuration/Settings
[Any important configuration values]

## How to Resume
If this session ends here, next session should:
1. [Step 1]
2. [Step 2]

## Known Issues
- [Any bugs or problems left unresolved]

---
Checkpoint created: [timestamp]
```

---

## Step 5: Report to User

Present a concise summary:

```
✅ Task Checkpoint Saved

📍 Current Progress
- Completed: [X] tasks/features
- Working on: [Current focus]
- Next: [What's coming up]

🔧 Changes This Checkpoint
- Modified [N] files
- [Key achievement 1]
- [Key achievement 2]

💡 Key Insight
[Most important learning or decision]

📁 Checkpoint Location
workspace/session_YYYYMMDD_HHMMSS_xxxxx/

🎯 Next Session Can Resume From
[Clear instruction for continuation]

⏱️  Estimated Completion
~[X]% of task complete
```

---

## When to Use `/marathon-checkpoint`

**Ideal Times**:
- ✅ After completing a significant feature or milestone
- ✅ After solving a complex problem
- ✅ Before switching to a different part of the task
- ✅ When conversation has been going for 20-30 turns
- ✅ Before taking a break or ending the session
- ✅ After making important technical decisions
- ✅ When you've discovered something valuable

**User Triggers**:
- "Save progress"
- "Create a checkpoint"
- "Let's save where we are"
- "I need to pause soon"

---

## Checkpoint vs Task-End

**Use `/marathon-checkpoint`** when:
- ⏸️  Taking a break but task continues
- 🔄 Switching focus within the same task
- 📊 Marking a milestone
- 🎯 Want to capture current state

**Use `/marathon-end`** when:
- ✅ Task is fully complete
- 🛑 Stopping work on this task (for now)
- 📦 Ready to archive this task's work
- 📝 Need comprehensive summary

---

## Auto vs Manual Checkpoints

**Auto Checkpoint** (automatic, every N tool calls):
- 🤖 Triggers automatically after N tool calls (default: 20)
- 📊 Batch summarizes operations using Claude Haiku
- ⚡ Fast, lightweight, no interruption
- 📝 Appends smart summary to `progress.md`
- ⚙️ Configure threshold via `/marathon-config`

**Manual Checkpoint** (this command, `/marathon-checkpoint`):
- 👤 User-initiated at important moments
- 🎯 Deep analysis with context and insights
- 💡 Records learnings and technical decisions
- 📸 Can create code snapshots
- **More valuable for complex task continuity**

**When to use each**:
- Auto checkpoint: Runs in background, you don't need to think about it
- Manual checkpoint: Use after major achievements or before breaks

---

## Best Practices

1. **Regular Checkpoints**: Create checkpoints every 30-60 minutes of work
2. **Meaningful Messages**: Write clear descriptions of what was accomplished
3. **Technical Details**: Include enough detail to resume easily
4. **Decision Rationale**: Explain *why* you chose a particular approach
5. **Next Steps**: Always note what should happen next
6. **Snapshot Critical States**: For complex changes, create code snapshots

---

## Example Checkpoint Flow

```
# Working on authentication feature...
[30 minutes of work]

User or Claude: /marathon-checkpoint

📍 Checkpoint: JWT Authentication Implementation
✅ Completed:
   - Created User model with password hashing
   - Implemented login endpoint
   - Added JWT token generation
🔧 Modified:
   - src/models/user.ts
   - src/routes/auth.ts
   - src/utils/jwt.ts
💡 Decision: Using bcrypt for password hashing (vs argon2)
   Reason: Better library support and sufficient security
🎯 Next: Implement token refresh mechanism

Checkpoint saved to workspace/session_20260221_143022/
```

---

## Notes

- Checkpoints are **lightweight** - don't overthink it
- Focus on **actionable information** for future sessions
- **Complement** auto-recording with human context
- Checkpoints help Claude **resume intelligently** in next session
