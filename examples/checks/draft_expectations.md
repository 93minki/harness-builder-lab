# Draft Expectations

이 persona를 입력으로 썼을 때 초안은 최소 아래 내용을 포함해야 한다.

## 필수 파일 제안

- `AGENTS.md`
- `tools/repro-bug.sh`
- `docs/workflows/incident-to-fix.md`
- `CLAUDE.md`
- `.claude/settings.json`
- `.claude/skills/incident-triage/SKILL.md`
- `.claude/skills/reviewer-handoff/SKILL.md`
- `cowork-skills/incident-triage/skill.json`
- `cowork-skills/incident-triage/prompt.md`
- `cowork-skills/incident-triage/README.md`

## 필수 근거

- macOS + zsh 환경을 반영해야 한다
- `bundle`, `pnpm`, `rg` 사용 맥락이 반영되어야 한다
- `main` 직접 push 금지, 운영 데이터 변경 금지, 외부 메시지 전송 금지가 반영되어야 한다
- 조사/초안 작성은 자율 가능하지만 코드 수정과 위험 명령은 승인 필요로 나와야 한다

## 필수 검증 계획

- JSON 파싱
- 생성 경로 존재 확인
- 스크립트 `Usage:` 주석 확인
- 플랫폼 간 금지 행동 일관성 확인
- placeholder 미잔존 확인
