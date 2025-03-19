#!/bin/sh

if [ $# -eq 0 ]; then
  exec uniclip -p 53701
else
  exec uniclip "$@"
fi
