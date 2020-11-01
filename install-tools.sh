#!/bin/bash -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  curl \
  dirb \
  docker.io \
  git \
  hping3 \
  jq \
  net-tools \
  nmap \
  p7zip-full \
  pylint \
  python3-pip \
  shellcheck \
  tmux \
  vim \
  whois \
  xclip \
  zsh

sudo apt autoremove -y

# Remove Python2 and make Python3 the default
sudo update-alternatives --remove python /usr/bin/python2
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install pyenv
rm -rf ~/.pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv update

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node 12.x LTS
nvm i 12.19.0

# Update npm
npm install -g npm

# Install packages
npm install -g tldr

# Install rbenv
rm -rf ~/.rbenv
export PATH="$HOME/.rbenv/bin:/.rbenv/shims:$PATH"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv
src/configure
make -C src
eval "$(rbenv init -)"
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# Install ruby-build as rbenv plugin
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Install Go
cd ~/Downloads
curl -sSLO https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.3.linux-amd64.tar.gz
rm go1.15.3.linux-amd64.tar.gz

# Install amass
sudo snap install amass

# Install gitrob and gobuster
go get github.com/michenriksen/gitrob
go get github.com/OJ/gobuster

mkdir -p ~/Projects
cd ~/Projects

# Install dirsearch
git clone https://github.com/maurosoria/dirsearch.git

# Install masscan
git clone https://github.com/robertdavidgraham/masscan
cd masscan
make -j

# Install relative-url-extractor and sqlmap
git clone https://github.com/jobertabma/relative-url-extractor
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git
