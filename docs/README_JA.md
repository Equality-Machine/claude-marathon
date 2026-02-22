# 🏃‍♂️ Claude Marathon

> **長期にわたるタスクのためのAI駆動の進捗管理ツール**
> コンテキストを失わず、Claude Haikuによる自動要約で、セッション間でシームレスに作業を継続できます。

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://code.claude.com)
[![Haiku Powered](https://img.shields.io/badge/AI-Claude_Haiku-orange)](https://anthropic.com)

**Languages**: [English](../README.md) | [中文](./README_ZH.md) | [日本語](./README_JA.md) | [한국어](./README_KO.md) | [Русский](./README_RU.md) | [Español](./README_ES.md)

---

## ⚡ クイックスタート

```bash
# インストール
cd ~/.claude/plugins
git clone https://github.com/b4yesc4t/claude-marathon marathon

# ~/.claude/settings.json で有効化
{
  "enabledPlugins": {
    "marathon": true
  }
}

# Claude Codeを再起動 - 完了！🎉
```

---

## 🎯 Marathonとは？

Marathonは1つの課題を解決します：**長期タスクでセッション終了時にコンテキストが失われる問題**

### 課題
複数のClaude Codeセッションにまたがる複雑なタスクでは、貴重なコンテキストが失われます：
- 前回のセッションで何をしたか？
- 次に実装する予定だった機能は？
- どのような技術的決定を下し、その理由は？

### 解決策
Marathonは**Claude Haikuを使用して全ての操作を自動追跡・要約**します：

**Marathon導入前**:
```
セッション1: 認証機能のため20ファイルを編集 ✅
[コンテキスト圧縮が発生]
セッション2: "昨日何を実装したっけ？" ❓
          全20ファイルを手動で確認... 😓
```

**Marathon導入後**:
```
セッション1: 20ファイルを編集 ✅
          → 自動チェックポイント発動
          → Claude Haikuが要約: "🎯 JWT認証システムを実装"
[コンテキスト圧縮が発生]
セッション2: /marathon-review
          → "前回: JWT認証75%完了。次: リフレッシュトークン追加" ✅
          即座に作業再開！🚀
```

---

## 🎮 完全なワークフロー

Marathonは完全なタスクライフサイクル管理を提供：

```
セッション開始
  ↓
📖 /marathon-review        ← 過去のセッションからコンテキストを復元
  ↓
⚙️ /marathon-config        ← （任意）自動チェックポイント閾値を設定
  ↓
💻 タスクに取り組む...
  ├─ 🤖 自動チェックポイント  ← バックグラウンド: 20操作ごとにAI要約
  ├─ 💾 /marathon-checkpoint ← 手動: 重要な時点で詳細な進捗を保存
  └─ 🏁 /marathon-milestone  ← 手動: 主要な成果をマーク
  ↓
✅ /marathon-end           ← 完了時にアーカイブ
```

### 🤖 自動チェックポイント（自動実行）

**バックグラウンドで自動実行 - コマンド不要！**

- **機能**: Claude Haikuを使用した最近の操作のAIバッチ要約
- **タイミング**: N回のツール呼び出しごと（デフォルト: 20、設定可能）
- **コスト**: < $0.10/月
- **例**:
  ```markdown
  ## 📊 自動要約 (11:03)
  - [11:02] 📝 編集: test_manual.txt
  - [11:03] 🔧 リファクタリング: 認証モジュール (login.js, token.js)
  ```

---

## 📋 全コマンド

### セッションライフサイクル

| コマンド | 目的 | 使用タイミング | タイプ |
|:--------|:-----|:------------|:------|
| **`/marathon-review`** | 過去のセッションからコンテキストを復元 | **セッション開始時** - 過去の作業を読み込む | 手動 |
| **`/marathon-config`** | 自動チェックポイント閾値を設定 | いつでも - 頻度調整（10-50回）| 手動 |
| **自動チェックポイント** | Claude HaikuによるAIバッチ要約 | **作業中** - N操作ごと | 自動 |
| **`/marathon-checkpoint`** | 詳細な進捗レポートを保存 | **作業中** - 主要なマイルストーン後 | 手動 |
| **`/marathon-milestone`** | 主要な成果をマーク | **作業中** - 重要な達成を祝う | 手動 |
| **`/marathon-end`** | タスクを完了しアーカイブ | **セッション終了時** - 最終要約とアーカイブ | 手動 |

### 主要な違い

**自動 vs 手動**:
- **自動チェックポイント**: バックグラウンドAI要約、N操作ごとに自動実行
- **手動チェックポイント**（`/marathon-checkpoint`）: あなたの分析を含む詳細な進捗保存
- **マイルストーン**（`/marathon-milestone`）: 主要な成果の記念マーカー

---

## 🏗️ 仕組み

```
1日目: タスク開始
├─ Marathonが workspace/session_20260222_*/ を作成
├─ 全てのファイル編集、gitコマンドを自動追跡
└─ 20操作後 → AI要約 ✅

3日目: 作業継続
├─ /marathon-review → 全ての過去セッションを読み込み
├─ 表示: 完了したこと？次のステップは？
└─ 完全なコンテキストで作業継続 ✅
```

**ワークスペース構造**:
```
workspace/session_YYYYMMDD_HHMMSS/
├── progress.md          # 自動+手動追跡
├── learnings.md         # 技術的知見
├── session.json         # メタデータ
└── logs/                # 自動チェックポイントログ
```

---

## 💡 ワークフロー例

```bash
# JWT認証機能を開発中...

# (20回の編集後、自動チェックポイント発動)
## 📊 自動要約
- [14:10] 🎯 JWTログイン + トークン生成を実装
- [14:25] 🧪 統合テストを追加

# 主要マイルストーン後
/marathon-checkpoint
✅ チェックポイント: ログインエンドポイント完了

# MVP完了時
/marathon-milestone
🏁 マイルストーン: JWT認証MVP完了！

# 次のセッション
/marathon-review
🔍 3セッション読み込み、75%完了
🎯 次: トークンリフレッシュ機構を追加
```

---

## ⚙️ 設定

自動チェックポイント頻度を調整：

```bash
/marathon-config
```

**推奨閾値**:
- `10-15` → ペースの速い作業
- `20-30` → バランス型（デフォルト）
- `30-50` → 深い集中作業

---

## 📊 なぜMarathon？

✅ **自動追跡** - 設定したら忘れる
✅ **AI駆動** - Claude Haikuが賢く要約
✅ **低コスト** - <$0.10/月
✅ **無中断** - バックグラウンド実行
✅ **マルチプロジェクト** - ディレクトリ認識のセッションフィルタリング
✅ **シームレスな継続性** - 中断したところから再開

---

## 🎯 最適な用途

- 複数日にわたる機能実装
- セッションをまたぐバグ調査
- 研究・学習プロジェクト
- チーム引き継ぎとコンテキスト共有
- 1セッション以上かかる全てのタスク

---

## 📖 ドキュメント

- **完全ガイド**: [INSTALL.md](../INSTALL.md)
- **English Docs**: [README.md](../README.md)
- **問題報告**: [GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)

---

## 🤝 貢献

PRを歓迎します！[CONTRIBUTING.md](../CONTRIBUTING.md) をご覧ください

---

## 📄 ライセンス

MIT License - [LICENSE](../LICENSE) を参照

---

## 🙏 インスピレーション

- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

---

**自信を持ってマラソンを走りましょう！** 🏃‍♂️💨
