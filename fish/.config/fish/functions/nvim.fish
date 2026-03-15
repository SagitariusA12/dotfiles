function nvim --description "Open Neovim without kitty padding and transparency"
    kitty @ --to $KITTY_LISTEN_ON set-spacing padding=0
    kitty @ --to $KITTY_LISTEN_ON set-background-opacity 1.0

    command nvim $argv

    kitty @ --to $KITTY_LISTEN_ON set-spacing padding=8
    kitty @ --to $KITTY_LISTEN_ON set-background-opacity 0.9
end
