---
name: harness-builder
version: 0.5.0
description: Interview the user, create a strong first-base harness for Codex or Claude Code, or a reusable work package for Claude Cowork, only after explicit approval.
---

# Harness Builder

`harness-builder` 는 사용자의 업무 방식, 기술 친숙도, 현재 작업 환경을 인터뷰해서
맞춤형 하네스를 설계하는 builder skill 이다.

이 스킬은 개발자 전용이 아니다.
처음 Codex, Claude Code, Claude Cowork 를 쓰는 일반 사무직 사용자도 대상으로 삼는다.

이 스킬의 기본 원칙은 세 가지다.

1. 사용자의 실제 업무를 먼저 이해한다.
2. 읽기와 쓰기 승인을 분리한다.
3. 근거가 약하면 starter harness 부터 제안한다.

이 스킬의 목표는 100% 완성된 최종 하네스를 한 번에 만드는 것이 아니다.
목표는 실제로 바로 사용할 수 있는 강한 1차 베이스를 만든 뒤,
사용자가 이후 작업을 하면서 계속 보강할 수 있게 하는 것이다.

## Trigger

`/harness-builder`

또는 아래와 같은 자연어 요청:

- "하네스 만들어줘"
- "내 작업에 맞는 Codex 설정을 잡아줘"
- "Claude Code 나 Cowork 에서 쓸 맞춤 작업 기반을 만들고 싶어"

## Promise

이 스킬은 아래를 보장해야 한다.

- 질문은 한 번에 한 라운드씩만 한다.
- 사용자의 기술 수준에 맞게 쉬운 말과 자세한 말을 조절한다.
- 현재 폴더를 읽기 전에는 먼저 허락을 받는다.
- 파일을 쓰기 전에는 정확한 파일 계획을 먼저 보여준다.
- 기존 파일을 바꿀 때는 파일별로 승인받는다.
- 검증 전에는 완료라고 말하지 않는다.

## Vocabulary Rule

사용자가 비개발자이거나 처음 쓰는 사용자처럼 보이면,
`runtime`, `wrapper`, `hook`, `permission` 같은 말부터 던지지 않는다.
먼저 쉬운 표현으로 설명한다.

예:

- "하네스" = 반복 업무를 도와주는 파일 묶음
- "현재 폴더를 읽는다" = 지금 열어 둔 작업 폴더 안의 문서와 설정을 확인한다
- "starter harness" = 위험한 자동화 없이 바로 시작할 수 있는 최소 설정
- "work package" = Claude Cowork 에 반복적으로 맡길 업무 규칙 문서 묶음

사용자가 기술 용어에 익숙하면 그때 더 구체적으로 말해도 된다.

## Overall Flow

```text
Round 0. 의도와 실행 환경 확인
Round 1. 가장 중요한 반복 업무 1개 수집
Round 2. 승인 경계와 금지 행동 수집
Round 3. 사용자 유형별 분기 질문
Round 4. 원하는 하네스 수준 결정
Round 5. 필요 시 기존 자산 / 파일 이름 / 덮어쓰기 정책 확인
Approval A. 현재 폴더 읽기 허용 여부
Approval B. 파일 계획 승인
Approval C. 실제 쓰기 승인
Approval D. 기존 파일별 수정 승인
Generate
Validate
```

기본값은 `1개 핵심 workflow` 기준으로 starter harness 를 설계하는 것이다.
사용자가 원할 때만 2번째 workflow 를 추가한다.
처음부터 3개 이상 workflow 를 요구하지 않는다.

## Round 0 — Intent First

가장 먼저 아래 내용을 묻는다.

1. 이 하네스로 어떤 업무를 돕고 싶은가요?
2. 지금 이 스킬을 어디서 실행 중인가요? `Claude Code`, `Codex`, `잘 모르겠음`
3. 어떤 결과물을 만들고 싶나요?
   - `Codex harness`
   - `Claude Code harness`
   - `Claude Cowork work package`
   - `잘 모르겠음`
4. 원하는 답변 언어는 무엇인가요?
5. 기술적인 설명을 자세히 듣는 편이 좋나요, 쉬운 설명이 좋나요?
6. 지금 열려 있는 폴더가 이번 하네스와 관련 있나요?

규칙:

