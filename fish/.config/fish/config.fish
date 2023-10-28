# Setup editor environment variables.
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

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
if not set -q VTE_VERSION
  set -x VTE_VERSION 7000
end

# Define useful key bindings for Vi mode.
bind -M insert \cy accept-autosuggestion
bind -M insert \cp up-or-search
bind -M insert \cn down-or-search

# Automatically install all plugins on the first run.
if not functions -q fisher && status is-interactive
  set fisher_url https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish
  curl -sL $fisher_url | source && fisher update
end
