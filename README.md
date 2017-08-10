# Dotfiles

This is a collection of my personal configuration files and scripts for GNU/Linux, macOS and WSL (Windows Subsystem for Linux), mostly focused on terminal Vim8/Neovim, tmux and Zsh. GUI versions and native Windows ports of Vim8/Neovim are also supported but some plugins won't work (most notably fzf and tmux stuff).

## Installation

### Ubuntu 16.04

1. Open terminal and add a few PPAs with recent versions of Vim and tmux. This may not be necessary in newer Ubuntu releases.
```
sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:sandvine/packages
sudo apt-get update
```

2. Install the required dependencies:
```
sudo apt-get install curl git python tmux vim-gtk xsel zsh
```

3. Download fzf and ripgrep binaries and install them into `~/.local/bin` directory. Don't blindly copy the commands below! Pick up the latest builds matching your system architecture from [fzf](https://github.com/junegunn/fzf-bin/releases) and [ripgrep](https://github.com/BurntSushi/ripgrep/releases) GitHub pages and adjust the paths accordingly. For example:
```
mkdir -p ~/.local/bin
curl -fLO "https://github.com/junegunn/fzf-bin/releases/download/0.16.10/fzf-0.16.10-linux_amd64.tgz"
curl -fLO "https://github.com/BurntSushi/ripgrep/releases/download/0.5.2/ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz"
tar -xzf fzf-0.16.10-linux_amd64.tgz -C ~/.local/bin fzf
tar -xzf ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz -C ~/.local/bin --strip-components=1 ripgrep-0.5.2-x86_64-unknown-linux-musl/rg
```

4. Clone this repository into any directory under `$HOME`, e.g. `~/.dotfiles`:
```
git clone https://github.com/toiffel/dotfiles.git ~/.dotfiles
```

5. Run the installation script:
```
cd ~/.dotfiles
./install.sh
```
The script will download any additional stuff (Prezto, Vim plugins, tmux plugins) and create symlinks to dotfiles in your home directory. If you already have your own dotfiles in the home directory, the script will warn about conflicting files but won't overwrite them. **Check out for messages like "Warning: /home/user/.vimrc already exists, skipping"! If you see such warnings, backup and/or remove conflicting files and re-run the installation script.**

6. Make Zsh the default shell:
```
chsh -s /bin/zsh
```
Log out and log in to apply the changes.

7. Configure the font and color scheme of your terminal emulator.
* For correct display of Powerline symbols, you need to install a patched font. The installation script automatically installs patched Liberation Mono 1.07 font ("Literation Mono Nerd Font") into `~/.local/share/fonts`. Other patched fonts can be found in [powerline/fonts](https://github.com/powerline/fonts) or [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) repositories.
* For better visual experience change your terminal color scheme to match Vim color scheme. For URxvt use `~/.Xresources` configuration file that comes within this repository. For st you may check my custom `config.h` file located in a separate [repository](https://github.com/toiffel/st). For other terminals install a default color palette from [terminal.sexy](http://terminal.sexy) color scheme designer. Just open Export tab, pick your terminal from Format dropdown, press Export button and then Download. Finally, use the downloaded file to change color scheme in your terminal emulator.
