#!/bin/bash
# File          :  filter-disks.sh
# Author(s)     :  Daniel Kriesten
# Email         :  daniel.kriesten@etit.tu-chemnitz.de
# Creation Date :  Mi 21 Mai 11:48:22 2014
########################################################################

# comma seperated list of fs-types, e.g msdos,afpfs
FSTYPE_LIST="msdos,afpfs"

MOUNTLIST=$(mount -t ${FSTYPE_LIST} 2>/dev/null |while read i; do echo ${i% \(*}; done)

# Initial for XML
OUTPUT="<?xml version=>\"1.0\"?>"

# the beginning
OUTPUT+="<items>"

# this seems ugly, but helps us reading mount points with spaces
OIFS="${IFS}"
IFS="
"
for MNT in ${MOUNTLIST}; do
  IFS=";" read -ra MNTPKT <<< "${MNT/ on /;}"
  THEMOUNTPOINT="${MNTPKT[1]##*/}"
  OUTPUT="${OUTPUT}""<item uid=\"${THEMOUNTPOINT/ /}\" arg=\"${MNTPKT[1]}\" valid=\"yes\"><title>${THEMOUNTPOINT}</title><subtitle>${MNTPKT[0]} mounted at ${MNTPKT[1]}</subtitle></item>"
done
IFS="${OIFS}"

# the end
OUTPUT+="</items>"

echo -e ${OUTPUT}

# vim: ts=2:sw=2:tw=80:fileformat=unix
# vim: comments& comments+=b\:# formatoptions& formatoptions+=or

