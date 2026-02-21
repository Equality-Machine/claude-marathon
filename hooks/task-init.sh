#!/bin/bash

# 获取当前时间戳和会话 ID
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SESSION_ID="${CLAUDE_SESSION_ID:-unknown}"
WORKSPACE_DIR="workspace/session_${TIMESTAMP}_${SESSION_ID:0:8}"

# 创建工作空间目录
mkdir -p "$WORKSPACE_DIR"/{logs,screenshots,scripts,drafts}

# 确保 workspace 在 .gitignore 中
if [ -d ".git" ]; then
  if ! grep -q "^workspace/$" .gitignore 2>/dev/null; then
    echo "workspace/" >> .gitignore
    echo "✓ 已将 workspace/ 添加到 .gitignore" >&2
  fi
fi

# 创建会话元数据
cat > "$WORKSPACE_DIR/session.json" <<EOF
{
  "session_id": "$SESSION_ID",
  "start_time": "$(date -Iseconds)",
  "working_directory": "$(pwd)",
  "git_branch": "$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'N/A')",
  "git_commit": "$(git rev-parse --short HEAD 2>/dev/null || echo 'N/A')"
}
EOF

# 创建初始思考模板
cat > "$WORKSPACE_DIR/00-initial-thinking.md" <<'EOF'
# 会话初始状态分析

## 📋 当前现状
<!-- 当前项目/工作的状态 -->

## 🎯 任务状态
<!-- 正在进行的任务、已完成的任务、待办事项 -->

## ❓ 问题与阻碍
<!-- 当前遇到的问题、技术难点、需要解决的阻碍 -->

## 💡 思路与计划
<!-- 解决方案思路、下一步计划 -->

## 🔍 需要了解的内容
<!-- 需要查看的文件、需要理解的代码、需要调研的技术 -->

---
*生成时间: TIMESTAMP*
EOF

sed -i.bak "s/TIMESTAMP/$(date)/" "$WORKSPACE_DIR/00-initial-thinking.md" && rm -f "$WORKSPACE_DIR/00-initial-thinking.md.bak"

# 创建其他模板文件
cat > "$WORKSPACE_DIR/progress.md" <<'EOF'
# 会话进展记录

## 已完成
- [ ]

## 进行中
- [ ]

## 待处理
- [ ]

## 遇到的问题及解决方案
EOF

cat > "$WORKSPACE_DIR/learnings.md" <<'EOF'
# 经验沉淀

## 技术发现

## 最佳实践

## 避坑指南

## 可复用的代码/方案
EOF

# 创建 README
cat > "$WORKSPACE_DIR/README.md" <<EOF
# Session Workspace: $(date +"%Y-%m-%d %H:%M:%S")

## 目录结构
- \`00-initial-thinking.md\` - 初始状态分析
- \`progress.md\` - 进展跟踪
- \`learnings.md\` - 经验沉淀
- \`logs/\` - 日志文件
- \`screenshots/\` - 截图
- \`scripts/\` - 临时脚本
- \`drafts/\` - 草稿文件

## 会话信息
- Session ID: $SESSION_ID
- 工作目录: $(pwd)
- Git 分支: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'N/A')
EOF

# 查找当前工作目录的最近会话（排除刚创建的会话）
CURRENT_DIR="$(pwd)"
LAST_SESSION=""

# 检查 jq 是否可用
if command -v jq >/dev/null 2>&1; then
  # 遍历所有会话，找到同一工作目录的最新会话
  for session in $(ls -td workspace/session_* 2>/dev/null); do
    # 排除当前刚创建的会话
    if [ "$session" = "$WORKSPACE_DIR" ]; then
      continue
    fi

    # 检查 session.json 是否存在
    if [ -f "$session/session.json" ]; then
      # 提取工作目录，如果字段不存在则返回空字符串
      SESSION_WD=$(jq -r '.working_directory // empty' "$session/session.json" 2>/dev/null)

      # 如果工作目录匹配，记录并退出循环
      if [ "$SESSION_WD" = "$CURRENT_DIR" ]; then
        LAST_SESSION="$session"
        break
      fi
    fi
  done
else
  # jq 不可用时的降级处理：使用最新的会话（不过滤目录）
  LAST_SESSION=$(ls -td workspace/session_* 2>/dev/null | grep -v "$WORKSPACE_DIR" | head -1)
fi

# 输出结果（这会被 Claude 看到）
cat <<EOF
🎬 **新会话工作空间已创建**

📁 工作空间位置: \`$WORKSPACE_DIR\`
📍 工作目录: \`$CURRENT_DIR\`

请先完成初始状态分析：
1. 分析当前项目现状和任务状态
2. 识别存在的问题和阻碍
3. 制定初步思路和计划
4. 将分析结果记录到 \`$WORKSPACE_DIR/00-initial-thinking.md\`
EOF

if [ -n "$LAST_SESSION" ]; then
  echo ""
  echo "📌 **本项目的上次会话**: \`$LAST_SESSION\`"
  if [ -f "$LAST_SESSION/learnings.md" ]; then
    echo "提示：可以查看上次会话的经验沉淀以延续工作"
  fi
fi

echo ""
echo "💡 本次会话的所有临时文件（截图、日志、脚本等）都应保存在此工作空间中"
