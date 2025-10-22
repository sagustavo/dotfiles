#!/bin/bash

initial_setup() {
    # essential packages
    sudo apt update && sudo apt -y upgrade

    sudo apt install -y \
        build-essential gcc git neofetch \
        libxcb-xinerama0 libxcb-cursor0 libnss3 mpv mplayer \
        gnome-browser-connector copyq copyq-plugins \
        dconf-cli \
        bc cmake bat \
        curl \
        file

    # backup copyq config: /home/gusta/.config/autostart/copyq.desktop

    install_main_packages
}

install_main_packages() {
    # homebrew
    yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/${USER}/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    
    brew install -q \
        fzf \
        npm node \
        kind kubectl
        # zsh-autosuggestions \
        tmux \

    # install useful key bindings and fuzzy completion:
    yes | $(brew --prefix)/opt/fzf/install

    # docker
    sudo sh -c "$(curl -fsSL https://get.docker.com)"
    sudo chmod 666 /var/run/docker.sock
    sudo usermod -aG docker $USER

    install_dotnet
}

install_dotnet() {
    cd && wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    chmod +x ./dotnet-install.sh && ./dotnet-install.sh --version latest

    install_zsh
}

install_zsh() {
    # install zsh and oh my zsh - https://github.com/ohmyzsh/ohmyzsh
    sudo apt install -y zsh

    yes "n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # install p10k - https://github.com/romkatv/powerlevel10k#installation
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

    # install fonts for p10k
    sudo apt install -y fonts-powerline

    setup_zsh
}

setup_zsh() {
    cd ~ && git clone https://github.com/gustavenrique/dotfiles.git ./dotfiles

    # create symlinks to reference the versioned dotfiles
    files=("bashrc" "zshrc" "p10k.zsh" "vimrc", "XCompose")

    for file in "${files[@]}"; do
        [ -e ~/.${file} ] && rm -rf ~/.${file}

        ln -s ~/dotfiles/.${file} ~/.${file}
    done

    yes | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

    # change default shell
    chsh -s $(which zsh)

    # create symlinks for anki add-ons to ~/.local/share/Anki2/addons21

    # git clone git clone https://github.com/dracula/gnome-terminal ~/dev/dracula-gnome
    # cd ~/dev/dracula-gnome && ./install.sh -s Dracula -p Dracula --install-dircolors

    zsh
}

initial_setup
