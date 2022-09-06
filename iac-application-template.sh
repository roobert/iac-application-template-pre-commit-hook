#!/usr/bin/env bash

set -eo pipefail

if ! test -d "${IAC_BIN_DIR}"; then
  echo ERROR: IAC bin dir not found
  echo
  echo "Please set IAC_BIN_DIR!"
  exit 1
fi

set -u

if test -x "${IAC_BIN_DIR}/template.py"; then
  IAC_TEMPLATE="${IAC_BIN_DIR}/template.py"
else
  echo "ERROR: template.py not found or not executable!"
  exit 1
fi

ERROR_OCCURED="false"

for file in "$@"; do
  if ! grep -E "^module\/app\/([^\/]*)\/([^\/]*)\/.*$" <<< "${file}"; then
    continue
  fi

  APP=$(cut -d '/' -f 3 <<< "${file}")
  VERSION=$(cut -d '/' -f 4 <<< "${file}")

  OUTPUT=$("${IAC_TEMPLATE}" -a "${APP}" -v "${VERSION}" 2>&1)

  # shellcheck disable=SC2181
  if [[ $? -ne 0 ]]; then
    ERROR_OCCURED="true"
    echo
    echo "==> file: ${file}"
    echo
    echo "${OUTPUT}"
  fi
done

if [[ "${ERROR_OCCURED}" == "true" ]]; then
  exit 1
fi
