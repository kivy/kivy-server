#!/usr/bin/env bash
set -e

while [ ${#} -gt 0 ]; do
  case "${1}" in
    -d|--directory)
    DIRECTORY="${2}"
    shift
    ;;
    --older-than)
    OLDER_THAN="${2}"
    shift
    ;;
    --keep-last)
    KEEP_LAST="${2}"
    shift
    ;;
  esac
  shift
done

DIRECTORY="${DIRECTORY:-.}"
OLDER_THAN="${OLDER_THAN:-0}"
KEEP_LAST="${KEEP_LAST:-0}"

cd "${DIRECTORY}" || exit 1

if ! ls -U *whl 1> /dev/null 2>&1; then
  exit
fi

if [ "${KEEP_LAST}" -gt 0 ]; then
  EXCLUDE=$(printf "! -name %s " $(ls -t *.whl | head -"${KEEP_LAST}"))
fi

find . -maxdepth 1 -type f -mtime +"${OLDER_THAN}" -name "*.whl" "${EXCLUDE}" -exec rm -- {} \;
