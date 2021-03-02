#!/bin/bash

# Variables
DIR=$(dirname `pwd`)
IGNORE=(script)

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

# symlinks to home
for SUBDIR in ${DIR}/*/ ; do
  if [[ ! ${IGNORE[*]} =~ `basename $SUBDIR` ]]
  then
    link_to_dir $SUBDIR "$HOME/."
  fi
done
