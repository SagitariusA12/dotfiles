function nvim --description "Open Neovim without kitty padding and transparency"
    set -l sock (string replace -r '^unix:' '' -- $KITTY_LISTEN_ON)
    set -l remote (test -S "$sock"; and echo 1)

    if test -n "$remote"
        kitty @ --to $KITTY_LISTEN_ON set-spacing padding=0 2>/dev/null
        kitty @ --to $KITTY_LISTEN_ON set-background-opacity 1.0 2>/dev/null
    end

    command nvim $argv

    if test -n "$remote"
        kitty @ --to $KITTY_LISTEN_ON set-spacing padding=8 2>/dev/null
        kitty @ --to $KITTY_LISTEN_ON set-background-opacity 0.9 2>/dev/null
    end
end
