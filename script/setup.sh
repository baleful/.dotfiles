#!/bin/bash

# Variables
DIR=$(dirname `pwd`)
IGNORE=(atom iterm2 script)

# FUnctions
link_to_dir() {
  for FILE in ${1}* ; do
    TARGET_FILENAME="${2}$(basename $FILE)"

    if [ -h "$TARGET_FILENAME" ]
    then
      unlink "$TARGET_FILENAME"
    fi

    ln -sfn "$FILE" "$TARGET_FILENAME"
  done
}

# atom
ln -sfn "$DIR/atom/" "$HOME/.atom/"

# iterm2
plutil -convert binary1 -o "$HOME/Library/Preferences/com.googlecode.iterm2.plist" "$DIR/iterm2/iterm2.plist"

# symlinks to home
for SUBDIR in ${DIR}/*/ ; do
  if [[ ! ${IGNORE[*]} =~ `basename $SUBDIR` ]]
  then
    link_to_dir $SUBDIR "$HOME/."
  fi
done
