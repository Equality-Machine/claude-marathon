# Claude Marathon

> Manage epic tasks that span multiple sessions. Never lose context, automatically track progress, and seamlessly continue work even after context compression.

[中文文档](./docs/README_ZH.md) | [English](./README.md)

---

## 🎯 What Problem Does This Solve?

**The Challenge**: Complex development tasks often take longer than a single Claude Code session. When context gets compressed or you need to pause, valuable progress and insights can be lost.

**The Solution**: Claude Marathon automatically tracks your work across multiple sessions, making it easy to pick up exactly where you left off.

---

## ✨ Key Features

###🔍 **Task Review** - Resume with Full Context
- `/marathon-review` - Analyze all previous sessions, restore complete context
- Automatically finds related sessions for current project
- Generates comprehensive initial thinking document
- Shows what's done, what's pending, and what's next

### 💾 **Task Checkpoint** - Save Progress Anytime
- `/marathon-checkpoint` - Save current state during long tasks
- Records achievements, decisions, and next steps
- Creates code snapshots for critical states
- Works perfectly with auto-recording

### ✅ **Task End** - Complete and Archive
- `/marathon-end` - Comprehensive task completion documentation
- Consolidates learnings from all sessions
- Creates detailed summary with statistics
- Archives deliverables and outcomes

### 📝 **Auto-Recording** - Never Miss a Detail
- Automatically logs file modifications
- Tracks important command executions (git, npm, docker, etc.)
- Records task creation events
- All saved to `progress.md` in real-time

### 📁 **Project Isolation** - Multi-Project Friendly
- Intelligently filters sessions by working directory
- Different projects have completely separate session histories
- No cross-contamination between tasks
- Clear indication: "Previous session for THIS project"

### 🏗️ **Structured Workspace** - Organized by Design
Each session creates:
```
workspace/session_YYYYMMDD_HHMMSS_xxxxx/
├── session.json              # Metadata (time, directory, git info)
├── 00-initial-thinking.md    # Task review analysis
├── progress.md               # Auto + manual progress tracking
├── learnings.md              # Technical insights accumulated
├── TASK_SUMMARY.md           # Final task documentation (task-end)
├── logs/                     # Debug outputs
├── screenshots/              # Visual artifacts
├── scripts/                  # Temporary scripts
└── drafts/                   # Checkpoints and snapshots
```

---

## 🚀 Quick Start

### Installation

**Method 1: Via Git (Recommended)**

```bash
# Clone to Claude plugins directory
cd ~/.claude/plugins
git clone https://github.com/b4yesc4t/claude-marathon marathon

# Enable plugin in ~/.claude/settings.json
{
  "enabledPlugins": {
    "marathon": true
  }
}

# Restart Claude Code
```

**Method 2: Manual Install**

1. Download and extract to `~/.claude/plugins/marathon/`
2. Set permissions: `chmod +x ~/.claude/plugins/marathon/hooks/*.sh`
3. Enable in `~/.claude/settings.json`
4. Restart Claude Code

For detailed installation instructions, see [INSTALL.md](./INSTALL.md)

---

## 📖 Usage Guide

### Scenario 1: Starting a New Long Task

```bash
cd ~/Projects/my-awesome-app

# Claude Code will automatically:
# ✅ Create workspace/session_YYYYMMDD_HHMMSS_xxxxx/
# ✅ Set up tracking infrastructure
# ✅ Add workspace/ to .gitignore (if git repo)

# Start working...
# All file edits and important commands are auto-recorded
```

### Scenario 2: Continuing an Existing Task

```bash
cd ~/Projects/my-awesome-app

# Restore context from previous sessions
/marathon-review

# Claude will:
# 1. Find all previous sessions for this project
# 2. Analyze progress from each session
# 3. Generate comprehensive initial thinking document
# 4. Show clear next steps

# Output example:
🔍 Task Review Complete

📊 Task Statistics
- Name: Implement JWT Authentication
- Sessions: 3 sessions over 5 days
- Completion: ~75%

✅ Progress Summary
Completed:
- ✓ User model with password hashing
- ✓ Login endpoint
- ✓ Token generation

In Progress:
- ⏳ Token refresh mechanism (50%)

Pending:
- ⚪ Integration tests
- ⚪ API documentation

🎯 Next Steps
1. Complete token refresh endpoint
2. Add error handling for edge cases
3. Write integration tests

# Continue working with full context!
```

### Scenario 3: Saving Progress Checkpoints

```bash
# After completing a significant milestone
/marathon-checkpoint

# Claude will:
# ✅ Summarize work since last checkpoint
# ✅ Update progress.md
# ✅ Record technical decisions and learnings
# ✅ Note next steps

# Output example:
✅ Task Checkpoint Saved

📍 Current Progress
- Completed token refresh mechanism
- Added comprehensive error handling
- Working on: Integration tests

🔧 Changes This Checkpoint
- Modified 3 files
- Added RefreshToken model
- Implemented /auth/refresh endpoint

💡 Key Decision
Using rotating refresh tokens (vs static)
Reason: Better security, prevents token theft

🎯 Next: Write integration tests for auth flow
```

### Scenario 4: Completing a Task

