# Claude Marathon 🏃‍♂️

> **Run the marathon of epic tasks with Claude.** Never lose context, automatically track progress with AI-powered summaries, and seamlessly continue work across sessions—even after context compression.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://code.claude.com)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

[中文文档](./docs/README_ZH.md) | [English](./README.md)

---

## 🎯 Why Marathon?

**The Challenge**: Complex tasks often exceed a single Claude Code session. When context gets compressed or you pause work, valuable progress and insights can vanish.

**The Solution**: Marathon automatically tracks every operation with **AI-powered smart summaries**, making it trivial to pick up exactly where you left off—hours, days, or even weeks later.

---

## ✨ Features

### 🤖 Auto Checkpoint - Set It and Forget It
- **Automatic batch summarization** every N tool calls (default: 20)
- Uses **Claude Haiku** to intelligently group and summarize operations
- Zero interruption—runs in background after threshold
- **Configurable** via `/marathon-config`

Example output:
```markdown
## 📊 Auto Summary (2026-02-22 11:03)
- [11:02] 📝 Edit: test_manual.txt
- [11:03] 🔧 Refactor: auth module (login.js, token.js)
```

### 👤 Manual Checkpoint - Deep Context Saves
- **`/marathon-checkpoint`** - Save detailed checkpoint with context
- Records achievements, technical decisions, and learnings
- Creates code snapshots for critical states
- Perfect for major milestones or before breaks

### 🏁 Milestones - Celebrate Achievements
- **`/marathon-milestone`** - Mark major accomplishments
- Designate MVP completion, production deployment, or performance goals
- Create milestone snapshots with impact notes
- Build a record of significant progress

### ⚙️ Dynamic Configuration
- **`/marathon-config`** - Adjust settings without editing files
- Change auto-checkpoint threshold (10-50 tool calls)
- Toggle smart summarization
- View current configuration

### 🔍 Session Review - Resume with Full Context
- **`/marathon-review`** - Analyze all previous sessions
- Automatically finds sessions for current project (directory-aware)
- Generates comprehensive initial thinking document
- Shows what's done, in-progress, and next steps

### ✅ Task Completion - Archive and Document
- **`/marathon-end`** - Comprehensive task summary
- Consolidates learnings from all sessions
- Creates detailed documentation with statistics
- Archives deliverables and outcomes

### 📁 Project Isolation - Multi-Project Friendly
- Intelligently filters sessions by **working directory**
- Separate session histories per project
- No cross-contamination between tasks
- Clear indication: "Previous session for THIS project"

### 🏗️ Structured Workspace - Organized by Design
Each session auto-creates:
```
workspace/session_YYYYMMDD_HHMMSS_xxxxx/
├── session.json                 # Metadata (time, directory, git)
├── 00-initial-thinking.md       # Task review analysis
├── progress.md                  # Auto + manual tracking
├── learnings.md                 # Technical insights
├── .temp_operations.log         # Operations buffer
├── .tool_call_counter           # Auto-checkpoint counter
├── logs/
│   └── auto-checkpoint.log     # Summarization logs
├── screenshots/                 # Visual artifacts
├── scripts/                     # Temporary scripts
├── drafts/                      # Checkpoints & snapshots
└── milestones/                  # Milestone snapshots
```

---

## 🚀 Quick Start

### Installation

**Option 1: Direct Install (Recommended)**
```bash
cd ~/.claude/plugins
git clone https://github.com/b4yesc4t/claude-marathon marathon
```

**Option 2: Manual Download**
1. Download and extract to `~/.claude/plugins/marathon/`
2. Set permissions: `chmod +x ~/.claude/plugins/marathon/hooks/*.sh`

**Enable the Plugin**

Add to `~/.claude/settings.json`:
```json
{
  "enabledPlugins": {
    "marathon": true
  }
}
```

**Restart Claude Code** and you're ready! 🎉

> For detailed installation, see [INSTALL.md](./INSTALL.md)

---

## 📖 Usage

### Three-Layer Progress Tracking

| Type | Trigger | Purpose | Output |
|:-----|:--------|:--------|:-------|
| **🤖 Auto Checkpoint** | Every N calls | Background batch summary | Smart AI-generated summary |
| **👤 Manual Checkpoint** | `/marathon-checkpoint` | Deep context save | Detailed progress report |
| **🏁 Milestone** | `/marathon-milestone` | Mark achievements | Celebration + impact notes |

### Typical Workflow

