# centos-firefox-jenkins-slave

Builds CentOS based image with headless Firefox that can be used as a Jenkins slave node.

Usage
=====

```shell
  git clone this repo.
  cd centos-firefox-jenkins-slave
```
Supply an id_rsa key pair to the root of this project for use with github or other third party integration.
Replace wildcard Host in the ssh config file.

```shell
  docker build -t <your tag> .
```
