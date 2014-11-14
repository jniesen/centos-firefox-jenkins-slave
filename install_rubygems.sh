#!/usr/bin/env bash

fetch_rubygems() {
  local curdir=$(pwd)

  cd /usr/local/src \
    && wget http://production.cf.rubygems.org/rubygems/rubygems-${RUBYGEM_VERSION}.tgz \
    && tar zxvf rubygems-${RUBYGEM_VERSION}.tgz

  cd $curdir
}

run_setup() {
  local curdir=$(pwd)

  cd /usr/local/src/rubygems-${RUBYGEM_VERSION} \
    && /usr/local/bin/ruby setup.rb

  cd $curdir
}

verify() {
  gem -v || printf "\nSomething went horribly wrong!\n"
}

main() {
  fetch_rubygems
  run_setup
  verify
}

main
