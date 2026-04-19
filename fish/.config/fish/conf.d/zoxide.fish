if type -q zoxide && not functions -q __zoxide_hook
    zoxide init fish | source
end
