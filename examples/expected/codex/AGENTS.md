# AI Tooling Harness

## Purpose

이 하네스는 버그 리포트를 재현 가능한 수정 작업으로 바꾸고,
리뷰어 핸드오프까지 준비하는 작업을 표준화한다.

## Allowed Actions

- 저장소 검색과 읽기
- 로컬 테스트 재현
- 초안 문서 생성

## Approval Required

- 코드 수정 적용
- 브랜치 조작
- 외부 네트워크 호출

## Forbidden Actions

- `main` 브랜치 직접 push
- 운영 데이터 변경
- 외부 서비스 메시지 전송

## Workflow Catalog

- `docs/workflows/incident-to-fix.md`

## Tool Catalog

- `tools/repro-bug.sh`: 재현 조사 시작용 스크립트

## Start Checklist

- 버그 입력이 있는지 확인
- 승인 경계를 먼저 확인
- 위험 작업 전 사용자 확인
