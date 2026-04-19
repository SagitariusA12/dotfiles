function reload
    # Recarrega variáveis e conf.d
    source ~/.config/fish/config.fish

    for f in ~/.config/fish/conf.d/*.fish
        source $f
    end

    # Recarrega todas as funções
    for f in ~/.config/fish/functions/*.fish
        source $f
    end

    echo "Fish recarregado ✔"
end
