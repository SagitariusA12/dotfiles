set -gx PATH $HOME/.local/bin $PATH

# PNPM
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not contains $PNPM_HOME $PATH
    set -gx PATH $PNPM_HOME $PATH
end

# Bun
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH

if test -s "$HOME/.bun/_bun"
    source "$HOME/.bun/_bun"
end
