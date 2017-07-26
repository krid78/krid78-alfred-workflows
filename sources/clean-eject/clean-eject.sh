#!/bin/bash

# hack to allow testing on commandline
TMP="{query}"
DRIVE="${1:-$TMP}"

if [[ "$DRIVE" = "" ]]; then
  echo "No Drive Given"
  exit 1
fi

if [[ ! -d "${DRIVE}" ]]; then
  echo "Not a directory"
  exit 1
fi

dot_clean -m --keep=mostrecent "${DRIVE}"

find "${DRIVE}" -name \( ".DS_Store" -or -name "Thumbs.db" \) -exec rm {} \; 2>/dev/null

rm -f "${DRIVE}"/.VolumeIcon.icns
rm -f "${DRIVE}"/.apdisk
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