- 사용자가 플랫폼을 모르면 업무 설명을 듣고 추천한다.
- 지금 실행 중인 환경과 생성 대상 플랫폼은 별개로 취급한다.
- 폴더 관련 질문은 여기서 "관련 있는지"만 묻고, 실제 읽기는 나중에 승인받는다.
- `Claude Cowork` 를 고른 경우, 설치형 하네스가 아니라 재사용 가능한 업무 문서 패키지로 안내한다.

## Round 1 — Primary Workflow

가장 중요한 반복 업무 1개를 아래 형식으로 받는다.

- 업무 이름
- 언제 시작되는지
- 입력으로 받는 정보
- 원하는 결과물
- 지금 수동으로 하는 일
- 가장 자주 막히는 지점

가능하면 아래도 받는다.

- 실제 입력 예시 1개
- 좋은 출력 예시 1개

정보가 부족하면 예시를 요청한다.
하지만 처음 사용자에게 3~5개 workflow 를 한 번에 요구하지 않는다.

2번째 workflow 는 아래 조건일 때만 묻는다.

- 사용자가 더 넓은 하네스를 원한다
- 첫 workflow 만으로는 파일 구조를 정하기 어렵다
- 멀티플랫폼 생성 근거가 부족하다

## Round 2 — Boundaries In Plain Language

아래를 쉬운 말로 묻는다.

1. 이 도구가 혼자 해도 되는 일은 무엇인가요?
2. 항상 먼저 물어봐야 하는 일은 무엇인가요?
3. 절대 하면 안 되는 일은 무엇인가요?
4. 민감한 정보나 절대 파일에 적으면 안 되는 것이 있나요?
5. 결과물이 너무 단정적으로 말하면 안 되는 주제가 있나요?

사용자가 원인 분석이나 제안을 원해도,
확인되지 않은 내용을 확정적으로 쓰지 않도록 제약을 기록한다.

## Round 3 — Branch By User Type

Round 0 과 Round 1 답변을 보고 질문 가지를 나눈다.

### Branch A — Repo-Aware / Software Users

개발자이거나 저장소 기반 자동화를 원할 때만 아래를 묻는다.

- 주로 쓰는 OS 와 셸
- 현재 폴더가 어떤 종류의 저장소인지
- 자주 쓰는 명령어, 스크립트, package script, Makefile, justfile 이 있는지
- 이미 있는 `AGENTS.md`, `CLAUDE.md`, `.claude/settings.json`, `COWORK-BRIEF.md`, `tasks/` 가 있는지
- 현재 폴더를 읽어서 확인해도 되는지

주의:

- 패키지 매니저, 런타임, wrapper 질문은 스크립트나 settings 생성 가능성이 있을 때만 한다.
- 모르면 추측하지 말고 더 안전한 starter 결과물로 낮춘다.

### Branch B — Office / Docs / Ops Users

비개발자이거나 문서 중심 사용자인 경우 아래를 묻는다.

- 주로 쓰는 도구: 예: Notion, Google Docs, Sheets, Slack, Excel, CRM
- 자주 다루는 입력 형태: 표, 텍스트, 링크, 회의 메모, CSV
- 결과물을 어디에 붙여 넣는지
- 선호하는 문체와 출력 길이
- 기존 템플릿이나 문서 형식이 있는지
- 현재 폴더를 읽어야 하는지, 아니면 대화만으로 starter 결과물을 만들면 되는지

주의:

- 이 branch 에서는 shell, runtime, package manager 를 기본 질문으로 쓰지 않는다.
- 현재 폴더가 중요하지 않다면 폴더 탐색 없이 진행한다.

### Branch C — Mixed

소프트웨어와 문서 업무가 섞여 있으면 각 branch 에서 꼭 필요한 질문만 2~3개씩 골라서 짧게 묻는다.

## Round 4 — Deliverable Level

아래 셋 중 원하는 수준을 묻는다.

1. `Starter harness`
   - 가장 안전한 기본형
   - 문서형 또는 최소 instruction file 중심
   - 폴더 탐색 없이도 가능
2. `Repo-aware harness`
   - 현재 폴더를 읽고 기존 파일과 함께 설계
   - workflow 문서나 보조 skill 을 함께 만들 수 있음
3. `Automation-heavy harness`
   - settings, scripts, hooks 같은 자동화 포함 가능
   - 폴더 탐색과 더 강한 근거, 별도 승인이 필요

규칙:

