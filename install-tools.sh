#!/bin/bash -e

apt update
apt upgrade -y
apt install -y curl

# Install Node 12.x
curl -sL https://deb.nodesource.com/setup_12.x | bash -

apt install -y \
  apt-transport-https \
  docker.io \
  enigmail \
  git \
  net-tools \
  nmap \
  nodejs \
  pylint \
  python3-pip \
  shellcheck \
  thunderbird \
  tmux \
  vim

# Remove Python2 and make Python3 the default
update-alternatives --remove python /usr/bin/python2
update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Tor
echo 'deb https://deb.torproject.org/torproject.org bionic main
deb-src https://deb.torproject.org/torproject.org bionic main' > /etc/apt/sources.list.d/tor.list

curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import
gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

apt update
apt install -y tor deb.torproject.org-keyring

echo 'DNSPort 53
SocksPort 9050' > /etc/tor/torrc

apt autoremove -y
