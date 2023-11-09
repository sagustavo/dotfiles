# Dotfiles

Here it sits the main configuration files for my personal WSL 2 Ubuntu setup.

The file ``setup.sh`` installs the main development packages and technologies, as well as it configures the zsh shell.

```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/gustavenrique/dotfiles/main/setup.sh)"
```
---

# WSL2 Setup

If you'd like to install WSL 2 Ubuntu and it's using Windows 11, it can be easily done by pasting the following in your PowerShell:

```powershell
wsl --update
wsl --set-default-version 2
wsl --install
```

After creating the Linux user, create the .wslconfig file:
```bash
# Limit the resources that Ubuntu can use
touch /mnt/c/Users/YOUR_WINDOWS_USER/.wslconfig
code /mnt/c/Users/YOUR_WINDOWS_USER/.wslconfig
```

Then configure the wsl resources limits like this
```bash
[wsl2]
memory=8GB
processors=4
swap=4GB
```

Now you can execute the ``setup.sh`` script.
