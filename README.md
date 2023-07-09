# Ubuntu Setup

Here it sits the main configuration files for my personal WSL2 Ubuntu setup.

The file ``setup.sh`` holds the commands for setting up all you need. It installs the main development packages and technologies, as well as it configures the zsh.

## Steps

0. If you don't have WSL2 installed, check out the [content down there](#wsl2-setup)

1. Execute this command in your brand new linux:
```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/gustavenrique/ubuntu-setup/main/setup.sh)"
```

2. After restarting the terminal, you should be using zsh by default. Now check if everything was installed correctly:
```bash
echo "Git: $(git --version)\n Node: $(node -v)\n NPM: $(npm -v)\n Docker: $(docker --version)\n Kind: $(kind --version)\n Kubernetes: $(kubectl version --output=json)"
```

3. After running a docker command, like ``docker ps``, if you face an access error, give it a try to this grant access command:
```bash
sudo usermod -aG docker $USER
```

4. Test zsh in VS Code

If you open the zsh in VS Code, you might notice that some characters don't display properly. If that's your case, first make sure you have [MesloLGS font](https://github.com/romkatv/powerlevel10k#manual-font-installation) installed. Then you gotta go to ``VS Code > Settings > Remote (WSL: Ubuntu)``, then [paste the following in the Font Family field](https://youngstone89.medium.com/how-to-change-font-for-terminal-in-visual-studio-code-c3305fe6d4c2#:~:text=Press%20command%20%2B%20shift%20%2B%20P%20in,json%E2%80%9D%20and%20open%20it.&text=Here%2C%20you've%20got%20to,personal%20shell%20editor%20like%20iTerm.): ``MesloLGS NF Regular``.

Hopefully now you're ready to go! 🥳

![final result](https://github.com/gustavenrique/ubuntu-setup/assets/81171856/d74943ac-6b54-4d4f-8116-544a62ddfad5)

---

# WSL2 Setup

If you haven't yet installed the WSL 2 Ubuntu and it's using Windows 11, it can be easily done by pasting the following in your PowerShell:
```powershell
wsl --update
wsl --set-default-version 2
wsl --install
```

After creating the Linux user, create the .wslconfig file:
```bash
# Limit the resources that Ubuntu can use
touch /mnt/c/Users/your_windows_user/.wslconfig
code /mnt/c/Users/your_windows_user/.wslconfig
```

Then finally paste the following
```bash
[wsl2]
memory=8GB
processors=4
swap=4GB
```

Now you can execute the ``setup.sh`` script.
