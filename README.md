# Dotfiles

This is a repo for my main dotfiles used in my personal WSL 2 Ubuntu setup.

The file ``setup.sh`` installs the main development packages and technologies, as well as it configures the zsh shell.

```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/gustavenrique/dotfiles/main/setup.sh)"
```

Once the setup script is executed, the powerful zsh can already be used with some cool features, such as:
- Fast syntax highlighting
- Auto suggestions
- Powershell-like text editing

![zsh](https://github.com/gustavenrique/dotfiles/assets/81171856/bbe07573-7e58-42e9-a467-91a8f7070ef6)

Besides that, a couple of programs will be installed, such as git, node, vim, docker, kubectl, fzf and others.

Feel free to use it and enjoy! 🙂

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
