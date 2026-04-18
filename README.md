# harness-builder

사용자 인터뷰를 통해 직무 맞춤형 하네스를 설계하고 생성하는 Claude Code용 배포 스킬.

생성 대상 플랫폼: **CODEX** / **Claude Code** / **Claude Cowork**

배포 형태는 현재 **Claude Code 스킬 1개**다.
즉, 사용자는 이 저장소의 `.claude/skills/harness-builder/SKILL.md`를 Claude Code 스킬로 설치한 뒤,
그 스킬을 사용해 CODEX용 / Claude Code용 / Claude Cowork용 하네스 산출물을 생성한다.

---

## 설치

현재 이 저장소가 직접 제공하는 설치 경로는 `Claude Code 스킬 설치`다.
CODEX는 생성 대상 플랫폼이지, 이 저장소가 별도로 제공하는 설치형 스킬 패키지는 아니다.
아래 명령은 이 저장소를 로컬에 내려받았거나, `.claude/skills/harness-builder/SKILL.md` 원본 파일을 이미 확보한 상태를 전제로 한다.

### Mac / Linux

**전역 설치 (모든 프로젝트에서 사용):**

```bash
mkdir -p ~/.claude/skills/harness-builder
cp .claude/skills/harness-builder/SKILL.md ~/.claude/skills/harness-builder/SKILL.md
```

**프로젝트별 설치 (특정 프로젝트에서만 사용):**

```bash
mkdir -p <your-project>/.claude/skills/harness-builder
cp .claude/skills/harness-builder/SKILL.md <your-project>/.claude/skills/harness-builder/SKILL.md
```

### Windows (PowerShell)

**전역 설치 (모든 프로젝트에서 사용):**

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\harness-builder"
Copy-Item ".claude\skills\harness-builder\SKILL.md" "$env:USERPROFILE\.claude\skills\harness-builder\SKILL.md"
```

**프로젝트별 설치 (특정 프로젝트에서만 사용):**

```powershell
New-Item -ItemType Directory -Force -Path "<your-project>\.claude\skills\harness-builder"
Copy-Item ".claude\skills\harness-builder\SKILL.md" "<your-project>\.claude\skills\harness-builder\SKILL.md"
```

---

## 설치 범위와 보장

- 이 저장소가 직접 배포하는 것은 `.claude/skills/harness-builder/SKILL.md` 하나다.
- 이 스킬은 Claude Code에 설치해서 사용한다.
- 스킬이 생성하는 결과물은 CODEX / Claude Code / Claude Cowork를 대상으로 할 수 있다.
- Windows 설치 명령은 "복사" 기준 안내다.
- 실제 하네스 생성 품질은 사용자 답변, 대상 저장소 상태, 기존 파일 충돌 여부에 따라 달라진다.
- 파일 생성은 항상 초안 확인과 명시적 승인 이후에만 수행된다.

## 사용법

설치 후 Claude Code를 사용하는 프로젝트 디렉토리에서:

```
/harness-builder
```

또는 자연어로:

> "하네스 만들어줘", "내 Claude Code 환경 설정해줘", "맞춤 하네스 설계해줘"

---

## 흐름

1. **플랫폼 선택** — CODEX / Claude Code / Claude Cowork 중 선택
2. **구조화 인터뷰** — 역할, 워크플로우, 실행 환경, 도구, 제약사항, 기존 자산 수집
3. **충분성 검사** — 정보가 부족하면 추가 질문
4. **초안 제시** — 생성될 파일, 근거, 검증 계획 미리보기
5. **승인 후 생성** — 현재 프로젝트 디렉토리에 파일 생성
6. **생성 후 검증** — JSON, 스크립트, 참조 경로, 제약 반영 여부 확인

---

## 스킬이 생성하는 출력 예시

아래는 생성 가능한 대표 산출물이다.
아래 구조는 배포물에 포함되지 않으며, 설치한 스킬이 사용자 프로젝트에 생성하는 예시다.
모든 플랫폼 파일을 항상 만드는 것이 아니라, 인터뷰 결과와 사용자 승인 범위에 따라 필요한 것만 생성한다.

**CODEX**
```
AGENTS.md                        # 에이전트 역할 및 지침
tools/
├── <task-name>.sh / .py         # 반복 업무별 실행 스크립트
docs/
├── templates/<doc-type>.md      # 자주 작성하는 문서 템플릿
└── workflows/<workflow>.md      # 멀티스텝 반복 워크플로우 설명
```

**Claude Code**
```
CLAUDE.md                                    # 프로젝트 지침
.claude/
├── settings.json                            # 권한, hooks, env 설정
└── skills/<name>/SKILL.md                   # 커스텀 스킬 (복수)
docs/templates/<doc-type>.md                 # 문서 템플릿 (필요 시)
```

**Claude Cowork**
```
cowork-skills/
└── <skill-name>/
    ├── skill.json     # 스킬 메타데이터 및 트리거
    ├── prompt.md      # 스킬 시스템 프롬프트
    └── README.md      # 설명 및 사용법
```

---

## 현재 상태

- `0.4.0`부터는 인터뷰 근거 강화, 저장소 탐색, 워크플로우별 승인 경계, 플랫폼별 출력 계약, 생성 후 검증 단계를 포함한다.
- 이 저장소는 템플릿 기반 코드 생성기가 아니라, 인터뷰 근거를 바탕으로 하네스를 설계하고 검증하는 생성 스킬이다.
- 기존 파일과 안전하게 병합할 수 없는 경우, 스킬은 임의 병합 대신 덮어쓰기/건너뛰기/새 이름 제안을 사용해야 한다.

## Examples

`examples/` 는 이 스킬이 만들 수 있는 결과물을 보여주는 참고 자료다.
사용자는 이 폴더를 가져갈 필요가 없고, 실제 설치에는 `.claude/skills/harness-builder/SKILL.md`만 있으면 된다.

- `examples/persona/interview_answers.md`: 예시 인터뷰 입력
- `examples/workflows/`: 예시 workflow 설명
- `examples/expected/`: 플랫폼별 결과물 예시
- `examples/checks/`: 예시 품질을 검토할 때 참고할 문서

이 저장소를 유지보수할 때는 예시와 실제 스킬 동작이 크게 어긋나지 않는지 확인하는 것이 좋다.

## 버전

현재 스킬 버전: `0.4.0`