- 사용자가 처음 쓰거나 비개발자라면 `Starter harness` 를 기본 추천한다.
- 사용자가 분명한 근거와 필요를 설명했을 때만 상위 단계로 올린다.

## Round 5 — Optional Finalization

필요할 때만 아래를 묻는다.

- 생성 파일 이름 후보
- 기존 문서/템플릿 재사용 여부
- 기존 파일이 있을 경우 덮어쓰기 / 수정 / 건너뛰기 선호
- 여러 플랫폼을 동시에 만들고 싶은지 여부

여기서도 정보가 충분하면 추가 질문을 줄인다.

사용자가 `더 강화된 버전도 원한다` 고 하면 아래를 짧게 묻는다.

- 첫 버전을 써본 뒤 가장 먼저 보강하고 싶은 부분은 무엇인지
- 명령 / 경로 / 산출물 형식 / 금지 행동 중 어디를 더 구체화할지
- 지금은 starter 만 만들고, 나중에 2차 보강을 할지

## Sufficiency Rule

아래가 채워지면 초안을 만들 수 있다.

- 사용자의 핵심 업무 1개
- 원하는 결과물 1개 이상
- 승인 경계와 금지 행동
- 언어와 기술 친숙도
- 생성 대상 플랫폼 또는 결과물 종류
- 현재 폴더가 관련 있는지 여부

아래는 선택 항목이다.

- 2번째 workflow
- 저장소 상세 구조
- 스크립트 실행 환경
- settings / hooks / permissions

선택 항목이 비어 있으면 더 안전한 출력 계약으로 낮춘다.

## Approval Gates

### Approval A — Folder Inspection

현재 폴더를 읽어야 할 필요가 생기면 먼저 아래처럼 묻는다.

> 지금 열려 있는 폴더를 확인해서 기존 파일과 구조를 반영해도 될까요?
> 원하지 않으면 폴더를 읽지 않고 starter 결과물로 계속 진행할 수 있습니다.

승인을 받기 전에는 아래를 하지 않는다.

- `pwd`
- 파일 목록 확인
- 기존 설정 파일 읽기
- 저장소 구조 탐색

### Approval B — File Plan

파일을 쓰기 전에 정확한 파일 계획을 보여준다.

형식:

```text
[제안 요약]
- 목표:
- 대상 결과물:
- 추천 수준: Starter / Repo-aware / Automation-heavy

[생성 예정 파일]
- path: 목적 / 왜 필요한지 / 신규 또는 수정

[보류 또는 제외]
- path 또는 유형: 제외 이유

[승인 경계]
- 혼자 해도 되는 일:
- 쓰기 전 확인할 일:
- 절대 하지 않을 일:
```

마지막에는 반드시 아래 문장을 넣는다.

> 이 계획대로 진행할까요?
> 수정하고 싶은 파일이나 제외할 항목이 있으면 알려주세요.

### Approval C — Write

사용자가 계획을 승인한 뒤에도 실제 쓰기 직전에 한 번 더 확인한다.

> 아래 파일을 현재 폴더에 쓰겠습니다. 진행할까요?

### Approval D — Existing Files

기존 파일이 있으면 파일별로 따로 묻는다.
묶어서 한 번에 승인받지 않는다.

특히 아래는 더 엄격하게 다룬다.

- `AGENTS.md`
- `CLAUDE.md`
- `.claude/settings.json`
- 기존 skill 파일

## Output Contracts

생성은 세 단계 계약 중 하나를 따른다.

### 1. Starter Contract

가장 안전한 기본값이다.

- Codex: `AGENTS.md` 만 생성 가능
- Claude Code: `CLAUDE.md` 만 생성 가능
- Claude Cowork: `COWORK-BRIEF.md` + `tasks/<workflow>.md`
- 필요 시 짧은 `README.md` 또는 `docs/templates/<name>.md`

이 단계에서는 아래를 기본적으로 만들지 않는다.

- settings
- hooks
- 실행 스크립트
- 광범위 권한 설정

### 2. Repo-Aware Contract

폴더 탐색 승인을 받은 경우만 가능하다.

- 기존 파일과 구조를 읽고 instruction file 을 더 구체화한다
- `docs/workflows/` 문서 또는 `.claude/skills/<name>/SKILL.md` 를 추가할 수 있다
- Cowork 는 `templates/<name>.md` 또는 `handoff-checklist.md` 를 함께 추가할 수 있다

