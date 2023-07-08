# Ubuntu Setup

Here it sits the main configuration files for my WSL 2 Ubuntu setup.

The file ``setup.sh`` holds the commands for setting up all you need. It installs the main development packages and technologies, as well as it configures your zsh terminal accordingly to what you're already familiar with.

The easiest way to get the job done is just copying the file content, then pasting it in your Ubuntu shell.

## WSL2 Setup

In powershell, paste the following

```powershell
wsl --update
wsl --set-default-version 2
wsl --install
```

Now in the Ubuntu terminal
```bash
# Limit the resources that Ubuntu can use
touch /mnt/c/Users/gusta/.wslconfig
code /mnt/c/Users/gusta/.wslconfig
```

Paste the following in the .wslconfig
```bash
[wsl2]
memory=8GB
processors=4
swap=4GB
```