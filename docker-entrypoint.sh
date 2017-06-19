#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "You must provide a list of files to fault in as arguments"
  exit 1
fi

for filename in $(ls "$@"); do /usr/bin/fio --filename=$filename --rw=randread --bs=128k --iodepth=128 --ioengine=libaio --direct=1 --name=$filename; done

if [ ! -z $NO_EXIT ]; then sleep infinity; fi
