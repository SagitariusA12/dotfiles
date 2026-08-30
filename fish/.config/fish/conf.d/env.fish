# ==========================================
# PATH base
# ==========================================

fish_add_path $HOME/.local/bin


# ==========================================
# PNPM
# ==========================================

set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME


# ==========================================
# Docker
# ==========================================

# set -gx DOCKER_HOST unix:///var/run/docker.sock


# ==========================================
# Rust / Cargo
# ==========================================

set -gx CARGO_HOME $HOME/.cargo
fish_add_path $CARGO_HOME/bin


# ==========================================
# Go
# ==========================================

set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin


# ==========================================
# Neovim
# ==========================================

set -Ux EDITOR nvim
set -Ux NOTES_CLI_EDITOR nvim


# ==========================================
# Bun
# ==========================================

set -gx BUN_INSTALL $HOME/.bun
fish_add_path $BUN_INSTALL/bin


# ==========================================
# NVM / Node.js
# ==========================================

set -gx NVM_DIR $HOME/.nvm

function nvm
    bash -c 'source /usr/share/nvm/init-nvm.sh && nvm "$@"' -- $argv
end

# Adiciona o Node selecionado pelo alias "default" ao PATH
set -l nvm_node (bash -c 'source /usr/share/nvm/init-nvm.sh && nvm which default' 2>/dev/null)

if test -n "$nvm_node" -a -x "$nvm_node"
    fish_add_path (dirname $nvm_node)
end


# ==========================================
# UV / Python
# ==========================================

set -gx UV_INSTALL_DIR $HOME/.local/bin
fish_add_path $UV_INSTALL_DIR


# ==========================================
# Java
# ==========================================

set -gx JAVA_HOME /usr/lib/jvm/jdk-21.0.7-oracle-x64
fish_add_path $JAVA_HOME/bin
