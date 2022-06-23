# Setup editor environment variables.
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

# Add user-wide bin directories to $fish_user_paths if they exist.
fish_add_path -g ~/.cabal/bin ~/.ghcup/bin ~/.local/bin ~/bin

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
fundle init
