#!/bin/bash -e

apt update
apt upgrade -y
apt install -y curl

# Install Node 12.x
curl -sL https://deb.nodesource.com/setup_12.x | bash -

apt install -y \
  git \
  net-tools \
  nmap \
  nodejs \
  python3-pip \
  socat \
  vim

# Remove Python2 and make Python3 the default
update-alternatives --remove python /usr/bin/python2
update-alternatives --install /usr/bin/python python /usr/bin/python3 10
