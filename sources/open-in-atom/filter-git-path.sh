THEFILE="$(/usr/bin/osascript << 'APPLESCRIPT'
tell application "Finder"
  set sel to the selection as text
  return POSIX path of sel
end tell
APPLESCRIPT)"

if [[ $? -ne 0 ]]; then
  exit 1
fi

THEPATH="${THEFILE%/*}"

if [[ -x "/usr/local/bin/git" ]]; then
  GITBIN=/usr/local/bin/git
elif [[ -x "/usr/bin/git" ]]; then
  GITBIN=/usr/bin/git
else
  exit 1
fi

pushd "${THEPATH}"

# try to get git project's toplevel
GIT_TOPLEVEL="$($GITBIN rev-parse --show-toplevel 2>/dev/null)"

if [[ $? -eq 0 ]]; then
  echo ${GIT_TOPLEVEL}
else
  echo "${THEFILE}"
fi

popd

# finally: open the Project and the file ...
# may be better split into single actions
/Applications/Atom.app/Contents/Resources/app/atom.sh "${GIT_TOPLEVEL}" "${THEFILE}"

unset THEFILE
unset THEPATH
unset GIT_TOPLEVEL

exit 0
