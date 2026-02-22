# 🏃‍♂️ Claude Marathon

> **AI-powered progress tracking for epic, multi-session tasks in Claude Code.**
> Never lose context. Auto-summarize with Claude Haiku. Continue seamlessly across sessions.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://code.claude.com)
[![Haiku Powered](https://img.shields.io/badge/AI-Claude_Haiku-orange)](https://anthropic.com)

[中文文档](./docs/README_ZH.md)

---

## ⚡ Quick Start

```bash
# Install
cd ~/.claude/plugins
git clone https://github.com/b4yesc4t/claude-marathon marathon

# Enable in ~/.claude/settings.json
{
  "enabledPlugins": {
    "marathon": true
  }
}

# Restart Claude Code - Done! 🎉
```

---

## 🎯 What is Marathon?

Marathon solves one problem: **Long tasks lose context when sessions end.**

### The Problem
When working on complex tasks that span multiple Claude Code sessions, you lose valuable context:
- What did I do last session?
- What was I about to implement?
- What decisions did I make and why?

### The Solution
Marathon **automatically tracks and intelligently summarizes** every operation using Claude Haiku:

**Before Marathon**:
```
Session 1: Edit 20 files for auth feature ✅
[Context compression happens]
Session 2: "What did I implement yesterday?" ❓
          Read through all 20 files manually... 😓
```

**With Marathon**:
```
Session 1: Edit 20 files ✅
          → Auto checkpoint triggers
          → Claude Haiku summarizes: "🎯 Implemented JWT auth system"
[Context compression happens]
Session 2: /marathon-review
          → "Last session: JWT auth 75% complete. Next: Add refresh tokens" ✅
          Resume immediately! 🚀
```

---

## 🤖 Three-Layer Auto-Tracking

| Layer | How | When | Cost |
|:------|:----|:-----|:-----|
| **🤖 Auto Checkpoint** | AI batch summary | Every 20 tool calls | <$0.10/mo |
| **👤 Manual Checkpoint** | `/marathon-checkpoint` | After milestones | Free |
| **🏁 Milestone** | `/marathon-milestone` | Major achievements | Free |

### Auto Checkpoint Example

```markdown
## 📊 Auto Summary (11:03)
- [11:02] 📝 Edit: test_manual.txt
- [11:03] 🔧 Refactor: auth module (login.js, token.js)
```

**Zero interruption. Background execution. Claude Haiku does the work.**

---

## 🎮 Commands

| Command | Purpose | When to Use |
|:--------|:--------|:------------|
| **Auto Checkpoint** | AI batch summary (automatic) | Every N tool calls (default: 20) |
| `/marathon-config` | Configure settings | Adjust auto-checkpoint threshold (10-50) |
| `/marathon-checkpoint` | Save detailed checkpoint | After completing major work, before breaks |
| `/marathon-milestone` | Mark achievement | MVP complete, deployment, major goal reached |
| `/marathon-review` | Restore context | Start of new session, resuming work |
| `/marathon-end` | Complete and archive | Task fully finished, create final summary |

**Note**: Auto checkpoint runs automatically in background - no command needed!

---

## 🏗️ How It Works

```
Day 1: You start task
├─ Marathon creates workspace/session_20260222_*/
├─ Auto-tracks every file edit, git command
└─ After 20 operations → AI summary ✅

Day 3: You continue
├─ /marathon-review → Loads all previous sessions
├─ Shows: What's done? What's next?
└─ You continue with full context ✅
```

**Workspace Structure**:
```
workspace/session_YYYYMMDD_HHMMSS/
├── progress.md          # Auto + manual tracking
├── learnings.md         # Technical insights
├── session.json         # Metadata
└── logs/                # Auto-checkpoint logs
```

---

## 💡 Example Workflow

```bash
# Working on JWT auth feature...

# (After 20 edits, auto checkpoint triggers)
## 📊 Auto Summary
- [14:10] 🎯 Implement JWT login + token generation
- [14:25] 🧪 Add integration tests

# After major milestone
/marathon-checkpoint
✅ Checkpoint: Login endpoint complete

# When MVP done
/marathon-milestone
🏁 Milestone: JWT Authentication MVP Complete!

# Next session
/marathon-review
🔍 Loaded 3 sessions, 75% complete
🎯 Next: Add token refresh mechanism
```

---

## ⚙️ Configuration

Adjust auto-checkpoint frequency:

```bash
/marathon-config
```

**Recommended thresholds**:
- `10-15` → Fast-paced work
- `20-30` → Balanced (default)
- `30-50` → Deep work

---

## 📊 Why Marathon?

✅ **Auto-tracking** - Set it and forget it
✅ **AI-powered** - Claude Haiku intelligently summarizes
✅ **Cost-effective** - <$0.10/month
✅ **Zero interruption** - Background execution
✅ **Multi-project** - Directory-aware session filtering
✅ **Seamless continuity** - Resume exactly where you left off

---

## 🎯 Perfect For

- Multi-day feature implementations
- Bug investigations spanning sessions
- Research and learning projects
- Team handoffs and context sharing
- Any task longer than one session

---

## 📖 Documentation

- **Full Guide**: [INSTALL.md](./INSTALL.md)
- **中文文档**: [README_ZH.md](./docs/README_ZH.md)
- **Issues**: [GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)

---

## 🤝 Contributing

PRs welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md)

---

## 📄 License

MIT License - see [LICENSE](./LICENSE)

---

## 🙏 Inspired By

- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

---

**Run your marathon with confidence!** 🏃‍♂️💨
