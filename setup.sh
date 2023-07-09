#!/bin/bash

GITHUB_ACCESS_TOKEN=

if [-z $GITHUB_ACCESS_TOKEN]
then
    echo 'Must provide credentials to get the dotfiles, because the repo is private'
else
    initial_setup
    install_node & install_docker_kind_and_k8s & install_zsh &
    wait
    setup_shell

    zsh

    git --version && node -v && npm -v && docker --version && kind --version && kubectl version
fi

# functions that do all the job
function initial_setup() {
    # update package list and download them
    sudo apt update && sudo apt -y upgrade

    # install essential packages for development
    sudo apt install -y build-essential
    sudo apt install -y git
}

function install_node() {
    curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

    sudo apt install -y nodejs
}

function install_docker_kind_and_k8s() {
    # install docker - https://docs.docker.com/engine/install/ubuntu/
    sudo sh -c "$(curl -fsSL https://get.docker.com)"

    sudo usermod -aG docker $USER

    # install kind - https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind

    # install k8s - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

function install_zsh() {
    # install zsh and oh my zsh - https://github.com/ohmyzsh/ohmyzsh
    sudo apt install -y zsh

    yes "n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # install p10k - https://github.com/romkatv/powerlevel10k#installation
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

    # install fonts for p10k
    sudo apt install -y fonts-powerline
}

function setup_shell() {
    # apply config files
    cd ~ && mkdir setup && cd setup

    git config --global user.email "gustax.dev@gmail.com"
    git config --global user.name "Gustavo H. S. Oliveira"

    git init
    echo -e "gustavenrique\n$GITHUB_ACCESS_TOKEN" | git clone https://github.com/gustavenrique/ubuntu-setup.git .

    # create symlink to reference the versioned files
    cd ~ && rm .bashrc .zshrc .p10k.zsh

    ln -s ~/setup/.bashrc ~/.bashrc
    ln -s ~/setup/.zshrc ~/.zshrc
    ln -s ~/setup/.p10k.zsh ~/.p10k.zsh
}