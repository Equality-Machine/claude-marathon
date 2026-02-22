# 🏃‍♂️ Claude Marathon

> **장기 작업을 위한 AI 기반 진행 상황 추적**
> 컨텍스트를 잃지 않고, Claude Haiku로 자동 요약하며, 세션 간 원활하게 작업을 이어갑니다.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Plugin-purple)](https://code.claude.com)
[![Haiku Powered](https://img.shields.io/badge/AI-Claude_Haiku-orange)](https://anthropic.com)

**Languages**: [English](../README.md) | [中文](./README_ZH.md) | [日本語](./README_JA.md) | [한국어](./README_KO.md) | [Русский](./README_RU.md) | [Español](./README_ES.md)

---

## ⚡ 빠른 시작

```bash
# 마켓플레이스 추가
/plugin marketplace add Equality-Machine/claude-marathon

# 플러그인 설치
/plugin install marathon@marathon

# 완료! 🎉
```

---

## 🎯 Marathon이란?

Marathon은 하나의 문제를 해결합니다: **장기 작업에서 세션 종료 시 컨텍스트가 손실되는 문제**

### 문제점
여러 Claude Code 세션에 걸친 복잡한 작업에서 귀중한 컨텍스트를 잃게 됩니다:
- 지난 세션에서 무엇을 했는가?
- 다음에 구현할 예정이었던 것은?
- 어떤 기술적 결정을 내렸고, 그 이유는?

### 해결책
Marathon은 **Claude Haiku를 사용하여 모든 작업을 자동으로 추적하고 요약**합니다:

**Marathon 도입 전**:
```
세션 1: 인증 기능을 위해 20개 파일 편집 ✅
[컨텍스트 압축 발생]
세션 2: "어제 뭘 구현했더라?" ❓
        20개 파일 수동으로 확인... 😓
```

**Marathon 도입 후**:
```
세션 1: 20개 파일 편집 ✅
        → 자동 체크포인트 실행
        → Claude Haiku 요약: "🎯 JWT 인증 시스템 구현"
[컨텍스트 압축 발생]
세션 2: /marathon-review
        → "이전 세션: JWT 인증 75% 완료. 다음: 토큰 갱신 추가" ✅
        즉시 작업 재개! 🚀
```

---

## 🎮 전체 워크플로우

Marathon은 완전한 작업 생명주기 관리를 제공합니다:

```
세션 시작
  ↓
📖 /marathon-review        ← 이전 세션에서 컨텍스트 복원
  ↓
⚙️ /marathon-config        ← (선택) 자동 체크포인트 임계값 설정
  ↓
💻 작업 진행...
  ├─ 🤖 자동 체크포인트      ← 백그라운드: 20회 작업마다 AI 요약
  ├─ 💾 /marathon-checkpoint ← 수동: 중요 시점에 상세 진행 상황 저장
  └─ 🏁 /marathon-milestone  ← 수동: 주요 성과 표시
  ↓
✅ /marathon-end           ← 완료 시 아카이브
```

### 🤖 자동 체크포인트 (자동 실행)

**백그라운드에서 자동 실행 - 명령어 불필요!**

- **기능**: Claude Haiku를 사용한 최근 작업의 AI 일괄 요약
- **시점**: N회 도구 호출마다 (기본값: 20, 설정 가능)
- **비용**: < $0.10/월
- **예시**:
  ```markdown
  ## 📊 자동 요약 (11:03)
  - [11:02] 📝 편집: test_manual.txt
  - [11:03] 🔧 리팩토링: 인증 모듈 (login.js, token.js)
  ```

---

## 📋 모든 명령어

### 세션 생명주기

| 명령어 | 목적 | 사용 시점 | 유형 |
|:------|:-----|:---------|:-----|
| **`/marathon-review`** | 이전 세션에서 컨텍스트 복원 | **세션 시작** - 과거 작업 로드 | 수동 |
| **`/marathon-config`** | 자동 체크포인트 임계값 설정 | 언제든지 - 빈도 조정 (10-50회) | 수동 |
| **자동 체크포인트** | Claude Haiku를 통한 AI 일괄 요약 | **작업 중** - N회 작업마다 | 자동 |
| **`/marathon-checkpoint`** | 상세 진행 보고서 저장 | **작업 중** - 주요 마일스톤 후 | 수동 |
| **`/marathon-milestone`** | 주요 성과 표시 | **작업 중** - 중요한 성취 축하 | 수동 |
| **`/marathon-end`** | 작업 완료 및 아카이브 | **세션 종료** - 최종 요약 및 아카이브 | 수동 |

### 주요 차이점

**자동 vs 수동**:
- **자동 체크포인트**: 백그라운드 AI 요약, N회 작업마다 자동 실행
- **수동 체크포인트** (`/marathon-checkpoint`): 분석이 포함된 상세 진행 상황 저장
- **마일스톤** (`/marathon-milestone`): 주요 성과의 기념 마커

---

## 🏗️ 작동 방식

```
1일차: 작업 시작
├─ Marathon이 workspace/session_20260222_*/ 생성
├─ 모든 파일 편집, git 명령 자동 추적
└─ 20회 작업 후 → AI 요약 ✅

3일차: 작업 계속
├─ /marathon-review → 모든 이전 세션 로드
├─ 표시: 완료된 것? 다음 단계는?
└─ 완전한 컨텍스트로 작업 계속 ✅
```

**워크스페이스 구조**:
```
workspace/session_YYYYMMDD_HHMMSS/
├── progress.md          # 자동 + 수동 추적
├── learnings.md         # 기술 인사이트
├── session.json         # 메타데이터
└── logs/                # 자동 체크포인트 로그
```

---

## 💡 워크플로우 예시

```bash
# JWT 인증 기능 개발 중...

# (20회 편집 후, 자동 체크포인트 실행)
## 📊 자동 요약
- [14:10] 🎯 JWT 로그인 + 토큰 생성 구현
- [14:25] 🧪 통합 테스트 추가

# 주요 마일스톤 후
/marathon-checkpoint
✅ 체크포인트: 로그인 엔드포인트 완료

# MVP 완료 시
/marathon-milestone
🏁 마일스톤: JWT 인증 MVP 완료!

# 다음 세션
/marathon-review
🔍 3개 세션 로드, 75% 완료
🎯 다음: 토큰 갱신 메커니즘 추가
```

---

## ⚙️ 설정

자동 체크포인트 빈도 조정:

```bash
/marathon-config
```

**권장 임계값**:
- `10-15` → 빠른 속도의 작업
- `20-30` → 균형 (기본값)
- `30-50` → 깊은 집중 작업

---

## 📊 Marathon을 선택하는 이유

✅ **자동 추적** - 설정하고 잊으면 됨
✅ **AI 기반** - Claude Haiku가 똑똑하게 요약
✅ **저렴한 비용** - <$0.10/월
✅ **중단 없음** - 백그라운드 실행
✅ **멀티 프로젝트** - 디렉토리 인식 세션 필터링
✅ **원활한 연속성** - 중단한 곳에서 정확히 재개

---

## 🎯 최적 용도

- 여러 날에 걸친 기능 구현
- 세션을 넘나드는 버그 조사
- 연구 및 학습 프로젝트
- 팀 인수인계 및 컨텍스트 공유
- 한 세션 이상 걸리는 모든 작업

---

## 📖 문서

- **전체 가이드**: [INSTALL.md](../INSTALL.md)
- **English Docs**: [README.md](../README.md)
- **이슈**: [GitHub Issues](https://github.com/b4yesc4t/claude-marathon/issues)

---

## 🤝 기여

PR 환영합니다! [CONTRIBUTING.md](../CONTRIBUTING.md) 참조

---

## 📄 라이선스

MIT License - [LICENSE](../LICENSE) 참조

---

## 🙏 영감을 받은 곳

- [Official Claude Plugins](https://github.com/anthropics/claude-plugins-official)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)

---

**자신감 있게 마라톤을 뛰세요!** 🏃‍♂️💨
