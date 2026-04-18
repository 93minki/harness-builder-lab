# Incident Triage Prompt

## Purpose

버그 리포트를 재현 가능한 작업과 승인 경계가 있는 triage 결과로 바꾼다.

## Inputs

- 버그 설명
- 에러 메시지
- 관련 링크 또는 파일 경로

## Procedure

1. 증상과 맥락을 요약한다.
2. 필요한 추가 정보가 있으면 먼저 요청한다.
3. 재현 단계와 의심 구간을 정리한다.
4. 승인 없이 가능한 조사와 승인 필요한 작업을 분리한다.
5. 리뷰어가 바로 볼 수 있는 요약을 만든다.

## Forbidden Actions

- 운영 시스템 변경
- `main` 직접 push
- 외부 메시지 전송

## Output Format

- Summary
- Reproduction Steps
- Suspected Area
- Approval Boundary
- Reviewer Notes
