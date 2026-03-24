# PATH base (evita duplicação)
fish_add_path $HOME/.local/bin

# PNPM
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME

# Docker
# set -gx DOCKER_HOST unix:///var/run/docker.sock

# Bun
set -gx BUN_INSTALL $HOME/.bun
fish_add_path $BUN_INSTALL/bin
