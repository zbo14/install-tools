#!/bin/bash -e

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
  cheese \
  curl \
  dirb \
  docker.io \
  esmtp \
  git \
  hping3 \
  jq \
  mutt \
  ncat \
  net-tools \
  nmap \
  pass \
  p7zip-full \
  pv \
  pylint \
  python3-pip \
  shellcheck \
  socat \
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

# Install latest release of asdf
asdf="$(wget https://github.com/asdf-vm/asdf/releases -O- 2>/dev/null)"
pattern='v[0-9]*\.[0-9]*\.[0-9]*'

[[ "$asdf" =~ $pattern ]]

version="${BASH_REMATCH[0]}"

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "$version"

# Add language plugins
~/.asdf/bin/asdf plugin-add deno
~/.asdf/bin/asdf plugin-add golang
~/.asdf/bin/asdf plugin-add nodejs
~/.asdf/bin/asdf plugin-add python
~/.asdf/bin/asdf plugin-add ruby
~/.asdf/bin/asdf plugin-add rust

# Remove Python2 and make Python3 the default
sudo update-alternatives --remove python /usr/bin/python2
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install latest stable Docker Compose
docker="$(wget https://docs.docker.com/compose/install/ -O- 2>/dev/null)"
pattern='https://github.com/docker/compose/releases/download/([0-9]*\.[0-9]*\.[0-9]*)'

[[ "$docker" =~ $pattern ]]

version="${BASH_REMATCH[1]}"

sudo curl -L "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install snaps
sudo snap install amass

mkdir -p ~/Projects
cd ~/Projects

# Install dirsearch
git clone https://github.com/maurosoria/dirsearch.git