```bash
# When task is fully complete
/marathon-end

# Claude will:
# 1. Gather information from ALL sessions
# 2. Create comprehensive TASK_SUMMARY.md
# 3. Consolidate all learnings
# 4. Archive deliverables
# 5. Document outcomes and statistics

# Output example:
🎉 Task Complete - JWT Authentication System

📊 Task Statistics
- Duration: 7 days (4 sessions)
- Files Modified: ~12 files
- Tests Added: 23 tests

✅ Accomplishments
- ✓ Complete JWT authentication system
- ✓ Token refresh mechanism
- ✓ Comprehensive test coverage
- ✓ API documentation

💡 Key Learnings
- Rotating refresh tokens improve security
- bcrypt is sufficient for password hashing
- Integration tests caught 3 edge cases

📦 Deliverables
- Production-ready authentication API
- Full test suite (unit + integration)
- API documentation

📁 Full Documentation
See: workspace/session_20260221_143022/TASK_SUMMARY.md
```

---

## 🎮 Command Reference

| Command | Purpose | When to Use |
|:--------|:--------|:------------|
| `/marathon-review` | Restore context from previous sessions | Starting work on existing task, after break |
| `/marathon-checkpoint` | Save progress during work | After milestone, before switching focus |
| `/marathon-end` | Complete and archive task | Task finished or stopping for long time |

**Auto-Recording** (no command needed):
- File modifications → Logged automatically
- Git/npm/docker commands → Logged automatically
- Task creation → Logged automatically

---

## 🎯 Use Cases

### Perfect For:

✅ **Long-Running Features**
- Multi-day implementation projects
- Complex refactoring tasks
- Large-scale migrations

✅ **Learning & Research**
- Exploring new technologies
- Prototyping solutions
- Technical investigations

✅ **Bug Investigation**
- Hard-to-reproduce bugs
- Performance optimization
- Security audits

✅ **Documentation Projects**
- Technical writing
- API documentation
- Architecture design docs

### Works Great With:

- 🔄 Context compression scenarios
- 🎯 Multiple parallel projects
- 📚 Knowledge accumulation
- 🤝 Team handoffs
- 📊 Progress tracking

---

## ⚙️ Configuration

### Customize Auto-Recording

Edit `~/.claude/plugins/marathon/hooks/auto-log-progress.sh`:

```bash
# Example: Only log git commands
if echo "$COMMAND" | grep -q '^git'; then
  echo "- [$TIMESTAMP] ⚡ Git: \`$COMMAND\`" >> "$WORKSPACE/progress.md"
fi
```

### Workspace Cleanup

```bash
# Delete sessions older than 30 days
find workspace -type d -name "session_*" -mtime +30 -exec rm -rf {} +

# View workspace disk usage
du -sh workspace/session_*
```

---

## 📊 Example Workflow

```
Day 1: Start Task
├─ Session 1 (2 hours)
│  ├─ Auto: workspace created
│  ├─ Work: Initial implementation
│  ├─ /marathon-checkpoint (after core done)
│  └─ End: Context compressed

Day 3: Continue Task
├─ Session 2 (1.5 hours)
│  ├─ /marathon-review (restore context)
│  ├─ Work: Add features
│  ├─ /marathon-checkpoint (milestone reached)
│  └─ End: User break

Day 5: Continue Task
├─ Session 3 (2 hours)
│  ├─ /marathon-review (quick recap)
│  ├─ Work: Testing & polish
│  ├─ /marathon-checkpoint (tests passing)
│  └─ End: Context compressed

Day 7: Finish Task
└─ Session 4 (1 hour)
   ├─ /marathon-review (final push)
   ├─ Work: Documentation
   ├─ /marathon-end (COMPLETE!)
   └─ Result: Comprehensive task archive
```

---

## 🔧 Troubleshooting

### Issue: Workspace not created automatically

**Check**:
1. Plugin enabled in `~/.claude/settings.json`?
2. Hook scripts executable? `ls -l ~/.claude/plugins/marathon/hooks/`
3. Restart Claude Code

### Issue: Auto-recording not working

**Check**:
1. `auto-log-progress.sh` executable?
2. `workspace/session_*` directory exists?
3. PostToolUse hook configured correctly?

### Issue: Task review can't find previous sessions

**Possible causes**:
- jq not installed (install: `brew install jq`)
- Old sessions lack `working_directory` in session.json
- Working in different directory than previous sessions

---

## 🤝 Contributing

Contributions welcome! Please see [CONTRIBUTING.md](./CONTRIBUTING.md)

### Development Setup

```bash
git clone https://github.com/b4yesc4t/claude-marathon
cd claude-marathon

# Link to Claude plugins (dev mode)
ln -s $(pwd) ~/.claude/plugins/marathon-dev

# Make changes and restart Claude Code to test
```

---

## 📄 License

MIT License - see [LICENSE](./LICENSE)

---

## 🙏 Acknowledgments

- Built for the Claude Code community
- Inspired by real challenges in long-running development tasks
- Thanks to all contributors and users!

---

## 📬 Support

- 📖 Documentation: [Full docs](./docs/)
- 🐛 Issues: [GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/b4yesc4t/claude-marathon/discussions)

---

**Master your long-running tasks with Claude Marathon!** 🚀
