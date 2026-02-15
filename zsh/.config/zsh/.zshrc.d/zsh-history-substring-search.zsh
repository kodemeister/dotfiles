# Use Up/Down arrow keys to search the command history.
for key in ${terminfo[kcuu1]} '^[[A' '^[OA'; do
  [[ -n ${key} ]] && bindkey ${key} history-substring-search-up
done
for key in ${terminfo[kcud1]} '^[[B' '^[OB'; do
  [[ -n ${key} ]] && bindkey ${key} history-substring-search-down
done

# Tweak search highlight colors for better readability.
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold,standout'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold,standout'
