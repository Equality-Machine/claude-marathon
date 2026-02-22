---
name: marathon-config
description: Configure Marathon plugin settings (auto-checkpoint threshold, etc.)
---

# Marathon Configuration

Configure Marathon plugin settings interactively.

## Step 1: Read current configuration

Read the current config file:
```bash
cat ~/.claude/plugins/marathon/config.json
```

Display current settings to the user in a friendly format.

## Step 2: Ask user what they want to configure

Use AskUserQuestion to ask:
- What setting do you want to change?
  - Auto-checkpoint threshold (how many tool calls before auto-summary)
  - Enable/disable smart summarization
  - View current settings only

## Step 3: Update configuration based on user choice

### If changing auto-checkpoint threshold:

Ask for the new threshold value (recommended: 10-30).

Then update config.json:
```bash
jq '.auto_checkpoint.tool_call_threshold = NEW_VALUE' ~/.claude/plugins/marathon/config.json > /tmp/marathon-config.tmp && mv /tmp/marathon-config.tmp ~/.claude/plugins/marathon/config.json
```

### If toggling smart summarization:

Toggle the enabled flag:
```bash
jq '.smart_summarization.enabled = true/false' ~/.claude/plugins/marathon/config.json > /tmp/marathon-config.tmp && mv /tmp/marathon-config.tmp ~/.claude/plugins/marathon/config.json
```

## Step 4: Confirm changes

Show the updated configuration and confirm to the user.

## Example Usage

User says: `/marathon-config` or "configure marathon" or "change auto-checkpoint threshold"

---

**Quick Tips**:
- **Threshold 10-20**: More frequent summaries (good for fast-paced work)
- **Threshold 20-30**: Balanced (recommended for most workflows)
- **Threshold 30-50**: Less frequent summaries (good for focused deep work)
