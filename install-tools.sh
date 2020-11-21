#!/bin/bash -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  curl \
  dirb \
  docker.io \
  esmtp \
  git \
  hping3 \
  jq \
  mutt \
  net-tools \
  nmap \
  pass \
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

# Download tmux plugins
rm -rf ~/.tmux
mkdir ~/.tmux ~/.tmux/plugins
git clone --quiet https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Oh My Zsh and powerlevel10k theme
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

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

# Install Node 12.x LTS as default
nvm i 14.15.1
nvm alias default 14.15.1

# Update npm and install packages
npm i -g npm tldr

# Install rbenv
rm -rf ~/.rbenv
export PATH="$HOME/.rbenv/bin:/.rbenv/shims:$PATH"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv
src/configure
make -C src
eval "$(rbenv init -)"

# Install ruby-build as rbenv plugin
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Run rbenv doctor
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# Install goenv
rm -rf ~/.goenv
export PATH="$HOME/.goenv/bin:$PATH"

git clone https://github.com/syndbg/goenv.git ~/.goenv
eval "$(goenv init -)"

# Install latest version of Go
goenv install 1.15.3
goenv global 1.15.3

# Install amass
sudo snap install amass

# Install ffuf and subfinder
go get -u -v github.com/ffuf/ffuf
GO111MODULE=on go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder

mkdir -p ~/Projects
cd ~/Projects

# Install dirsearch
git clone https://github.com/maurosoria/dirsearch.git
