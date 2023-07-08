#!/bin/bash

# update package list and download them
sudo apt update && sudo apt upgrade

# install essential packages for development
sudo apt install build-essential

# install git node and npm
sudo apt install git node npm

npm i -g npm n && n lts

# install docker - https://docs.docker.com/engine/install/ubuntu/
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker $USER

# install kind - https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# install k8s - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install zsh and oh my zsh - https://github.com/ohmyzsh/ohmyzsh
sudo apt install -y zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install p10k - https://github.com/romkatv/powerlevel10k#installation
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install fonts for p10k
sudo apt install -y fonts-powerline

# apply config files
cd ~ && mkdir setup && cd setup

git config --global user.email "gustax.dev@gmail.com"
git config --global user.name "Gustavo H. S. Oliveira" 

git init
git clone https://github.com/gustavenrique/ubuntu-setup.git

mv ./ubuntu-setup/{.,}* .
rmdir ubuntu-setup

# create symlink to reference the versioned files
cd ~ && rm .bashrc .zshrc .p10k.zsh

ln -s ~/setup/.bashrc ~/.bashrc
ln -s ~/setup/.zshrc ~/.zshrc
ln -s ~/setup/.p10k.zsh ~/.p10k.zsh

# check if everything is working fine
zsh

git --version
node --version
npm --version
docker --version
kind --version
kubectl client --version