---
name: marathon-milestone
description: Mark important milestones in your marathon task journey
---

# Marathon Milestone 🏁

Mark a significant milestone in your epic task journey. Unlike checkpoints (which are for routine progress saves), milestones celebrate major achievements.

## Step 1: Ask user about the milestone

Use AskUserQuestion to ask:
- What milestone have you reached?
- Brief description of what was accomplished

## Step 2: Record the milestone

Find the current workspace:
```bash
WORKSPACE=$(ls -td workspace/session_* 2>/dev/null | head -1)
```

Append milestone to progress.md with special formatting:
```bash
cat >> "$WORKSPACE/progress.md" <<EOF

## 🏁 MILESTONE: [Milestone Title] ($(date '+%Y-%m-%d %H:%M'))

**Achievement**: [What was accomplished]

**Impact**: [Why this is significant]

**Next Target**: [What's the next major goal]

---
EOF
```

## Step 3: Optional - Create milestone snapshot

Ask if user wants to create a snapshot of important files:
- If yes, copy key files to `$WORKSPACE/milestones/milestone_YYYYMMDD_HHMMSS/`

## Step 4: Celebrate! 🎉

Congratulate the user on reaching this milestone and summarize:
- What was achieved
- Current progress status
- Suggested next steps

---

## Example Milestones

- 🏁 "MVP Complete" - First working version of the feature
- 🏁 "All Tests Passing" - Achieved 100% test coverage
- 🏁 "Production Deployed" - Successfully launched to production
- 🏁 "Performance Goal Met" - Achieved 2x speed improvement
- 🏁 "Architecture Refactor Done" - Completed major refactoring

---

**Usage**: `/marathon-milestone` or "mark milestone" or "reached milestone"
