# Ubuntu Setup

Here it sits the main configuration files for my personal WSL2 Ubuntu setup.

The file ``setup.sh`` holds the commands for setting up all you need. It installs the main development packages and technologies, as well as it configures the zsh.

An easy way of getting the job done is just executing the following in your brand new Linux shell:
```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/gustavenrique/ubuntu-setup/main/setup.sh)"
```

After installing everything, if you open the zsh in VS Code, you might notice that some characters don't display properly. If that's your case, you just need to go to ``Settings > Remote (WSL: Ubuntu)``, then in the Font Family field you paste the following: MesloLGS NF Regular. Notice you need to have the [MesloLGS font](https://github.com/romkatv/powerlevel10k#manual-font-installation) installed.

## WSL2 Setup

If you haven't yet installed the WSL 2 Ubuntu and it's using Windows 11, it can be easily done by pasting the following in your PowerShell:
```powershell
wsl --update
wsl --set-default-version 2
wsl --install
```

After creating the OS user, create the .wslconfig file:
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