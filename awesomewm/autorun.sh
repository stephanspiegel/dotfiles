#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

# hide mouse cursor when not used
run unclutter --ignore-scrolling --timeout 2
