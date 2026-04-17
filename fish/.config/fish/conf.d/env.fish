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

# NVM (Node.js)
set -gx NVM_DIR $HOME/.nvm

# Java (Oracle JDK 21)
set -gx JAVA_HOME /usr/lib/jvm/jdk-21.0.7-oracle-x64
fish_add_path $JAVA_HOME/bin

function load_nvm
    bash -c "source $NVM_DIR/nvm.sh && nvm use default >/dev/null && env" | while read -l line
        set -l parts (string split -m 1 = -- $line)
        if test (count $parts) -eq 2
            switch $parts[1]
                case PWD SHLVL _
                    continue
                case '*'
                    set -gx $parts[1] $parts[2]
            end
        end
    end
end

load_nvm
