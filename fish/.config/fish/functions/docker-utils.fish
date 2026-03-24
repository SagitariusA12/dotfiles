# Docker helper functions for Fish shell

function dps
    docker ps -a --format 'table {{.Names}}\\t{{.Status}}\\t{{.Image}}\\t{{.Ports}}'
end

function stopall
    set containers (docker ps -q)
    if test -z "$containers"
        echo "Nenhum container rodando"
    else
        docker stop $containers
    end
end

function dctx
    docker context show
end

function dctxls
    docker context ls
end

function dctxuse
    docker context use $argv[1]
end

function ddesktop
    docker context use desktop-linux
end

function ddefault
    docker context use default
end

function dpsx
    echo "Contexto:" (docker context show)
    docker ps -a --format 'table {{.Names}}\\t{{.Status}}\\t{{.Image}}\\t{{.Ports}}'
end

function dctxrun
    docker --context $argv[1] $argv[2..-1]
end
