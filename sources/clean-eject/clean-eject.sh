#!/bin/bash

dot_clean -m --keep=mostrecent "$@"

find "$@" -name ".DS_Store" -exec rm {} \;

rm -f "$@"/.VolumeIcon.icns
rm -Rf "$@"/.fseventsd
rm -Rf "$@"/.TemporaryItems
rm -Rf "$@"/.Spotlight-V100
rm -Rf "$@"/.Trashes

diskutil eject "$@">/dev/null

# vim: ts=2:sw=2:tw=80:fileformat=unix
# vim: comments& comments+=b\:# formatoptions& formatoptions+=or
