#!/usr/bin/env bash

RB_MAJ_VERSION=$(echo ${RUBY_VERSION} | cut -d. -f1)
RB_MIN_VERSION=$(echo ${RUBY_VERSION} | cut -d. -f2)
RB_TNY_VERSION=$(echo ${RUBY_VERSION} | cut -d. -f3)
RB_PATCH_VERSION=$(echo ${RUBY_VERSION} | cut -s -dp -f2)

fetch_ruby() {
  local curdir=${pwd}

  cd /usr/local/src \
    && wget ftp://ftp.ruby-lang.org/pub/ruby/${RB_MAJ_VERSION}.${RB_MIN_VERSION}/ruby-${RUBY_VERSION}.tar.gz \
    && tar zxvf ruby-${RUBY_VERSION}.tar.gz

  cd $curdir
}

configure_make_install() {
  local curdir=${pwd}

  cd /usr/local/src/ruby-${RUBY_VERSION} \
    && ./configure --disable-install-doc \
    && make \
    && make install

  cd $curdir
}

cleanup() {
  rm -rf /usr/local/src/ruby-${RUBY_VERSION}
  rm -f /usr/local/src/ruby-${RUBY_VERSION}.tar.gz
}

verify() {
  ruby -v || printf "\nSomething went horribly wrong!\n"
}

main() {
  fetch_ruby
  configure_make_install
  cleanup
  verify
}

main
