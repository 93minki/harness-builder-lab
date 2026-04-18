# Interview Answers

## Platform Selection

- 선택 플랫폼: `1+2+3`

## Round 1

1. 직함 / 역할: AI Tooling Lead
2. 팀 / 조직: 15명 규모 SaaS 엔지니어링 팀
3. 핵심 목표: 버그 리포트와 리뷰 피드백을 빠르게 재현 가능한 수정 작업으로 바꾸기
4. 성공 기준: 재현, 승인 경계, 수정 초안, 리뷰 요약이 일관되게 나온다

## Round 2

### Workflow 1: Incident Triage

- 시작: Sentry 이슈 또는 고객 버그 리포트 접수
- 입력: 에러 메시지, 환경 정보, 최근 변경 PR
- 산출물: 재현 단계, 의심 구간, 수정 범위 제안
- 현재 수동 단계: 로그 확인, 관련 PR 검색, 재현 시도
- 병목: 맥락이 흩어져 있어 재현과 우선순위 판단이 느리다

### Workflow 2: Reviewer Handoff

- 시작: 수정이 준비되었을 때
- 입력: 변경 파일, 테스트 결과, 리스크
- 산출물: 리뷰어용 요약, 검증 포인트, 후속 작업
- 현재 수동 단계: PR 설명 정리, 위험 지점 설명
- 병목: 항상 비슷한 요약을 손으로 다시 쓴다

### Workflow 3: Spec Draft

- 시작: 반복 이슈가 발견되었을 때
- 입력: 문제 설명, 영향 범위, 해결 아이디어
- 산출물: 짧은 스펙 초안
- 현재 수동 단계: 이슈 맥락을 문서로 재구성
- 병목: 구조를 매번 새로 잡는다

우선순위:

- 1순위: Incident Triage
- 2순위: Reviewer Handoff
- 3순위: Spec Draft

승인 정책:

- 조사와 초안 작성은 자율 수행 가능
- 코드 수정, 브랜치 조작, 위험 명령 실행 전에는 승인 필요

## Round 3

1. OS / 셸: macOS + zsh
2. 패키지 매니저 / 런타임: `bundle`, `pnpm`, `ruby`, `node`
3. 저장소 구조: monorepo (`apps/web`, `apps/api`, `docs/`)
4. 자주 쓰는 명령:
   - `bundle exec rspec`
   - `pnpm test`
   - `pnpm lint`
   - `rg`
5. 자주 다루는 경로:
   - `apps/api`
   - `apps/web`
   - `docs/specs`

## Round 4

1. 주요 도구: GitHub, Sentry, Linear, Slack
2. 연동 대상: GitHub PR, Sentry issue, Linear ticket
3. 시크릿 규칙: 토큰이나 운영 자격 증명은 파일에 직접 기록 금지
4. 데이터 형식: Markdown, JSON
5. Claude Code 기존 설정: 일부 프로젝트에 `settings.json`이 있으나 일관적이지 않음
6. CODEX 범위: 멀티파일 수정 가능하지만 승인 경계 필요
7. Cowork 기대 방식: 이슈 intake와 구조화된 triage 응답

## Round 5

1. 금지 행동: `main` 직접 push, 운영 DB 변경, 외부 메시지 전송
2. 보안 제약: 외부 네트워크 호출은 승인 후만 허용
3. 승인 없이 허용: 읽기 전용 조사, 초안 작성, 로컬 테스트 재현
4. 실패 시 기본 동작: 중단하고 현재까지 수집한 사실과 막힌 지점을 보고

## Round 6

1. 기존 자산: 일부 저장소에 `CLAUDE.md`와 `docs/templates/` 존재
2. 실패 사례: 버그 재현 전 코드 수정부터 시작해서 리뷰가 길어짐
3. 재사용 자산: 기존 PR 템플릿과 릴리즈 체크리스트

## Round 7

1. 원하는 이름:
   - `incident-triage`
   - `reviewer-handoff`
2. 문서 선호: 짧고 구조화된 Markdown
3. 대표 예시:
   - 입력: Sentry 이슈와 최근 PR 링크
   - 출력: 재현 단계, 의심 파일, 승인 요청 문구, 리뷰 요약 초안
