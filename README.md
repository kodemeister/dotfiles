# Dotfiles

This is a collection of my personal configuration files and scripts for GNU/Linux, macOS and WSL (Windows Subsystem for Linux), mostly focused on terminal Vim8/Neovim, tmux and Zsh. GUI versions and native Windows ports of Vim8/Neovim are also supported but some plugins won't work (most notably fzf and tmux stuff).

## Installation

### Ubuntu 17.10

1. Open terminal and install the required dependencies (replace `vim-gtk` with `neovim` if you want to use Neovim instead of Vim):
```
sudo apt-get install curl git python3 python3-neovim tmux vim-gtk xsel zsh
```
For C/C++ development:
```
sudo apt-get install clang cmake libclang-dev
```

2. Download fzf and ripgrep binaries and install them into `~/.local/bin` directory. Don't blindly copy the commands below! Pick up the latest [fzf](https://github.com/junegunn/fzf-bin/releases) and [ripgrep](https://github.com/BurntSushi/ripgrep/releases) builds matching your system architecture and adjust the paths accordingly. For example:
```
mkdir -p ~/.local/bin
curl -fLO "https://github.com/junegunn/fzf-bin/releases/download/0.17.3/fzf-0.17.3-linux_amd64.tgz"
curl -fLO "https://github.com/BurntSushi/ripgrep/releases/download/0.7.1/ripgrep-0.7.1-x86_64-unknown-linux-musl.tar.gz"
tar -xzf fzf-0.17.3-linux_amd64.tgz -C ~/.local/bin fzf
tar -xzf ripgrep-0.7.1-x86_64-unknown-linux-musl.tar.gz -C ~/.local/bin --strip-components=1 ripgrep-0.7.1-x86_64-unknown-linux-musl/rg
```

3. Clone this repository into any directory under `$HOME`, e.g. `~/.dotfiles`:
```
git clone https://github.com/kodemeister/dotfiles.git ~/.dotfiles
```

4. Run the installation script:
```
cd ~/.dotfiles
./install.sh
```
The script will download any additional stuff (Prezto, Vim plugins, tmux plugins) and create symlinks to dotfiles in your home directory. If you already have your own dotfiles in the home directory, the script will warn about conflicting files but won't overwrite them. **Check out for messages like "Warning: /home/user/.vimrc already exists, skipping"! If you see such warnings, backup and/or remove conflicting files and re-run the installation script.**

5. Make Zsh the default shell:
```
chsh -s /bin/zsh
```
Log out and log in to apply the changes.

6. Configure the font and color scheme of your terminal emulator.
* For correct display of Powerline symbols, you need to install a patched font. The installation script automatically installs patched Liberation Mono 1.07 font ("Literation Mono Nerd Font") into `~/.local/share/fonts`. Other patched fonts can be found in [powerline/fonts](https://github.com/powerline/fonts) or [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) repositories.
* Change your terminal color scheme to match Vim color scheme. A color scheme for URxvt is already provided in `~/.Xresources` configuration file. For other terminal emulators install a default color palette from [terminal.sexy](http://terminal.sexy) color scheme designer. Just open Export tab, pick your terminal from Format dropdown, press Export button and then Download. Finally, use the downloaded file to change color scheme in your terminal emulator.

### WSL (Windows Subsystem for Linux)

1. Install [WSLtty](https://github.com/mintty/wsltty/releases) terminal emulator.

2. For clipboard support install [VcXsrv](https://sourceforge.net/projects/vcxsrv) and run it. To start VcXsrv automatically on boot, copy VcXSrv shortcut to `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup` directory.

3. Run WSLtty and add a few PPAs with recent versions of Vim and tmux. This may not be necessary in newer WSL updates.
```
sudo add-apt-repository ppa:jonathonf/vim
sudo add-apt-repository ppa:sandvine/packages
sudo apt-get update
```

4. Install the required dependencies:
```
sudo apt-get install curl git python tmux vim-gtk xsel zsh
```

5. Download fzf and ripgrep binaries and install them into `~/.local/bin` directory. Don't blindly copy the commands below! Pick up the latest [fzf](https://github.com/junegunn/fzf-bin/releases) and [ripgrep](https://github.com/BurntSushi/ripgrep/releases) 64-bit builds and adjust the paths accordingly. For example:
```
mkdir -p ~/.local/bin
curl -fLO "https://github.com/junegunn/fzf-bin/releases/download/0.16.10/fzf-0.16.10-linux_amd64.tgz"
curl -fLO "https://github.com/BurntSushi/ripgrep/releases/download/0.5.2/ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz"
tar -xzf fzf-0.16.10-linux_amd64.tgz -C ~/.local/bin fzf
tar -xzf ripgrep-0.5.2-x86_64-unknown-linux-musl.tar.gz -C ~/.local/bin --strip-components=1 ripgrep-0.5.2-x86_64-unknown-linux-musl/rg
```

6. Clone this repository into any directory under `$HOME`, e.g. `~/.dotfiles`:
```
git clone https://github.com/kodemeister/dotfiles.git ~/.dotfiles
```

7. Run the installation script:
```
cd ~/.dotfiles
./install.sh
```
The script will download any additional stuff (Prezto, Vim plugins, tmux plugins) and create symlinks to dotfiles in your home directory. If you already have your own dotfiles in the home directory, the script will warn about conflicting files but won't overwrite them. **Check out for messages like "Warning: /home/user/.vimrc already exists, skipping"! If you see such warnings, backup and/or remove conflicting files and re-run the installation script.**

8. Open `~/.bashrc` in Vim and add the following lines to start Zsh automatically when opening WSLtty:
```
# Launch Zsh
if [ -t 1 ]; then
    env SHELL=/bin/zsh DISPLAY=localhost:0.0 /bin/zsh
fi
```
Restart WSLtty to apply the changes.

9. Configure the font and color scheme of WSLtty.
* For correct display of Powerline symbols, you need to install a patched font. I use Powerline Consolas from [runsisi/consolas-font-for-powerline](https://github.com/runsisi/consolas-font-for-powerline) repository. Other patched fonts can be found in [powerline/fonts](https://github.com/powerline/fonts) or [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) repositories.
* Change WSLtty color scheme to match Vim color scheme. To do this, install a default color palette from [terminal.sexy](http://terminal.sexy) color scheme designer. Just open Export tab, pick MinTTY from Format dropdown, press Export button and then Download. Finally, copy the downloaded file to `%APPDATA%\wsltty\themes` and select it in WSLtty Options -> Looks -> Theme setting.
* Make sure to set Options -> Terminal -> Type setting to `xterm-256color` for correct display of 256-color palette.
