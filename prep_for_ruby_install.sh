#!/usr/bin/env bash

# Install Dev tools and other devel libs
yum -y groupinstall "Development Tools"
yum -y install \
  libxslt-devel \
  libyaml-devel \
  libxml2-devel \
  gdbm-devel \
  libffi-devel \
  zlib-devel \
  openssl-devel \
  libyaml-devel \
  readline-devel \
  curl-devel \
  openssl-devel \
  pcre-devel \
  memcached-devel \
  valgrind-devel \
  mysql-devel \
  ImageMagick-devel \
  ImageMagick \
  wget \
  tar

