---
name: enhance-harness
version: 0.1.0
description: Update, extend, or repair an existing Codex, Claude Code, or Claude Cowork harness after the user's workflow changes.
---

# Enhance Harness

`enhance-harness` 는 이미 만들어진 하네스나 Cowork work package 를 실제 사용 경험에 맞게 보강하는 스킬이다.
처음부터 새 하네스를 만드는 목적이 아니라, 사용 중 발견된 불편함, 변경된 업무 방식, 새 반복 업무를 기존 구조에 반영한다.

## Trigger

`/enhance-harness`

또는 아래와 같은 자연어 요청:

- "기존 하네스를 수정하고 싶어"
- "예전 규칙 때문에 결과가 이상하게 나와"
- "새 업무가 생겼으니 하네스에 추가해줘"
- "Cowork work package 를 업데이트하고 싶어"

## Core Rule

기존 하네스를 읽거나 수정하기 전에는 먼저 허락을 받는다.
파일을 쓰기 전에는 정확한 수정 계획을 보여주고 승인받는다.
기존 파일은 파일별로 수정 승인을 받는다.

## Modes

사용자의 요청을 아래 세 모드 중 하나로 분류한다.

### 1. Revise

기존 규칙이 더 이상 맞지 않을 때 사용한다.

예:

- 기존에는 A 방식으로 보고서를 만들었지만 지금은 B 방식으로 바뀜
- 예전 금지 행동이 이제는 허용됨
- 출력 톤이나 검토 기준이 바뀜

이 모드에서는 기존 규칙을 찾아서 새 규칙으로 바꾸고, 충돌하는 예시나 template 도 함께 확인한다.

### 2. Extend

새 반복 업무나 새 산출물이 생겼을 때 사용한다.

예:

- 새 weekly report workflow 추가
- 새 고객 응답 template 추가
- Cowork 에 맡길 새 task 추가

이 모드에서는 기존 하네스의 스타일을 유지하면서 새 workflow, task, template, examples 를 추가한다.

### 3. Patch

작은 문구, 경계, 출력 형식만 고칠 때 사용한다.

예:

- "단정하지 말 것" 문구 강화
- 승인받아야 할 행동 1개 추가
- 보고서 길이 변경

이 모드에서는 최소 파일만 수정한다.

## Intake Questions

한 번에 한 라운드만 묻는다.
먼저 아래를 확인한다.

1. 어떤 하네스를 수정하나요? `Codex`, `Claude Code`, `Claude Cowork`, `잘 모르겠음`
2. 원하는 작업은 무엇인가요? `기존 규칙 변경`, `새 업무 추가`, `일부 문구 수정`, `잘 모르겠음`
3. 현재 불편한 점이나 바꾸고 싶은 예시는 무엇인가요?
4. 기존 하네스 파일이 있는 현재 폴더를 읽어도 될까요?

사용자가 잘 모르겠다고 하면 예시를 듣고 모드를 추천한다.

## File Discovery

폴더 읽기 승인을 받은 뒤에만 아래 후보를 확인한다.

- Codex: `AGENTS.md`, `docs/workflows/`, `docs/templates/`, `tools/`, `harness-manifest.json`
- Claude Code: `CLAUDE.md`, `.claude/skills/`, `.claude/settings.json`, `docs/workflows/`, `docs/templates/`, `harness-manifest.json`
- Claude Cowork: `COWORK-PROJECT-INSTRUCTIONS.md`, `COWORK-BRIEF.md`, `tasks/`, `templates/`, `examples/`, `handoff-checklist.md`, `harness-manifest.json`

관련 없는 파일은 읽지 않는다.

## Planning Rules

수정 전에는 아래 형식으로 계획을 보여준다.

```text
[수정 요약]
- 모드: Revise / Extend / Patch
- 대상 플랫폼:
- 바꾸려는 문제:

[수정 예정 파일]
- path: 변경 이유 / 변경 방식

[추가 예정 파일]
- path: 추가 이유

[건드리지 않을 파일]
- path 또는 유형: 이유

[검증]
- 확인할 항목:
```

마지막에는 반드시 묻는다.

> 이 계획대로 수정할까요?

## Platform Rules

### Codex

주요 수정 대상은 `AGENTS.md` 다.
절차가 길어지면 `docs/workflows/` 로 분리한다.
반복 출력 형식은 `docs/templates/` 로 분리한다.

### Claude Code

주요 수정 대상은 `CLAUDE.md` 다.
여러 프로젝트에서 재사용할 독립 기능이면 `.claude/skills/<skill-name>/SKILL.md` 를 제안할 수 있다.
권한이나 hooks 변경은 별도 근거와 승인 없이는 하지 않는다.

### Claude Cowork

주요 수정 대상은 `COWORK-PROJECT-INSTRUCTIONS.md`, `COWORK-BRIEF.md`, `tasks/` 다.
프로젝트 `지침` 에 붙여 넣은 내용이 바뀌어야 하면 `COWORK-PROJECT-INSTRUCTIONS.md` 를 수정하고, 마지막에 사용자에게 다시 복사해서 Cowork `지침` 칸에 반영하라고 안내한다.

## Validation Rules

수정 후 반드시 아래를 확인한다.

- 수정 계획과 실제 변경 파일이 일치하는지
- Markdown 파일이 비어 있지 않은지
- `TODO`, `TBD`, 의미 없는 `...` 가 남지 않았는지
- 기존 규칙과 새 규칙이 충돌하지 않는지
- Cowork 의 프로젝트 지침 파일이 바뀌었다면 사용자에게 재복사 안내를 했는지
- `harness-manifest.json` 이 있으면 변경 파일 목록과 필수 섹션을 갱신했는지

검증 스크립트가 있고 사용자가 실행을 승인하면 실행한다.
없거나 승인받지 않았다면 파일 내용 기반 검증만 수행한다.

## Failure Rule

기존 하네스가 없으면 새로 만들지 말고 `harness-builder` 를 쓰도록 안내한다.
변경하고 싶은 내용이 불명확하면 수정하지 말고 예시 1개를 더 요청한다.
사용자가 요청하지 않은 자동화나 설정 변경은 추가하지 않는다.
