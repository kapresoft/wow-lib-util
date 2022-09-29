#!/usr/bin/env bash

# Use Common Release Dir
RELEASE_DIR=~/.release
ADDON_NAME="Kapresoft-LibUtil"

Package() {
  local arg1=$1
  local rel_dir=$RELEASE_DIR
  # -c Skip copying files into the package directory.
  # -d Skip uploading.
  # -e Skip checkout of external repositories.
  # default: -cdzul
  # for checking debug tags: -edzul
  local rel_cmd="release-wow-addon -r ${RELEASE_DIR} -cdzul $*"
  local rel_cmd_package="release-wow-addon -r ${RELEASE_DIR} -d"

  if [[ "$arg1" == "-h" ]]; then
    echo "Usage: $0 [-o]"
    echo "Options:  "
    echo "  -o to keep existing release directory"
    exit 0
  fi

  if [[ -d ${RELEASE_DIR} ]]; then
    echo "$rel_dir dir exists"
    if [[ "$arg1" == "-r" ]]; then
      rel_cmd="${rel_cmd_package}"
    fi
  fi

  echo "Executing: $rel_cmd"
  eval "$rel_cmd"
}

SyncExtLib() {
  local cmd='rsync -aucv --progress --inplace --out-format="[Modified: %M] %o %n%L" "${RELEASE_DIR}/${ADDON_NAME}/External/" "./External/"'
  echo "Executing: $cmd"
  eval "$cmd"
}

Package $*
#SyncExtLib $*
#Package $* && SyncExtLib $*