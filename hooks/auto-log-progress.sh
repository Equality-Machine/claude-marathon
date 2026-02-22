#!/bin/bash

# Auto-Log Progress with Auto-Checkpoint
# 简单记录操作，达到阈值后自动批量总结

PLUGIN_DIR="$HOME/.claude/plugins/marathon"

# 获取最新的会话工作空间
WORKSPACE=$(ls -td workspace/session_* 2>/dev/null | head -1)
if [ -z "$WORKSPACE" ]; then
  exit 0  # 如果没有工作空间，直接退出
fi

# 从 stdin 读取工具调用信息
INPUT=$(cat)

# 提取工具名称和参数
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
SUBJECT=$(echo "$INPUT" | jq -r '.tool_input.subject // empty')

TIMESTAMP=$(date "+%H:%M")

# 配置文件
CONFIG_FILE="$PLUGIN_DIR/config.json"
TEMP_LOG="$WORKSPACE/.temp_operations.log"
COUNTER_FILE="$WORKSPACE/.tool_call_counter"

# 读取配置（默认值：20 次工具调用后自动总结）
THRESHOLD=20
if [ -f "$CONFIG_FILE" ]; then
  THRESHOLD=$(jq -r '.auto_checkpoint.tool_call_threshold // 20' "$CONFIG_FILE" 2>/dev/null)
fi

# 简单记录操作到临时日志
log_to_temp() {
  local operation="$1"
  echo "[$TIMESTAMP] $operation" >> "$TEMP_LOG"
}

# 处理不同工具的操作
case "$TOOL_NAME" in
  Edit|Write)
    if [ -n "$FILE_PATH" ]; then
      log_to_temp "Edit: $FILE_PATH"
    fi
    ;;

  Bash)
    if [ -n "$COMMAND" ]; then
      # 只记录重要命令
      if echo "$COMMAND" | grep -qE '^(git|npm|yarn|pnpm|docker|kubectl|cargo|go|python|make|brew)'; then
        SHORT_CMD=$(echo "$COMMAND" | head -c 80)
        [ ${#COMMAND} -gt 80 ] && SHORT_CMD="${SHORT_CMD}..."
        log_to_temp "Command: $SHORT_CMD"
      fi
    fi
    ;;

  TaskCreate)
    if [ -n "$SUBJECT" ]; then
      log_to_temp "Task: $SUBJECT"
    fi
    ;;
esac

# 更新计数器
COUNTER=0
if [ -f "$COUNTER_FILE" ]; then
  COUNTER=$(cat "$COUNTER_FILE")
fi
COUNTER=$((COUNTER + 1))
echo "$COUNTER" > "$COUNTER_FILE"

# 检查是否达到阈值，触发自动批量总结
if [ "$COUNTER" -ge "$THRESHOLD" ]; then
  # 重置计数器
  echo "0" > "$COUNTER_FILE"

  # 后台执行批量总结（避免阻塞）
  (
    "$PLUGIN_DIR/hooks/batch-summarize.sh" 2>&1 | while IFS= read -r line; do
      echo "[$TIMESTAMP] $line" >> "$WORKSPACE/logs/auto-checkpoint.log"
    done
  ) &
fi

exit 0
