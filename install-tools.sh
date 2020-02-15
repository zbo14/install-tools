#!/bin/bash -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
    curl \
    docker.io \
    git \
    net-tools \
    nmap \
    pass \
    pylint \
    python3-pip \
    shellcheck \
    tmux \
    vim

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
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install nvm
curl -o-  https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node 12.x LTS
nvm i 12.14.1

# Update npm
npm install -g npm

# Install packages
npm install -g \
  dnsdump \
  tldr

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

# Install Nikto
cd
rm -rf nikto
git clone https://github.com/sullo/nikto

# Install Sublist3r
cd
rm -rf Sublist3r
git clone https://github.com/aboul3la/Sublist3r
