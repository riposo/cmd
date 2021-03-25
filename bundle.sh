#!/bin/bash

set -e
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
