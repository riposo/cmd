#!/bin/bash

set -e

function usage() {
    cat <<EOF
To bundle plugins:
    $0 PLUGIN...

Example:
    $0 accounts flush custom/repo test.host/custom/repo
EOF
}

if [ -z "$1" ]; then
  usage
  exit 1
fi

output=bundle.go

cat > $output <<EOF
package main

import (
	_ "github.com/riposo/riposo"
EOF

for arg in "$@"
do
  for plugin in $(echo "$arg" | tr "," "\n")
  do
    if [[ $plugin =~ ^[-_[:alnum:]]*$ ]]; then
      plugin="github.com/riposo/$plugin"
    fi
    if [[ $plugin =~ ^[-[:alnum:]]*\/ ]]; then
      plugin="github.com/$plugin"
    fi
    echo '	_ "'$plugin'"' >> $output
  done
done
echo ")" >> $output

gofmt -w $output
