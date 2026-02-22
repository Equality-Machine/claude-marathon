# 🏃‍♂️ Claude Marathon

> **AI 驱动的进度跟踪，助力 Claude Code 中的史诗级多会话任务。**
> 永不丢失上下文。使用 Claude Haiku 自动总结。跨会话无缝延续。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://code.claude.com)
[![Haiku Powered](https://img.shields.io/badge/AI-Claude_Haiku-orange)](https://anthropic.com)

[English](../README.md) | [中文文档](./README_ZH.md)

---

## ⚡ 快速开始

```bash
# 安装
cd ~/.claude/plugins
git clone https://github.com/b4yesc4t/claude-marathon marathon

# 在 ~/.claude/settings.json 中启用
{
  "enabledPlugins": {
    "marathon": true
  }
}

# 重启 Claude Code - 完成！🎉
```

---

## 🎯 Marathon 是什么？

Marathon 解决一个核心问题：**长任务在会话结束时丢失上下文。**

### 痛点
当你在跨越多个 Claude Code 会话的复杂任务上工作时，你会丢失宝贵的上下文：
- 上次我做了什么？
- 我准备实现什么功能？
- 我做了哪些技术决策，为什么？

### 解决方案
Marathon **自动跟踪并智能总结**每个操作，使用 Claude Haiku：

**没有 Marathon**:
```
会话 1: 为认证功能编辑了 20 个文件 ✅
[上下文压缩发生]
会话 2: "我昨天实现了什么？" ❓
        手动阅读所有 20 个文件... 😓
```

**有了 Marathon**:
```
会话 1: 编辑 20 个文件 ✅
        → 自动检查点触发
        → Claude Haiku 总结："🎯 实现了 JWT 认证系统"
[上下文压缩发生]
会话 2: /marathon-review
        → "上次会话：JWT 认证完成 75%。下一步：添加刷新令牌" ✅
        立即恢复工作！🚀
```

---

## 🎮 完整工作流

Marathon 提供完整的任务生命周期管理：

```
会话开始
  ↓
📖 /marathon-review        ← 从之前会话恢复上下文
  ↓
⚙️ /marathon-config        ← （可选）配置自动检查点阈值
  ↓
💻 处理你的任务...
  ├─ 🤖 自动检查点    ← 后台：每 20 次操作 AI 自动总结
  ├─ 💾 /marathon-checkpoint  ← 手动：在关键时刻保存详细进度
  └─ 🏁 /marathon-milestone   ← 手动：标记重大成就
  ↓
✅ /marathon-end           ← 任务完成时归档总结
```

### 🤖 自动检查点（自动运行）

**在后台自动运行 - 无需命令！**

- **功能**：使用 Claude Haiku 批量总结最近的操作
- **时机**：每 N 次工具调用（默认：20，可配置）
- **成本**：< $0.10/月
- **示例**：
  ```markdown
  ## 📊 自动总结 (11:03)
  - [11:02] 📝 编辑: test_manual.txt
  - [11:03] 🔧 重构: 认证模块 (login.js, token.js)
  ```

---

## 📋 所有命令

### 会话生命周期

| 命令 | 用途 | 何时使用 | 类型 |
|:-----|:-----|:---------|:-----|
| **`/marathon-review`** | 从之前会话恢复上下文 | **会话开始** - 加载过往工作 | 手动 |
| **`/marathon-config`** | 配置自动检查点阈值 | 任何时候 - 调整频率（10-50 次调用）| 手动 |
| **自动检查点** | 通过 Claude Haiku 进行 AI 批量总结 | **工作中** - 每 N 次操作 | 自动 |
| **`/marathon-checkpoint`** | 保存详细进度报告 | **工作中** - 关键里程碑后 | 手动 |
| **`/marathon-milestone`** | 标记重大成就 | **工作中** - 庆祝重要胜利 | 手动 |
| **`/marathon-end`** | 完成并归档任务 | **会话结束** - 最终总结和归档 | 手动 |

### 关键区别

**自动 vs 手动**:
- **自动检查点**：后台 AI 总结，每 N 次操作自动运行
- **手动检查点**（`/marathon-checkpoint`）：包含你的分析的详细进度保存
- **里程碑**（`/marathon-milestone`）：重大成就的庆祝标记

---

## 🏗️ 工作原理

```
第 1 天：开始任务
├─ Marathon 创建 workspace/session_20260222_*/
├─ 自动跟踪每次文件编辑、git 命令
└─ 20 次操作后 → AI 总结 ✅

第 3 天：继续工作
├─ /marathon-review → 加载所有历史会话
├─ 显示：已完成什么？下一步是什么？
└─ 带着完整上下文继续工作 ✅
```

**工作空间结构**:
```
workspace/session_YYYYMMDD_HHMMSS/
├── progress.md          # 自动 + 手动跟踪
├── learnings.md         # 技术见解
├── session.json         # 元数据
└── logs/                # 自动检查点日志
```

---

## 💡 示例工作流

```bash
# 正在开发 JWT 认证功能...

# (20 次编辑后，自动检查点触发)
## 📊 自动总结
- [14:10] 🎯 实现 JWT 登录 + 令牌生成
- [14:25] 🧪 添加集成测试

# 重要里程碑后
/marathon-checkpoint
✅ 检查点：登录端点完成

# MVP 完成时
/marathon-milestone
🏁 里程碑：JWT 认证 MVP 完成！

# 下次会话
/marathon-review
🔍 加载了 3 个会话，完成度 75%
🎯 下一步：添加令牌刷新机制
```

---

## ⚙️ 配置

调整自动检查点频率：

```bash
/marathon-config
```

**推荐阈值**:
- `10-15` → 快节奏工作
- `20-30` → 均衡（默认）
- `30-50` → 深度工作

---

## 📊 为什么选择 Marathon？

✅ **自动跟踪** - 设置后即忘记
✅ **AI 驱动** - Claude Haiku 智能总结
✅ **成本低廉** - <$0.10/月
✅ **零打断** - 后台执行
✅ **多项目** - 目录感知的会话过滤
✅ **无缝延续** - 从上次停止处继续

---

## 🎯 完美适用于

- 多天功能实现
- 跨会话的 bug 调查
- 研究和学习项目
- 团队交接和上下文共享
- 任何超过一个会话的任务

---

## 📖 文档

- **完整指南**: [INSTALL.md](../INSTALL.md)
- **English Docs**: [README.md](../README.md)
- **问题反馈**: [GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)

---

## 🤝 贡献

欢迎 PR！查看 [CONTRIBUTING.md](../CONTRIBUTING.md)

---

## 📄 许可证

MIT License - 查看 [LICENSE](../LICENSE)

---

## 🙏 灵感来源

- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

---

**自信地奔跑你的马拉松！** 🏃‍♂️💨