### 3. Automation-Heavy Contract

아래가 모두 있어야만 가능하다.

- 강한 사용자 요청
- 현재 폴더와 실행 환경 근거
- separate approval

이 단계에서만 아래를 고려한다.

- `tools/*.sh`, `tools/*.py`, `tools/*.ps1`
- `.claude/settings.json`
- 자동화 스크립트와 권한

근거가 약하면 이 단계로 올라가지 않는다.

## Platform Rules

### Codex

기본 출력은 `AGENTS.md` 다.

필요할 때만 아래를 추가한다.

- `docs/workflows/<workflow>.md`
- `docs/templates/<name>.md`
- `tools/<task>.sh|py|ps1`

명령어, 경로, 도구 이름은 현재 폴더나 사용자 답변 근거가 있을 때만 쓴다.

### Claude Code

기본 출력은 `CLAUDE.md` 다.

필요할 때만 아래를 추가한다.

- `.claude/skills/<skill-name>/SKILL.md`
- `.claude/settings.json`
- `docs/templates/<name>.md`

`.claude/settings.json` 은 자동 생성 기본값이 아니다.
권한, hooks, env 는 사용자 답변과 파일 상태 근거가 있을 때만 제안한다.

### Claude Cowork

Claude Cowork 는 Codex 나 Claude Code 와 같은 공식 설치형 하네스 구조를 전제로 하지 않는다.
따라서 여기서는 `하네스` 대신 `재사용 가능한 work package` 를 만든다.

기본 출력은 아래 두 파일이다.

- `COWORK-BRIEF.md`
- `tasks/<workflow>.md`

필요할 때만 아래를 추가한다.

- `templates/<name>.md`
- `handoff-checklist.md`
- `examples/<name>.md`

`COWORK-BRIEF.md` 에는 아래가 들어가야 한다.

- Claude 가 맡을 역할
- 자주 다루는 입력 자료 종류
- 출력 톤과 형식
- 단정하면 안 되는 내용
- 사람이 마지막에 확인할 지점

`tasks/<workflow>.md` 에는 아래가 들어가야 한다.

- 언제 쓰는지
- 필요한 입력
- 작업 순서
- 금지 행동
- 기대 출력 형식
- 짧은 예시 입력 / 출력

## Generation Rules

- 승인 전에는 어떤 파일도 생성하지 않는다.
- 사용자가 허락하지 않은 현재 폴더 탐색은 하지 않는다.
- 인터뷰 근거가 없는 명령어를 넣지 않는다.
- 비개발자에게는 기본적으로 문서형 결과물을 우선 제안한다.
- 기존 파일과 충돌하면 파일별로 처리 방식을 묻는다.
- 여러 플랫폼을 동시에 만들더라도 파일 계획은 플랫폼별로 구분해서 보여준다.
- Cowork 에 대해서는 공식 제품 primitive 처럼 보이는 JSON 구조를 임의로 만들지 않는다.

## Validation Rules

생성 후 반드시 아래를 확인한다.

- 생성된 경로가 실제로 존재하는지
- 계획과 실제 생성 파일이 일치하는지
- JSON 파일이 파싱되는지
- Markdown 파일이 비어 있지 않은지
- placeholder 나 `TODO`, 의미 없는 `...` 가 남지 않았는지
- 금지 행동과 승인 경계가 산출물에 반영되었는지

스크립트가 생성된 경우에만 환경에 맞는 최소 문법 검사를 한다.
스크립트가 없다면 불필요한 실행 검사는 하지 않는다.

## Failure Rule

정보가 부족하면 억지로 자세한 자동화를 만들지 않는다.
대신 아래 중 하나로 낮춘다.

- 더 짧은 starter harness
- 문서형 workflow
- 추가 질문 1~2개
- Cowork 용 work package 로 낮추기

그래도 핵심 정보가 없으면 생성을 보류하고,
무엇이 부족한지 짧게 요약한 뒤 다음에 필요한 답변만 요청한다.

## Style Rule

- 공손하고 간단하게 쓴다.
- 한 번에 한 라운드만 묻는다.
- 매 라운드 전에 지금까지 이해한 내용을 짧게 요약한다.
- 사용자의 언어와 숙련도에 맞춘다.
- 승인 경계를 숨기지 않는다.
