# Setup editor environment variables.
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

# Add user-wide bin directories to $fish_user_paths if they exist.
fish_add_path -g ~/.local/bin ~/bin

# Suppress the greeting message.
set fish_greeting

# Switch to Vi mode.
fish_vi_key_bindings

# Define cursor shapes for Vi mode.
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Advertise itself as a VTE-based terminal for cursor shapes to work.
set -x VTE_VERSION 6800

# Define useful key bindings for Vi mode.
bind -M insert \cy accept-autosuggestion
bind -M insert \cp up-or-search
bind -M insert \cn down-or-search

# Automatically install fundle on the first run.
if not functions -q fundle
  eval (curl -sfL https://git.io/fundle-install)
end

# Declare the required plugins.
fundle plugin jorgebucaran/autopair.fish
fundle plugin patrickf1/colored_man_pages.fish
fundle plugin IlanCosman/tide@v5
fundle init
