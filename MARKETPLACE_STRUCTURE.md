# Claude Code Marketplace Structure

## 正确的理解

Claude Code 插件**不是**通过直接 `git clone` 安装的，而是使用 **Marketplace 系统**。

## Marketplace vs Direct Install

### ❌ 错误方式（不存在）
```bash
cd ~/.claude/plugins
git clone https://github.com/user/plugin
# 编辑 ~/.claude/settings.json
# 重启 Claude Code
```

### ✅ 正确方式（Marketplace）
```bash
# 添加 marketplace
/plugin marketplace add user/marketplace-repo

# 安装插件
/plugin install plugin-name@marketplace-name
```

## Marketplace 结构

一个 marketplace 仓库包含：

```
marketplace-repo/
├── .claude-plugin/
│   ├── marketplace.json      # Marketplace 配置（必需）
│   └── plugin.json           # 如果插件在根目录
├── plugin/                   # 或者插件在子目录
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── commands/
│   ├── hooks/
│   └── skills/
└── README.md
```

### marketplace.json 示例

```json
{
  "name": "marathon",
  "owner": {
    "name": "b4yesc4t"
  },
  "metadata": {
    "description": "Marathon plugin marketplace",
    "version": "1.0.0"
  },
  "plugins": [
    {
      "name": "marathon",
      "version": "1.0.0",
      "source": ".",              // 插件在根目录
      "description": "Plugin description"
    }
  ]
}
```

### Plugin Source 类型

| Type | Example | 说明 |
|------|---------|------|
| 相对路径 | `"source": "."` | 插件在 marketplace 仓库的根目录 |
| 相对路径 | `"source": "./plugin"` | 插件在子目录 |
| GitHub | `{"source": "github", "repo": "user/plugin"}` | 独立仓库 |
| Git URL | `{"source": "url", "url": "https://..."}` | Git 仓库 URL |

## Marathon 的结构

当前 Marathon 采用 **单仓库方式**：

```
claude-marathon/
├── .claude-plugin/
│   ├── marketplace.json      # Marketplace 配置
│   └── plugin.json           # Plugin 配置
├── commands/
├── hooks/
├── skills/
└── ...
```

**marketplace.json** 配置：
```json
{
  "name": "marathon",
  "plugins": [
    {
      "name": "marathon",
      "source": "."           // 插件在根目录
    }
  ]
}
```

## 用户安装流程

### 方式 1: GitHub Marketplace
```bash
/plugin marketplace add Equality-Machine/claude-marathon
/plugin install marathon@marathon
```

### 方式 2: 本地开发
```bash
git clone https://github.com/Equality-Machine/claude-marathon ~/.claude/plugins/marathon
/plugin marketplace add ~/.claude/plugins/marathon
/plugin install marathon@marathon
```

## 参考资料

- [Create and distribute a plugin marketplace - Claude Code Docs](https://code.claude.com/docs/en/plugin-marketplaces)
- [Discover and install prebuilt plugins](https://code.claude.com/docs/en/discover-plugins)
- [Claude Code Plugin Marketplace](https://claudemarketplaces.com/)
- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)

## 关键要点

1. ✅ Claude Code 使用 **Marketplace 系统**
2. ✅ Marketplace 仓库需要 `.claude-plugin/marketplace.json`
3. ✅ 插件可以在同一仓库（相对路径）或独立仓库（GitHub/Git URL）
4. ✅ 用户通过 `/plugin` 命令安装，不是手动 git clone
5. ✅ Claude Code 自动管理插件缓存到 `~/.claude/plugins/cache/`

---

创建时间: 2026-02-22
作者: Claude Sonnet 4.5
