# Claude Marathon（Claude Marathon）

> 管理跨越多个会话的史诗级任务。永不丢失上下文，自动跟踪进度，即使上下文压缩也能无缝延续工作。

[中文文档](./README_ZH.md) | [English](../README.md)

---

## 🎯 解决什么问题？

**挑战**：复杂的开发任务往往需要多个 Claude Code 会话才能完成。当上下文被压缩或需要暂停时，宝贵的进展和见解可能会丢失。

**解决方案**：Claude Marathon 自动跟踪你在多个会话中的工作，让你可以轻松从上次停止的地方继续。

---

## ✨ 核心功能

### 🔍 **任务回顾** - 完整恢复上下文
- `/marathon-review` - 分析所有历史会话，恢复完整上下文
- 自动查找当前项目的相关会话
- 生成全面的初始思考文档
- 清楚显示已完成、待处理和下一步工作

### 💾 **任务检查点** - 随时保存进度
- `/marathon-checkpoint` - 在长任务执行期间保存当前状态
- 记录成就、决策和后续步骤
- 为关键状态创建代码快照
- 与自动记录完美配合

### ✅ **任务结束** - 完成并归档
- `/marathon-end` - 全面的任务完成文档
- 汇总所有会话的经验
- 创建详细的统计摘要
- 归档交付物和成果

### 📝 **自动记录** - 不错过任何细节
- 自动记录文件修改
- 跟踪重要命令执行（git、npm、docker 等）
- 记录任务创建事件
- 实时保存到 `progress.md`

### 📁 **项目隔离** - 多项目友好
- 智能按工作目录过滤会话
- 不同项目拥有完全独立的会话历史
- 项目间无交叉污染
- 清晰提示："本项目的上次会话"

### 🏗️ **结构化工作空间** - 精心设计
每个会话创建：
```
workspace/session_YYYYMMDD_HHMMSS_xxxxx/
├── session.json              # 元数据（时间、目录、Git 信息）
├── 00-initial-thinking.md    # 任务回顾分析
├── progress.md               # 自动 + 手动进度跟踪
├── learnings.md              # 积累的技术见解
├── TASK_SUMMARY.md           # 最终任务文档（task-end 生成）
├── logs/                     # 调试输出
├── screenshots/              # 可视化制品
├── scripts/                  # 临时脚本
└── drafts/                   # 检查点和快照
```

---

## 🚀 快速开始

### 安装

**方法 1：通过 Git（推荐）**

```bash
# 克隆到 Claude 插件目录
cd ~/.claude/plugins
git clone https://github.com/b4yesc4t/claude-marathon marathon

# 在 ~/.claude/settings.json 中启用插件
{
  "enabledPlugins": {
    "marathon": true
  }
}

# 重启 Claude Code
```

**方法 2：手动安装**

1. 下载并解压到 `~/.claude/plugins/marathon/`
2. 设置权限：`chmod +x ~/.claude/plugins/marathon/hooks/*.sh`
3. 在 `~/.claude/settings.json` 中启用
4. 重启 Claude Code

详细安装说明请查看 [INSTALL.md](../INSTALL.md)

---

## 📖 使用指南

### 场景 1：开始新的长任务

```bash
cd ~/Projects/my-awesome-app

# Claude Code 会自动：
# ✅ 创建 workspace/session_YYYYMMDD_HHMMSS_xxxxx/
# ✅ 设置跟踪基础设施
# ✅ 将 workspace/ 添加到 .gitignore（如果是 git 仓库）

# 开始工作...
# 所有文件编辑和重要命令都会被自动记录
```

### 场景 2：继续现有任务

```bash
cd ~/Projects/my-awesome-app

# 从之前的会话恢复上下文
/marathon-review

# Claude 会：
# 1. 查找此项目的所有历史会话
# 2. 分析每个会话的进展
# 3. 生成全面的初始思考文档
# 4. 显示清晰的后续步骤

# 输出示例：
🔍 任务回顾完成

📊 任务统计
- 名称：实现 JWT 认证
- 会话：5 天内 3 个会话
- 完成度：约 75%

✅ 进度摘要
已完成：
- ✓ 带密码哈希的用户模型
- ✓ 登录端点
- ✓ Token 生成

进行中：
- ⏳ Token 刷新机制（50%）

待处理：
- ⚪ 集成测试
- ⚪ API 文档

🎯 后续步骤
1. 完成 Token 刷新端点
2. 添加边缘情况的错误处理
3. 编写集成测试

# 在完整上下文中继续工作！
```

### 场景 3：保存进度检查点

```bash
# 完成重要里程碑后
/marathon-checkpoint

# Claude 会：
# ✅ 总结自上次检查点以来的工作
# ✅ 更新 progress.md
# ✅ 记录技术决策和经验
# ✅ 注明后续步骤

# 输出示例：
✅ 任务检查点已保存

📍 当前进度
- 完成了 Token 刷新机制
- 添加了全面的错误处理
- 正在进行：集成测试

🔧 本次检查点的变更
- 修改了 3 个文件
- 添加了 RefreshToken 模型
- 实现了 /auth/refresh 端点

💡 关键决策
使用旋转刷新令牌（而非静态）
原因：更好的安全性，防止令牌盗用

🎯 下一步：为认证流程编写集成测试
```

### 场景 4：完成任务

