#!/bin/bash
# Author(s)     :  Daniel Kriesten
# Creation Date :  <Mo 24 Nov 2014 21:50:05 krid>
########################################################################

QUERY="{query}"

# the fstype to check for
FSTYPE="afpfs"

# list already mounted drives
MOUNTED_LIST=$(mount -t ${FSTYPE} 2>/dev/null |while read i; do echo ${i%% *}; done)

# the shares
SHARES_LIST="audiobooks data Documents Dropbox DVD-Images home music photo video"

# Initial for XML
OUTPUT="<?xml version=\"1.0\"?>"

# the beginning
OUTPUT+="\n<items>"

for SHARE in ${SHARES_LIST}; do
  if [[ "$MOUNTED_LIST" =~ "$SHARE" ]]; then
    continue
  fi
  if [[ -n "$QUERY" && "$SHARE" != *"$QUERY"* ]]; then
    continue
  fi
  OUTPUT="${OUTPUT}""\n<item uid=\"${SHARE}\" arg=\"afp://krid@diskstation/${SHARE}\" valid=\"yes\">\n<title>${SHARE}</title>\n<subtitle>Mount ${SHARE}</subtitle>\n</item>"
done

# the end
OUTPUT+="\n</items>"

echo -e ${OUTPUT}

# vim: ts=2:sw=2:tw=80:fileformat=unix
# vim: comments& comments+=b\:# formatoptions& formatoptions+=or
