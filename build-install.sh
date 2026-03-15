#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if git remote get-url upstream >/dev/null 2>&1; then
    _BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    [ -z "$_BRANCH" ] && _BRANCH="main"
    git fetch origin
    git reset --hard "origin/$_BRANCH"
fi

if [ ! -f package.json ]; then
    echo "Expected package.json in $(pwd)" >&2
    exit 1
fi

if [ ! -f index.ts ] && [ ! -f index.js ]; then
    echo "Expected extension entrypoint (index.ts or index.js) in $(pwd)" >&2
    exit 1
fi

printf 'Package prepared at: %s\n' "$(pwd)"
printf 'Pi installation is intentionally skipped by build-install.sh.\n'
