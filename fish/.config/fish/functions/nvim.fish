function nvim --description "Open Neovim without kitty padding"
    kitty @ --to $KITTY_LISTEN_ON set-spacing padding=0
    command nvim $argv
    kitty @ --to $KITTY_LISTEN_ON set-spacing padding=8
end
