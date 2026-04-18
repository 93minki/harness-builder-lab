#!/usr/bin/env bash
# Usage: ./tools/repro-bug.sh "<error text>" [path]

set -euo pipefail

ERROR_TEXT="${1:-}"
SEARCH_PATH="${2:-apps}"

if [ -z "$ERROR_TEXT" ]; then
  echo "error: missing error text"
  exit 1
fi

echo "Searching for error text in ${SEARCH_PATH}"
rg -n "$ERROR_TEXT" "$SEARCH_PATH"
