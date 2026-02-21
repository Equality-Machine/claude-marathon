#!/bin/bash

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

# 只记录重要操作
case "$TOOL_NAME" in
  Edit|Write)
    if [ -n "$FILE_PATH" ]; then
      TIMESTAMP=$(date "+%H:%M:%S")
      echo "- [$TIMESTAMP] 📝 修改/创建文件: \`$FILE_PATH\`" >> "$WORKSPACE/progress.md"
    fi
    ;;
  Bash)
    # 记录重要的 bash 命令（git, npm, docker 等）
    if echo "$COMMAND" | grep -qE '^(git|npm|yarn|pnpm|docker|kubectl|cargo|go|python)'; then
      TIMESTAMP=$(date "+%H:%M:%S")
      SHORT_CMD=$(echo "$COMMAND" | head -c 60)
      [ ${#COMMAND} -gt 60 ] && SHORT_CMD="${SHORT_CMD}..."
      echo "- [$TIMESTAMP] ⚡ 执行命令: \`$SHORT_CMD\`" >> "$WORKSPACE/progress.md"
    fi
    ;;
  TaskCreate)
    SUBJECT=$(echo "$INPUT" | jq -r '.tool_input.subject // empty')
    if [ -n "$SUBJECT" ]; then
      TIMESTAMP=$(date "+%H:%M:%S")
      echo "- [$TIMESTAMP] 📋 创建任务: $SUBJECT" >> "$WORKSPACE/progress.md"
    fi
    ;;
esac

exit 0
