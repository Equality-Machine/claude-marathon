# Claude Marathon 分发指南

本文档说明如何让其他用户发现和安装 Claude Marathon 插件。

## 🎯 当前状态：立即可用

✅ **其他用户现在就可以安装！**

```bash
# 在 Claude Code 中运行：
/plugin marketplace add Equality-Machine/claude-marathon
/plugin install marathon@marathon
```

## 📊 分发层级

### 1️⃣ 直接 GitHub 安装（已实现）✅

**状态**: 立即可用
**用户体验**: 需要知道仓库地址

```bash
/plugin marketplace add Equality-Machine/claude-marathon
/plugin install marathon@marathon
```

**优点**:
- ✅ 无需审核，立即可用
- ✅ 完全控制更新和版本
- ✅ 适合早期用户和测试

**推广方式**:
- 在 README.md 中提供安装命令
- 在项目文档中说明
- 通过社交媒体/论坛分享

---

### 2️⃣ 社区注册表（提升可见度）

#### A. [claudemarketplaces.com](https://claudemarketplaces.com/)

**状态**: 可能已自动收录
**如何检查**: 访问 https://claudemarketplaces.com 搜索 "marathon"

这个网站**自动扫描 GitHub**，发现符合 Claude Code marketplace 结构的仓库。

**特点**:
- 自动收录公开仓库
- 提供可视化浏览界面
- 社区维护，非官方

**如何确保收录**:
1. ✅ 仓库公开
2. ✅ 包含 `.claude-plugin/marketplace.json`
3. ✅ 遵循标准结构
4. （可选）在他们的 GitHub 开 issue 请求收录

#### B. [claude-plugins.dev](https://claude-plugins.dev/)

**状态**: 需要手动提交
**特点**: 提供 CLI 一键安装

用户可以使用：
```bash
npx claude-plugins install marathon
```

**如何提交**: 访问网站查看提交指南或在其 GitHub 仓库开 issue

---

### 3️⃣ 官方 Marketplace（最高权威）

#### [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official)

**状态**: 需要申请和审核
**用户体验**: 预装在所有 Claude Code 中，无需添加 marketplace

**要求**:
- 高质量代码
- 完整文档
- 安全审核
- 持续维护承诺

**提交流程**:
1. 准备插件（已完成✅）
2. 访问官方仓库
3. 按照贡献指南提交 PR
4. 等待 Anthropic 团队审核

**优点**:
- 最高可见度
- Anthropic 官方背书
- 预装，用户无需添加 marketplace

**缺点**:
- 审核时间可能较长
- 质量要求更高
- 需要持续维护

---

## 📝 推荐策略

### 阶段 1: 当前（立即执行）✅

1. **在 README 突出显示安装命令**（已完成）
2. **等待社区注册表自动收录** claudemarketplaces.com
3. **在相关社区分享**：
   - Reddit: r/ClaudeAI
   - Discord: Claude 相关服务器
   - X/Twitter: 使用 #ClaudeCode 标签

### 阶段 2: 扩大影响（1-2周内）

1. **验证社区注册表收录**
   - 检查 claudemarketplaces.com
   - 联系 claude-plugins.dev 团队

2. **收集用户反馈**
   - 创建 GitHub Discussions
   - 添加 Issue 模板
   - 监控安装问题

### 阶段 3: 官方认证（稳定后）

1. **完善文档和测试**
2. **准备提交到官方 marketplace**
3. **申请官方审核**

---

## 🔍 可发现性优化

### GitHub 仓库优化

- [x] 清晰的 README.md with 安装说明
- [x] MIT 许可证
- [x] 多语言文档
- [ ] GitHub Topics 标签：
  ```
  claude-code, claude-plugin, task-management,
  ai-tools, productivity, context-preservation
  ```
- [ ] GitHub Release with changelog
- [ ] 演示视频/GIF

### SEO 和关键词

确保以下关键词出现在文档中：
- ✅ "Claude Code plugin"
- ✅ "task management"
- ✅ "multi-session"
- ✅ "context preservation"
- ✅ "progress tracking"

---

## 📊 成功指标

跟踪以下指标：
- GitHub Stars
- GitHub Forks
- Installation 数量（如果社区注册表提供）
- GitHub Issues/Discussions 活跃度
- 社区反馈质量

---

## 🚀 快速行动清单

### 立即可做（已完成✅）
- [x] 创建 marketplace.json
- [x] 创建 plugin.json
- [x] 更新 README 安装说明
- [x] 推送到 GitHub

### 本周内
- [ ] 添加 GitHub Topics
- [ ] 检查 claudemarketplaces.com 收录
- [ ] 在社区分享链接
- [ ] 创建 GitHub Release v1.0.0

### 下周
- [ ] 联系 claude-plugins.dev
- [ ] 收集早期用户反馈
- [ ] 优化文档based on反馈

### 未来
- [ ] 考虑提交到官方 marketplace
- [ ] 创建演示视频
- [ ] 撰写博客文章

---

## 📚 参考资源

- [Create and distribute a plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces)
- [Discover and install prebuilt plugins](https://code.claude.com/docs/en/discover-plugins)
- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Claude Marketplaces Community](https://claudemarketplaces.com/)
- [Claude Plugins Dev](https://claude-plugins.dev/)

---

**更新时间**: 2026-02-22
**维护者**: b4yesc4t