```bash
# Day 1: Start new feature
cd ~/Projects/my-app
# Marathon auto-creates workspace, starts tracking

# Work on feature...
# Auto checkpoint triggers every 20 tool calls

# After 2 hours of work
/marathon-checkpoint
# ✅ Detailed checkpoint saved

# Day 3: Continue
/marathon-review
# 🔍 Loads all previous context

# Keep working...
# Auto checkpoints continue in background

# Major milestone reached
/marathon-milestone
# 🏁 MVP Complete!

# Day 7: Finish
/marathon-end
# 🎉 Task complete with full documentation
```

---

## 🎮 Commands

| Command | Description | When to Use |
|:--------|:------------|:------------|
| **`/marathon-config`** | Configure auto-checkpoint threshold | First time or to adjust frequency |
| **`/marathon-checkpoint`** | Save detailed manual checkpoint | After milestones, before breaks |
| **`/marathon-milestone`** | Mark major achievement | MVP, deployment, performance goal |
| **`/marathon-review`** | Restore context from past sessions | Starting work, after break |
| **`/marathon-end`** | Complete and archive task | Task finished |

**Auto Checkpoint** runs automatically—no command needed!

---

## 💡 Example: Auto Checkpoint in Action

```bash
# You're working on authentication...
# (Edit 1) src/auth/login.ts
# (Edit 2) src/auth/token.ts
# ...
# (Edit 20) tests/auth.test.ts

# 🎯 Auto checkpoint triggers!
# Marathon batches last 20 operations, sends to Claude Haiku:

## 📊 Auto Summary (2026-02-22 14:35)
- [14:10-14:20] 🎯 Implement JWT authentication - Login + token generation
- [14:25] 🧪 Add auth integration tests - Cover edge cases
- [14:30] 🔧 Refactor token utils - Extract common functions
```

**Zero interruption. Zero cost (< $0.10/month). Maximum continuity.**

---

## ⚙️ Configuration

### Adjust Auto-Checkpoint Threshold

```bash
/marathon-config
```

Interactive prompt:
- **10-15**: Fast-paced work, frequent summaries
- **20-30**: Balanced (recommended)
- **30-50**: Deep work, less frequent summaries

### Default Settings

```json
{
  "auto_checkpoint": {
    "enabled": true,
    "tool_call_threshold": 20
  },
  "smart_summarization": {
    "enabled": true,
    "use_haiku": true
  }
}
```

---

## 🎯 Use Cases

Perfect for:

✅ **Long-Running Features** - Multi-day implementations, refactorings, migrations
✅ **Research & Learning** - Exploring technologies, prototyping, investigations
✅ **Bug Hunts** - Hard-to-reproduce bugs, performance tuning, security audits
✅ **Documentation** - Technical writing, API docs, architecture design

Works great with:

- 🔄 Context compression scenarios
- 🎯 Multiple parallel projects
- 📚 Knowledge accumulation over time
- 🤝 Team handoffs
- 📊 Long-term progress tracking

---

## 📊 Cost & Performance

### Auto Checkpoint Performance
- **Recording**: Instant (no delay)
- **Summarization**: Background (zero interruption)
- **User experience**: Seamless

### Cost Estimation (Claude Haiku)
- Per summary: ~$0.0001
- 20 summaries/day: ~$0.002/day
- **Monthly: < $0.10** 💸

Extremely cheap for massive value!

---

## 🔧 Troubleshooting

### Workspace not created?
1. Check plugin enabled in `~/.claude/settings.json`
2. Verify hook scripts executable: `ls -l ~/.claude/plugins/marathon/hooks/`
3. Restart Claude Code

### Auto-recording not working?
1. Ensure `auto-log-progress.sh` is executable
2. Confirm `workspace/session_*` exists
3. Check PostToolUse hook in `hooks/hooks.json`

### Can't find previous sessions?
- Install `jq`: `brew install jq`
- Old sessions may lack `working_directory` in `session.json`
- Ensure working in same directory as previous sessions

---

## 🤝 Contributing

Contributions welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md)

**Development Setup**:
```bash
git clone https://github.com/b4yesc4t/claude-marathon
cd claude-marathon

# Link for dev testing
ln -s $(pwd) ~/.claude/plugins/marathon-dev
```

---

## 📄 License

MIT License - see [LICENSE](./LICENSE)

---

## 🙏 Acknowledgments

Built for the Claude Code community. Inspired by real challenges in long-running development.

Special thanks to:
- [Anthropic](https://anthropic.com) for Claude Code
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) community
- All contributors and users

---

## 📬 Support

- 📖 **Documentation**: [Full docs](./docs/)
- 🐛 **Issues**: [GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/b4yesc4t/claude-marathon/discussions)

---

**Run your marathon with confidence!** 🏃‍♂️💨

**Related Projects**:
- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
