#!/bin/bash

DRIVE="{query}"

# hack to allow running from commandline
if [[ "${DRIVE}" = "{query}" ]]; then
  DRIVE="${1}"
fi

if [[ "$DRIVE" = "" ]]; then
  exit 1
fi

dot_clean -m --keep=mostrecent "${DRIVE}"

find "${DRIVE}" -name ".DS_Store" -exec rm {} \; 2>/dev/null

rm -f "${DRIVE}"/.VolumeIcon.icns
rm -Rf "${DRIVE}"/.fseventsd
rm -Rf "${DRIVE}"/.TemporaryItems
rm -Rf "${DRIVE}"/.Spotlight-V100
rm -Rf "${DRIVE}"/.Trashes

# seems to only work for disks
#RET=$(diskutil eject "${DRIVE}" 2>&1)
RET=$(hdiutil detach "${DRIVE}" 2>&1)

if [[ $? -ne 0 ]]; then
  echo "${RET}"
  exit 1
fi

echo "${DRIVE}"

exit 0
