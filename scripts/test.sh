#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

sbcl --non-interactive \
  --load src/model.lisp \
  --load tests/smoke.lisp \
  --quit