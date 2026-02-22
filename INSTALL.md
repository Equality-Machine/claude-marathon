# Installation Guide

## Quick Install

### Method 1: Via Git (Recommended)

```bash
# Navigate to Claude plugins directory
cd ~/.claude/plugins

# Clone the plugin
git clone https://github.com/b4yesc4t/claude-marathon marathon

# Verify installation
cd marathon
./verify-installation.sh

# Enable the plugin
# Edit ~/.claude/settings.json and add:
{
  "enabledPlugins": {
    "marathon": true
  }
}

# Restart Claude Code
```

### Method 2: Manual Installation

1. **Download the Plugin**

   Download the latest release from GitHub or extract the plugin package to:
   ```
   ~/.claude/plugins/marathon/
   ```

2. **Set Permissions**

   ```bash
   chmod +x ~/.claude/plugins/marathon/hooks/*.sh
   ```

3. **Enable the Plugin**

   Edit `~/.claude/settings.json`:
   ```json
   {
     "enabledPlugins": {
       "marathon": true
     }
   }
   ```

4. **Restart Claude Code**

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
