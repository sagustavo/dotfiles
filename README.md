# Ubuntu Setup

Here it sits the main configuration files for my WSL 2 Ubuntu setup.

The file ``setup.sh`` holds the commands for setting up all you need. It installs the main development packages and technologies, as well as it configures your zsh terminal accordingly to what you're already familiar with.

A way of executing the script is creating a file and pasting the ``setup.sh`` content into it. Then you'd have to set the ``$GITHUB_ACCESS_TOKEN`` variable with the token generated in ``Github > Settings > Developer settings > Personal access tokens > Tokens (classic) > Generate new token``

After that, you can finally execute the script:
```bash
chmod +x setup.sh
sudo ./setup.sh
rm setup.sh
```

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