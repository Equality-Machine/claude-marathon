#!/bin/bash

# GitHub 仓库设置脚本
# 在 GitHub 网页创建 claude-marathon 仓库后运行此脚本

echo "🚀 设置 GitHub 远程仓库..."
echo ""

# 替换为你的 GitHub 用户名
GITHUB_USERNAME="b4yesc4t"

# 添加远程仓库
echo "📡 添加远程仓库..."
git remote add origin "https://github.com/${GITHUB_USERNAME}/claude-marathon.git"

# 推送代码
echo "⬆️  推送代码到 GitHub..."
git branch -M main
git push -u origin main

# 创建 v1.0.0 标签
echo "🏷️  创建 v1.0.0 标签..."
git tag -a v1.0.0 -m "Release v1.0.0 - Run the marathon of epic tasks with Claude"
git push origin v1.0.0

echo ""
echo "✅ 完成！"
echo ""
echo "🌐 仓库地址: https://github.com/${GITHUB_USERNAME}/claude-marathon"
echo "📦 Release: https://github.com/${GITHUB_USERNAME}/claude-marathon/releases/tag/v1.0.0"
echo ""
echo "📝 下一步："
echo "1. 在 GitHub 上创建 Release（使用 v1.0.0 标签）"
echo "2. 添加 Release 说明（参考 README.md）"
echo "3. 分享到社交媒体！"
