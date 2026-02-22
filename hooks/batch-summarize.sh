#!/bin/bash

# Batch Summarize Script
# 批量总结临时操作日志，使用 Claude Haiku

WORKSPACE=$(ls -td workspace/session_* 2>/dev/null | head -1)

if [ -z "$WORKSPACE" ]; then
  echo "No active workspace found"
  exit 0
fi

TEMP_LOG="$WORKSPACE/.temp_operations.log"
PROGRESS_FILE="$WORKSPACE/progress.md"

# 检查是否有待总结的操作
if [ ! -f "$TEMP_LOG" ] || [ ! -s "$TEMP_LOG" ]; then
  exit 0  # 没有操作需要总结，静默退出
fi

# 读取临时日志
OPERATIONS=$(cat "$TEMP_LOG")
OPERATION_COUNT=$(wc -l < "$TEMP_LOG")

echo "📊 Summarizing $OPERATION_COUNT operations..." >&2

# 检查 Claude CLI
if ! command -v claude >/dev/null 2>&1; then
  # Claude CLI 不可用，直接追加原始日志
  cat "$TEMP_LOG" | sed 's/^/- /' >> "$PROGRESS_FILE"
  rm "$TEMP_LOG"
  exit 0
fi

# 构建批量总结提示
PROMPT="Task: Analyze these development operations and create concise progress summaries.

Operations log:
$OPERATIONS

Instructions:
1. Group related operations (e.g., multiple edits to the same module)
2. Identify the purpose (feature, fix, refactor, etc.)
3. Create 1-3 summary lines (max 70 chars each)
4. Use emojis: 🎯 feature, 🐛 fix, 🔧 refactor, ✨ enhance, 📝 edit, ⚡ command, 📋 task
5. Format: - [HH:MM] [Emoji] [What was accomplished]

Output ONLY the summary lines, nothing else:"

# 调用 Claude Haiku（使用 unset CLAUDECODE 避免嵌套检测）
SUMMARY=$(unset CLAUDECODE; claude --model haiku -p "$PROMPT" 2>/dev/null)

if [ -n "$SUMMARY" ]; then
  # 追加智能总结
  echo "" >> "$PROGRESS_FILE"
  echo "## 📊 Auto Summary ($(date '+%Y-%m-%d %H:%M'))" >> "$PROGRESS_FILE"
  echo "$SUMMARY" >> "$PROGRESS_FILE"
  echo "" >> "$PROGRESS_FILE"
  echo "✅ Summarized $OPERATION_COUNT operations" >&2
else
  # 总结失败，使用原始日志
  cat "$TEMP_LOG" | sed 's/^/- /' >> "$PROGRESS_FILE"
  echo "⚠️  Summarization failed, using raw logs" >&2
fi

# 清理临时日志
rm "$TEMP_LOG"

exit 0
