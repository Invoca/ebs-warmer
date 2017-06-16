#!/bin/bash

if [ -z "$1" ]; then
  echo "You must provide a glob matching the files to fault in"
  exit 1
fi

for filename in $(ls "$@"); do /usr/bin/fio --filename=$filename --rw=randread --bs=128k --iodepth=128 --ioengine=libaio --name=$filename; done
