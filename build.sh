#!/bin/bash

set -e

BUILDARGS=()
PLUGINS=
SOURCE=
VERSION=

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --plugins)
      PLUGINS="$2"
      shift
      shift
      ;;
    --version)
      VERSION="$2"
      shift
      shift
      ;;
    --source)
      SOURCE="$2"
      shift
      shift
      ;;
    *)
      BUILDARGS+=("$1")
      shift
      ;;
  esac
done

# init project
go mod init github.com/riposo/cmd

# bundle
./bundle.sh "$PLUGINS"

# reference source path
if [ -d "$SOURCE" ]; then
  echo "replace github.com/riposo/riposo => $SOURCE" >> go.mod
fi

# fetch specific version
if [ ! -z "$VERSION" ]; then
  go get github.com/riposo/riposo@$VERSION
fi

# tidy
go mod tidy

# build
go build "${BUILDARGS[@]}"
