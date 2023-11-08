#!/bin/bash

initial_setup() {
    sudo apt update && sudo apt -y upgrade

    sudo apt install -y \
        build-essential \
        bc \
        curl \
        file \
        git \
        vim

    # homebrew
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

    install_main_packages
}

install_main_packages() {
    brew install -q \
        zsh-autosuggestions \
        fzf \
        npm node \
        docker kind kubectl
        # tmux \

    # install useful key bindings and fuzzy completion:
    yes | $(brew --prefix)/opt/fzf/install

    sudo usermod -aG docker $USER

    install_zsh
}

install_zsh() {
    # install zsh and oh my zsh - https://github.com/ohmyzsh/ohmyzsh
    brew install zsh

    yes "n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # install p10k - https://github.com/romkatv/powerlevel10k#installation
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

    # install fonts for p10k
    sudo apt install -y fonts-powerline

    setup_zsh
}

setup_zsh() {
    cd ~ && git clone https://github.com/gustavenrique/dotfiles.git ./dotfiles

    # create symlinks to reference the versioned files
    files=("bashrc" "zshrc" "p10k.zsh" "vimrc")

    for file in "${files[@]}"; do
        [ -e "~/.${file}" ] && rm "~/.${file}"

        ln -s "~/dotfiles/${file}" "~/.${file}"
    done

    # change default shell
    chsh -s $(which zsh)

    setup_ohmyzsh
}

setup_ohmyzsh() {
    # install ohmyzsh plugins
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    git clone https://github.com/dracula/zsh.git "$ZSH/themes/dracula-prompt"

    # install zinit
    yes "y" | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
}

initial_setup