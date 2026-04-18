---
name: incident-triage
version: 1.0.0
description: Turn a bug report into a reproducible, approval-safe triage summary.
---

# Incident Triage

언제 써야 하나:

- 버그 리포트, Sentry 이슈, 리뷰 코멘트가 들어왔을 때

언제 쓰면 안 되나:

- 운영 변경을 즉시 실행해야 할 때

트리거:

- `/incident-triage`
- "이 이슈 triage 해줘"

목적:

- 버그를 재현 가능한 작업 단위로 정리한다.

입력:

- 버그 설명
- 에러 메시지
- 관련 PR 또는 경로

단계:

1. 입력을 요약한다.
2. 읽기 전용 조사와 로컬 재현 경로를 제안한다.
3. 의심 파일과 가설을 정리한다.
4. 승인 없이 가능한 작업과 승인 필요한 작업을 분리한다.

출력:

- 재현 단계
- 의심 구간
- 승인 요청 문구

제약:

- `main` 직접 push 금지
- 운영 데이터 변경 금지
- 외부 메시지 전송 금지

실패 또는 에스컬레이션 조건:

- 재현 근거가 부족하면 추가 입력을 요청한다.
