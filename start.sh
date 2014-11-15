#!/usr/bin/env bash

start_headless_firefox() {
  local disp=:99

  Xvfb ${disp} -shmem -screen 0 1024x768x24 2> /dev/null &
  DISPLAY=${disp} firefox 2> /dev/null &
}

start_sshd() {
  /usr/sbin/sshd -D
}

main() {
  start_headless_firefox
  start_sshd
}

main
