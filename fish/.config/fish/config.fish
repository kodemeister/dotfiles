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
