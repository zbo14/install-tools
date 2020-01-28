#!/bin/bash -e

apt update
apt upgrade -y
apt install -y curl

# Install Node 12.x
curl -sL https://deb.nodesource.com/setup_12.x | bash -

apt install -y \
  docker.io \
  git \
  net-tools \
  nmap \
  nodejs \
  pass \
  pylint \
  python3-pip \
  shellcheck \
  tmux \
  vim

apt autoremove -y

# Remove Python2 and make Python3 the default
update-alternatives --remove python /usr/bin/python2
update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install tldr-pages
npm install -g tldr
