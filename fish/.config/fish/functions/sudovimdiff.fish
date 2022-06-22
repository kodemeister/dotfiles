function sudovimdiff --wraps=SUDO_EDITOR=\'nvim\ -d\'\ sudoedit --description alias\ sudovimdiff\ SUDO_EDITOR=\'nvim\ -d\'\ sudoedit
  SUDO_EDITOR='nvim -d' sudoedit $argv; 
end