```bash
# 任务完全完成时
/marathon-end

# Claude 会：
# 1. 从所有会话收集信息
# 2. 创建全面的 TASK_SUMMARY.md
# 3. 汇总所有经验
# 4. 归档交付物
# 5. 记录成果和统计数据

# 输出示例：
🎉 任务完成 - JWT 认证系统

📊 任务统计
- 持续时间：7 天（4 个会话）
- 修改文件：约 12 个文件
- 添加测试：23 个测试

✅ 成就
- ✓ 完整的 JWT 认证系统
- ✓ Token 刷新机制
- ✓ 全面的测试覆盖
- ✓ API 文档

💡 关键经验
- 旋转刷新令牌提高安全性
- bcrypt 足以用于密码哈希
- 集成测试发现了 3 个边缘情况

📦 交付物
- 生产就绪的认证 API
- 完整测试套件（单元 + 集成）
- API 文档

📁 完整文档
查看：workspace/session_20260221_143022/TASK_SUMMARY.md
```

---

## 🎮 命令参考

| 命令 | 用途 | 何时使用 |
|:-----|:-----|:---------|
| `/marathon-review` | 从历史会话恢复上下文 | 开始处理现有任务，休息后返回 |
| `/marathon-checkpoint` | 工作期间保存进度 | 完成里程碑后，切换焦点前 |
| `/marathon-end` | 完成并归档任务 | 任务完成或长期停止 |

**自动记录**（无需命令）：
- 文件修改 → 自动记录
- Git/npm/docker 命令 → 自动记录
- 任务创建 → 自动记录

---

## 🎯 使用场景

### 完美适用于：

✅ **长期功能开发**
- 多天实施项目
- 复杂重构任务
- 大规模迁移

✅ **学习和研究**
- 探索新技术
- 原型方案
- 技术调研

✅ **Bug 调查**
- 难以重现的 Bug
- 性能优化
- 安全审计

✅ **文档项目**
- 技术写作
- API 文档
- 架构设计文档

### 配合以下场景效果更佳：

- 🔄 上下文压缩场景
- 🎯 多个并行项目
- 📚 知识积累
- 🤝 团队交接
- 📊 进度跟踪

---

## ⚙️ 配置

### 自定义自动记录

编辑 `~/.claude/plugins/marathon/hooks/auto-log-progress.sh`：

```bash
# 示例：只记录 git 命令
if echo "$COMMAND" | grep -q '^git'; then
  echo "- [$TIMESTAMP] ⚡ Git: \`$COMMAND\`" >> "$WORKSPACE/progress.md"
fi
```

### 工作空间清理

```bash
# 删除 30 天前的会话
find workspace -type d -name "session_*" -mtime +30 -exec rm -rf {} +

# 查看工作空间磁盘使用
du -sh workspace/session_*
```

---

## 📊 示例工作流

```
第 1 天：开始任务
├─ 会话 1（2 小时）
│  ├─ 自动：创建工作空间
│  ├─ 工作：初始实现
│  ├─ /marathon-checkpoint（核心完成后）
│  └─ 结束：上下文压缩

第 3 天：继续任务
├─ 会话 2（1.5 小时）
│  ├─ /marathon-review（恢复上下文）
│  ├─ 工作：添加功能
│  ├─ /marathon-checkpoint（达到里程碑）
│  └─ 结束：用户休息

第 5 天：继续任务
├─ 会话 3（2 小时）
│  ├─ /marathon-review（快速回顾）
│  ├─ 工作：测试和完善
│  ├─ /marathon-checkpoint（测试通过）
│  └─ 结束：上下文压缩

第 7 天：完成任务
└─ 会话 4（1 小时）
   ├─ /marathon-review（最后冲刺）
   ├─ 工作：文档
   ├─ /marathon-end（完成！）
   └─ 结果：全面的任务归档
```

---

## 🔧 故障排除

### 问题：工作空间未自动创建

**检查**：
1. 插件是否在 `~/.claude/settings.json` 中启用？
2. Hook 脚本是否可执行？`ls -l ~/.claude/plugins/marathon/hooks/`
3. 重启 Claude Code

### 问题：自动记录不工作

**检查**：
1. `auto-log-progress.sh` 是否可执行？
2. `workspace/session_*` 目录是否存在？
3. PostToolUse hook 是否正确配置？

### 问题：任务回顾找不到历史会话

**可能原因**：
- jq 未安装（安装：`brew install jq`）
- 旧会话的 session.json 中缺少 `working_directory`
- 工作目录与之前会话不同

---

## 🤝 贡献

欢迎贡献！请查看 [CONTRIBUTING.md](../CONTRIBUTING.md)

### 开发设置

```bash
git clone https://github.com/b4yesc4t/claude-marathon
cd claude-marathon

# 链接到 Claude 插件（开发模式）
ln -s $(pwd) ~/.claude/plugins/marathon-dev

# 修改后重启 Claude Code 测试
```

---

## 📄 许可证

MIT 许可证 - 查看 [LICENSE](../LICENSE)

---

## 🙏 致谢

- 为 Claude Code 社区构建
- 受长期开发任务中的真实挑战启发
- 感谢所有贡献者和用户！

---

## 📬 支持

- 📖 文档：[完整文档](./docs/)
- 🐛 问题：[GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)
- 💬 讨论：[GitHub Discussions](https://github.com/b4yesc4t/claude-marathon/discussions)

---

**用 Claude Marathon 掌控你的长期任务！** 🚀
