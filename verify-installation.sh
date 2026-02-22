#!/bin/bash
# Marathon Plugin Installation Verification Script

set -e

echo "🔍 Claude Marathon Plugin Verification"
echo "======================================"
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check 1: .claude-plugin directory exists
echo -n "✓ Checking .claude-plugin directory... "
if [ -d ".claude-plugin" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
    echo "  Error: .claude-plugin directory not found"
    exit 1
fi

# Check 2: plugin.json exists in .claude-plugin
echo -n "✓ Checking plugin.json location... "
if [ -f ".claude-plugin/plugin.json" ]; then
    echo -e "${GREEN}OK${NC}"
else
    echo -e "${RED}FAILED${NC}"
    echo "  Error: plugin.json not found in .claude-plugin/"
    exit 1
fi

# Check 3: plugin.json is valid JSON
echo -n "✓ Validating plugin.json format... "
if jq empty .claude-plugin/plugin.json 2>/dev/null; then
    echo -e "${GREEN}OK${NC}"
else
    if ! command -v jq &> /dev/null; then
        echo -e "${YELLOW}SKIPPED (jq not installed)${NC}"
    else
        echo -e "${RED}FAILED${NC}"
        echo "  Error: plugin.json is not valid JSON"
        exit 1
    fi
fi

# Check 4: Required fields in plugin.json
echo -n "✓ Checking required plugin.json fields... "
PLUGIN_NAME=$(grep -o '"name"[[:space:]]*:[[:space:]]*"[^"]*"' .claude-plugin/plugin.json | cut -d'"' -f4)
PLUGIN_VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' .claude-plugin/plugin.json | cut -d'"' -f4)

if [ -n "$PLUGIN_NAME" ] && [ -n "$PLUGIN_VERSION" ]; then
    echo -e "${GREEN}OK${NC}"
    echo "  Name: $PLUGIN_NAME"
    echo "  Version: $PLUGIN_VERSION"
else
    echo -e "${RED}FAILED${NC}"
    echo "  Error: Missing required fields (name or version)"
    exit 1
fi

# Check 5: Hook files exist and are executable
echo -n "✓ Checking hook files... "
HOOK_COUNT=0
if [ -d "hooks" ]; then
    for hook in hooks/*.sh; do
        if [ -f "$hook" ]; then
            HOOK_COUNT=$((HOOK_COUNT + 1))
            if [ ! -x "$hook" ]; then
                echo -e "${YELLOW}WARNING${NC}"
                echo "  File $hook is not executable"
                echo "  Run: chmod +x $hook"
            fi
        fi
    done
    echo -e "${GREEN}OK${NC} (found $HOOK_COUNT hook files)"
else
    echo -e "${YELLOW}WARNING${NC} (no hooks directory)"
fi

# Check 6: Skills directory
echo -n "✓ Checking skills directory... "
if [ -d "skills" ]; then
    SKILL_COUNT=$(ls -1 skills | wc -l | tr -d ' ')
    echo -e "${GREEN}OK${NC} (found $SKILL_COUNT skills)"
else
    echo -e "${YELLOW}WARNING${NC} (no skills directory)"
fi

# Check 7: Settings.json
echo -n "✓ Checking Claude settings.json... "
SETTINGS_FILE="$HOME/.claude/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
    if grep -q "\"marathon\"" "$SETTINGS_FILE"; then
        echo -e "${GREEN}OK${NC} (plugin enabled)"
    else
        echo -e "${YELLOW}WARNING${NC}"
        echo "  Plugin not enabled in settings.json"
        echo "  Add \"marathon\": true to enabledPlugins"
    fi
else
    echo -e "${YELLOW}WARNING${NC}"
    echo "  Settings file not found: $SETTINGS_FILE"
fi

echo ""
echo "======================================"
echo -e "${GREEN}✅ Plugin structure verification complete!${NC}"
echo ""
echo "📌 Next steps:"
echo "   1. Restart Claude Code"
echo "   2. Start a new session"
echo "   3. Check for Marathon initialization message"
echo ""
