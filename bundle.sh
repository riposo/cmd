#!/bin/bash

set -e
output=bundle.go
modules=()

cat > $output <<EOF
package main

import (
	_ "github.com/riposo/riposo"
EOF

for arg in "$@"
do
  for mod in $(echo "$arg" | tr "," "\n")
  do
    if [[ ! $mod =~ \/ ]]; then
      mod="github.com/riposo/$mod"
    fi
    if [[ $mod =~ ^[-[:alnum:]]*\/ ]]; then
      mod="github.com/$mod"
    fi
    package=$(echo "$mod" | cut -d'@' -f 1)
    echo '	_ "'$package'"' >> $output

    modules+=($mod)
  done
done
echo ")" >> $output

gofmt -w $output
for mod in "${modules[@]}"
do
  go get $mod
done
