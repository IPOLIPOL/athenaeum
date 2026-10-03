#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

sbcl --non-interactive \
  --load src/model.lisp \
  --load src/html.lisp \
  --load src/build.lisp \
  --eval '(athenaeum.build:build-site)' \
  --quit