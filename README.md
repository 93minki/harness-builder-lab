# harness-builder

`harness-builder` 는 사용자의 업무 방식과 작업 환경을 인터뷰해서 맞춤형 하네스를 설계하는 설치형 스킬이다.
대상은 처음 Codex, Claude Code, Claude Cowork 를 쓰는 사용자이며, 개발자뿐 아니라 일반 사무직 사용자도 포함한다.

이 스킬은 정해진 템플릿을 밀어 넣는 도구가 아니다.
먼저 사용자의 목표, 반복 업무, 안전 경계, 현재 폴더의 의미를 확인한 뒤, 필요한 파일만 제안하고 승인을 받은 후 생성한다.

중요한 점:
이 스킬은 사용자의 업무를 100% 완성된 형태로 담은 최종 하네스를 한 번에 만들어내는 도구가 아니다.
대신 바로 실무에 투입할 수 있는 강한 1차 베이스를 만드는 것을 목표로 한다.
이 베이스를 실제 작업에 써 보면서 더 구체적인 규칙, 명령, 템플릿, 금지 사항을 계속 보강하는 방식이 맞다.

## Who It Is For

- 처음 Codex, Claude Code, Claude Cowork 를 설정해보는 사용자
- 자신의 업무에 맞는 개인화된 하네스를 원하는 사용자
- 개발자와 비개발자가 함께 쓰는 팀
- 바로 스크립트를 만들기보다 안전한 starter harness 부터 시작하고 싶은 사용자

## What It Does

`/harness-builder` 를 실행하면 스킬은 아래 순서로 진행한다.

1. 지금 어떤 업무를 돕고 싶은지 묻는다.
2. 현재 이 스킬을 어디서 실행 중인지 묻는다. 예: Claude Code, Codex
3. 어떤 플랫폼용 하네스를 만들고 싶은지 묻거나, 사용자가 잘 모르면 추천한다.
4. 사용자의 언어, 기술 친숙도, 승인 정책, 반복 업무를 수집한다.
5. 현재 폴더를 읽어도 되는지 별도로 확인한다.
6. 생성할 파일 목록과 이유를 먼저 보여준다.
7. 명시적 승인 후에만 파일을 생성한다.
8. 생성 직후 형식과 경로를 검증한다.

## What It Can Generate

항상 모든 파일을 만들지는 않는다.
인터뷰 내용과 승인 범위에 따라 필요한 것만 생성한다.

- Codex: `AGENTS.md`, `docs/workflows/`, `docs/templates/`, `tools/`
- Claude Code: `CLAUDE.md`, `.claude/settings.json`, `.claude/skills/`
- Claude Cowork: `COWORK-BRIEF.md`, `tasks/*.md`, `templates/*.md`

기본값은 low-risk starter harness 다.
근거가 충분하지 않거나 사용자가 비개발자라면 문서형 결과물부터 제안하고, 스크립트나 settings 변경은 별도 승인과 근거가 있을 때만 진행한다.

Codex 와 Claude Code 에서는 이 결과물이 `하네스의 강한 1차 베이스`가 된다.
Claude Cowork 에서는 동일한 개념을 그대로 쓰기보다, 반복 업무를 안정적으로 맡길 수 있는 `재사용 가능한 work package` 로 보는 편이 맞다.

## Strong First Base

좋은 결과물의 기준은 완벽함이 아니라, 바로 오늘부터 도움이 되는가이다.

- Codex / Claude Code: 자주 쓰는 명령, 작업 범위, 승인 경계, 핵심 workflow, 산출물 형식이 들어간다
- Claude Cowork: 자주 맡길 업무, 입력 형식, 출력 형식, 금지 표현, 사람 검토 지점이 들어간다

이 정도가 갖춰지면 사용자는 이후 작업에서 실제로 부족한 부분을 덧붙일 수 있다.

예:

- `AGENTS.md` 에 "main 직접 push 금지"만 있던 상태에서, 나중에 "PR 설명은 문제 / 원인 / 변경 / 검증 / 리스크 순서"를 추가
- `CLAUDE.md` 에 자주 쓰는 테스트 명령만 넣어 둔 상태에서, 이후 `.claude/settings.json` 에 허용 명령과 deny 규칙을 추가
- `COWORK-BRIEF.md` 에 "주간 리포트 작성" 규칙만 넣어 둔 상태에서, 나중에 `tasks/weekly-report.md` 에 슬랙용 짧은 버전과 노션용 긴 버전 출력을 분리

## Install

이 저장소는 동일한 내용을 가진 두 개의 설치용 `SKILL.md` 를 제공한다.

- Claude Code 용: `.claude/skills/harness-builder/SKILL.md`
- Codex 용: `.agents/skills/harness-builder/SKILL.md`

사용자는 자신이 쓰는 도구의 루트 skill 경로에 해당 파일을 복사하면 된다.
그다음 하네스를 만들고 싶은 프로젝트 폴더를 연 뒤 `/harness-builder` 를 실행한다.

## How To Use

1. 사용할 도구의 루트 skill 경로에 `harness-builder` 를 설치한다.
2. 하네스 또는 work package 를 생성할 프로젝트 또는 작업 폴더를 연다.
3. `/harness-builder` 를 실행한다.
4. 질문에 답한다.
5. 현재 폴더를 읽어도 되는지 결정한다.
6. 생성 예정 파일 목록을 검토한다.
7. 승인하면 스킬이 해당 폴더에 파일을 생성한다.

## How To Strengthen It Later

처음 생성한 결과물을 실제로 써 본 뒤 아래 방식으로 강화하면 된다.

- 새로 자주 하게 된 업무가 생기면 `docs/workflows/` 또는 `tasks/` 를 추가
- 에이전트가 자꾸 헷갈리는 경로, 명령, 금지 행동을 `AGENTS.md` 또는 `CLAUDE.md` 에 추가
- 반복되는 문서 산출물이 있으면 `docs/templates/` 또는 `templates/` 로 분리
- Claude Code 에서 실제로 필요한 권한과 hooks 가 확인되면 그때 `.claude/settings.json` 을 보강
- Cowork 에서 반복 입력 형식이 정해지면 `tasks/<name>.md` 에 입력 예시와 출력 섹션 규칙을 추가

## Safety

- 폴더 탐색과 파일 생성은 별도 승인 단계로 나눈다.
- 기존 파일이 있으면 파일별로 `생성`, `수정`, `건너뛰기` 를 구분해서 보여준다.
- 사용자가 허용하지 않은 스크립트, 설정, 위험 작업은 생성하지 않는다.
- 검증이 끝나기 전에는 완료로 간주하지 않는다.

## Repository Layout

- `.claude/skills/harness-builder/SKILL.md`: Claude Code 설치용 스킬
- `.agents/skills/harness-builder/SKILL.md`: Codex 설치용 스킬
- `.gitignore`: 개발용 무시 목록

이 저장소는 source repo 다.
실제 하네스 또는 work package 파일은 사용자의 프로젝트 폴더 안에 생성된다.
