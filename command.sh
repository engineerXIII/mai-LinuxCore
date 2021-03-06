#!/bin/bash

command=$1

function step_test() {
    cppcheck --enable=all *.c --enable=all --suppress=missingInclude --std=c11 | grep -C 1 "warning|error" 1>/dev/stderr;
}

function step_build() {
    cmake --build .build;
}

function step_run {
    ./.build/osLinux;
}

case "$command" in
  "ci")
    step_test;
    step_build;;
  "init")
    cmake -S. -B.build;;
  "test")
    step_test;;
  "build")
    step_build;;
  "run"|"start")
    step_run;;
esac