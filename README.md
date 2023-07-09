# Ubuntu Setup

Here it sits the main configuration files for my personal WSL2 Ubuntu setup.

The file ``setup.sh`` holds the commands for setting up all you need. It installs the main development packages and technologies, as well as it configures the zsh.

An easy way of getting the job done is just executing the following in your brand new Linux shell:
```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/gustavenrique/ubuntu-setup/main/setup.sh)"
```

After installing everything, if you open the zsh in VS Code, you might notice that some characters don't display properly:
![BUGGY TERMINAL]()

If that's your case, first make sure you have [MesloLGS font](https://github.com/romkatv/powerlevel10k#manual-font-installation) installed. Then you gotta go to ``VS Code > Settings > Remote (WSL: Ubuntu)``, then [paste the following in the Font Family field](https://youngstone89.medium.com/how-to-change-font-for-terminal-in-visual-studio-code-c3305fe6d4c2#:~:text=Press%20command%20%2B%20shift%20%2B%20P%20in,json%E2%80%9D%20and%20open%20it.&text=Here%2C%20you've%20got%20to,personal%20shell%20editor%20like%20iTerm.): ``MesloLGS NF Regular``.

Also if you come up with access errors while using Docker, give it a try to this command: ``sudo usermod -aG docker $USER``

If everything went as expected, you should have the following packages installed and your terminal should look like this:
![BEAUTY TERMINAL]()

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