#!/usr/bin/env bash

set -euo pipefail

if ! test -d "${IAC_BIN_DIR}"; then
  echo ERROR: IAC bin dir not found
  echo
  echo "Please set IAC_BIN_DIR!"
  exit 1
fi

if test -x "${IAC_BIN_DIR}/template.py"; then
  IAC_TEMPLATE="${IAC_BIN_DIR}/template.py"
else
  echo "ERROR: template.py not found or not executable!"
  exit 1
fi

for file in "$@"; do
  if ! grep -E "^module\/app\/([^\/]*)\/([^\/]*)\/.*$" <<< "${file}"; then
    continue
  fi

  APP=$(cut -d '/' -f 3 <<< "${file}")
  VERSION=$(cut -d '/' -f 4 <<< "${file}")

  "${IAC_TEMPLATE}" -a "${APP}" -v "${VERSION}"
done
