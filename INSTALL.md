# Installation Guide

## Quick Install

### Method 1: Via Marketplace (Recommended)

Claude Code uses a marketplace system for plugin distribution. This is the easiest and recommended way to install Marathon.

```bash
# In Claude Code, run:
/plugin marketplace add Equality-Machine/claude-marathon

# Then install the plugin:
/plugin install marathon@marathon

# Done! The plugin is now active. 🎉
```

### Method 2: Local Development Installation

For developers who want to modify the plugin or test local changes:

```bash
# Clone the repository
cd ~/.claude/plugins
git clone https://github.com/Equality-Machine/claude-marathon.git marathon

# Add as local marketplace
# In Claude Code, run:
/plugin marketplace add ~/.claude/plugins/marathon

# Install the plugin:
/plugin install marathon@marathon

# Restart Claude Code
```

### How Claude Code Plugin Installation Works

Claude Code uses a **marketplace system** instead of manual file copying:

1. **Marketplaces** are catalogs (like app stores) that list available plugins
2. **Adding a marketplace**: `/plugin marketplace add <github-repo>` or `/plugin marketplace add <local-path>`
3. **Installing plugins**: `/plugin install <plugin-name>@<marketplace-name>`
4. **Automatic updates**: Claude Code manages plugin versions and updates automatically

This approach provides:
- ✅ Centralized discovery
- ✅ Version tracking
- ✅ Automatic updates
- ✅ Dependency management

---

## Verify Installation

### Before Restarting (Structure Verification)

Run the verification script to check plugin structure:

```bash
cd ~/.claude/plugins/marathon
./verify-installation.sh
```

Expected output:
```
✅ Plugin structure verification complete!

📌 Next steps:
   1. Restart Claude Code
   2. Start a new session
   3. Check for Marathon initialization message
```

### After Restarting Claude Code

Start a new session and verify:

1. You should see:
   ```
   🎬 New task workspace created
   📁 Workspace location: workspace/session_YYYYMMDD_HHMMSS_xxxxx
   ```

2. Check the directory:
   ```bash
   ls workspace/
   ```

3. Test commands:
   ```bash
   /marathon-review
   /marathon-checkpoint
   /marathon-end
   ```

---

## Optional: Install jq (Recommended)

For best experience (project isolation), install jq:

```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq

# CentOS/RHEL
sudo yum install jq

# Arch Linux
sudo pacman -S jq
```

Verify installation:
```bash
jq --version
```

---

## Uninstall

```bash
# 1. Remove from settings.json
# Edit ~/.claude/settings.json and remove "marathon": true

# 2. Delete plugin directory
rm -rf ~/.claude/plugins/marathon

# 3. (Optional) Delete workspace data
# WARNING: This deletes all session history!
# rm -rf workspace/
```

---

## Troubleshooting

### Plugin doesn't start

1. **Run verification script first**:
   ```bash
   cd ~/.claude/plugins/marathon
   ./verify-installation.sh
   ```

2. **Check if plugin is enabled**:
   ```bash
   cat ~/.claude/settings.json | grep marathon
   ```

3. **Verify plugin structure**:
   ```bash
   ls -la ~/.claude/plugins/marathon/.claude-plugin/
   # Should show: plugin.json
   ```

4. **Check script permissions**:
   ```bash
   ls -l ~/.claude/plugins/marathon/hooks/
   ```

   Should show:
   ```
   -rwxr-xr-x  ... task-init.sh
   -rwxr-xr-x  ... auto-log-progress.sh
   ```

5. **Check Claude Code logs** for error messages

### Auto-recording not working

- Verify `auto-log-progress.sh` is executable
- Check PostToolUse Hook configuration
- Ensure `workspace/session_*` directory exists

### Task review can't find previous sessions

- Install jq: `brew install jq`
- Check `session.json` exists: `cat workspace/session_*/session.json`

---

## Update Plugin

```bash
cd ~/.claude/plugins/marathon
git pull origin main

# Restart Claude Code
```

---

## Need Help?

- 📖 Read [README.md](README.md)
- 🐛 Submit Issue: https://github.com/b4yesc4t/claude-marathon/issues
- 💬 Ask Questions: https://github.com/b4yesc4t/claude-marathon/discussions
