#!/bin/bash

set -euo pipefail

images_script=${1:-}
if [ ! -f $images_script ]; then
  echo "You may add your images list filename as an argument."
  echo "E.g ./download-images.sh image-copy-list"
fi

commands="$(cat ${images_script} |grep imgpkg |sort |uniq)"

while IFS= read -r cmd; do
  echo -e "\nrunning $cmd\n"
  until $cmd; do
     echo -e "\nDownload failed. Retrying....\n"
     sleep 1
  done
done <<< "$commands"

