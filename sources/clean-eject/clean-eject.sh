#!/bin/bash

DRIVE="{query}"

# hack to allow running from commandline
if [[ "${DRIVE}" = "" ]]; then
  DRIVE="${1}"
fi

dot_clean -m --keep=mostrecent "${DRIVE}"

find "${DRIVE}" -name ".DS_Store" -exec rm {} \;

rm -f "${DRIVE}"/.VolumeIcon.icns
rm -Rf "${DRIVE}"/.fseventsd
rm -Rf "${DRIVE}"/.TemporaryItems
rm -Rf "${DRIVE}"/.Spotlight-V100
rm -Rf "${DRIVE}"/.Trashes

RET=$(diskutil eject "${DRIVE}" 2>&1)

if [[ $? -ne 0 ]]; then
  echo "${RET}"
  exit 1
fi

exit 0
