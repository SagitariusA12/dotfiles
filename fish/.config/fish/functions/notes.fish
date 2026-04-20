# notes.fish — wrapper completo para notes-cli
# Coloque em ~/.config/fish/functions/ ou faça source deste arquivo no config.fish
#
# Dependências: notes-cli, fzf, ripgrep (rg), bat (opcional, para preview)
#
# Uso rápido:
#   n new <categoria> <nome>   → cria nota
#   n edit                     → abre nota com fzf
#   n find [query]             → busca no conteúdo com fzf
#   n delete                   → apaga nota com fzf
#   n rename                   → renomeia nota (via fzf)
#   n move                     → move nota para outra categoria (via fzf)
#   n preview                  → lista notas com preview do conteúdo
#   n template <categoria>     → cria nota a partir de template
#   n edit-template            → edita template de uma categoria
#   n sync ["mensagem"]        → git add + commit + push automático
#   n                          → sem args: abre fzf para editar

# ---------------------------------------------------------------------------
# Diretório home das notas (respeita a config do notes-cli)
# ---------------------------------------------------------------------------
function __notes_home
    set -l home (notes config home 2>/dev/null)
    if test -z "$home"
        echo "$HOME/notes"
    else
        echo $home
    end
end

# ---------------------------------------------------------------------------
# Picker fzf genérico — recebe lista via stdin, devolve linha escolhida
# ---------------------------------------------------------------------------
function __notes_pick
    set -l prompt $argv[1]
    set -l preview_cmd $argv[2]

    if test -n "$preview_cmd"
        fzf --prompt="$prompt " \
            --preview="$preview_cmd" \
            --preview-window=right:60%:wrap \
            --height=80% \
            --layout=reverse
    else
        fzf --prompt="$prompt " \
            --height=60% \
            --layout=reverse
    end
end

# ---------------------------------------------------------------------------
# Função principal: n
# ---------------------------------------------------------------------------
function n --description "Wrapper avançado para notes-cli"
    set -l cmd $argv[1]
    set -l rest $argv[2..]

    switch $cmd

        # ── sem argumento: fzf para editar ──────────────────────────────
        case ""
            set -l note (notes list 2>/dev/null | __notes_pick "editar nota:" "bat --color=always --style=plain {} 2>/dev/null || cat {}")
            test -n "$note" && $EDITOR $note

        # ── new ──────────────────────────────────────────────────────────
        case new
            notes new $rest

        # ── edit: fzf para escolher e abrir ──────────────────────────────
        case edit
            set -l note (notes list 2>/dev/null | __notes_pick "editar nota:" "bat --color=always --style=plain {} 2>/dev/null || cat {}")
            test -n "$note" && $EDITOR $note

        # ── find: busca no conteúdo com rg + fzf ─────────────────────────
        case find search
            set -l home (__notes_home)
            set -l query $rest

            if test -n "$query"
                set -l match (rg -l "$query" $home 2>/dev/null | head -1)
                if test -n "$match"
                    $EDITOR $match
                else
                    echo "Nenhuma nota contém: $query"
                end
            else
                set -l note (
                    rg --line-number --color=never --no-heading "" $home 2>/dev/null \
                    | __notes_pick "buscar conteúdo:" "echo {} | cut -d: -f1 | xargs bat --color=always --style=plain 2>/dev/null"
                )
                if test -n "$note"
                    set -l file (echo $note | cut -d: -f1)
                    test -n "$file" && $EDITOR $file
                end
            end

        # ── delete: fzf + confirmação ────────────────────────────────────
        case delete del rm
            set -l note (notes list 2>/dev/null | __notes_pick "apagar nota:" "bat --color=always --style=plain {} 2>/dev/null || cat {}")
            if test -n "$note"
                read -l -P "Apagar $note? [s/N] " confirm
                if test "$confirm" = s -o "$confirm" = S
                    rm "$note"
                    echo "Apagado: $note"
                end
            end

        # ── rename ────────────────────────────────────────────────────────
        case rename mv
            set -l note (notes list 2>/dev/null | __notes_pick "renomear nota:" "bat --color=always --style=plain {} 2>/dev/null || cat {}")
            if test -n "$note"
                set -l dir (dirname $note)
                set -l ext (string match -r '\.[^.]+$' $note)
                read -l -P "Novo nome (sem extensão): " newname
                if test -n "$newname"
                    # atualiza título Setext dentro do arquivo
                    set -l underline (string repeat -n (string length $newname) "=")
                    set -l tmpfile (mktemp)
                    awk -v title="$newname" -v ul="$underline" \
                        'NR==1{print title; next} NR==2{print ul; next} {print}' \
                        "$note" > $tmpfile
                    mv $tmpfile "$note"
                    mv "$note" "$dir/$newname$ext"
                    echo "Renomeado para: $dir/$newname$ext"
                end
            end

        # ── move: muda de categoria (subdiretório) ────────────────────────
        case move
            set -l note (notes list 2>/dev/null | __notes_pick "mover nota:" "bat --color=always --style=plain {} 2>/dev/null || cat {}")
            if test -n "$note"
                set -l home (__notes_home)
                set -l cat (notes categories 2>/dev/null | __notes_pick "categoria destino:")
                if test -n "$cat"
                    set -l dest "$home/$cat"
                    mkdir -p $dest
                    mv "$note" "$dest/"
                    echo "Movido para: $dest/"
                end
            end

        # ── preview: lista com snippet ────────────────────────────────────
        case preview ls list
            notes list 2>/dev/null | while read -l path
                set -l rel (string replace (__notes_home)"/" "" $path)
                set -l snippet (head -5 $path 2>/dev/null | string trim)
                echo "── $rel"
                echo $snippet | string replace -r "^" "   "
                echo ""
            end | less -R

        # ── template ──────────────────────────────────────────────────────
        case template tmpl
            set -l home (__notes_home)
            set -l tmpl_dir "$home/.templates"
            mkdir -p $tmpl_dir

            set -l cat $rest[1]
            if test -z "$cat"
                set cat (notes categories 2>/dev/null | __notes_pick "categoria:")
                test -z "$cat" && return 1
            end

            set -l tmpl_file "$tmpl_dir/$cat.md"

            # template padrão sem título — será inserido dinamicamente
            if not test -f "$tmpl_file"
                printf "" > $tmpl_file
                echo "tags: "             >> $tmpl_file
                echo "data: {{DATA}}"     >> $tmpl_file
                echo ""                   >> $tmpl_file
                echo "## Conteúdo"        >> $tmpl_file
                echo ""                   >> $tmpl_file
                echo "(Template criado: $tmpl_file — edite-o para personalizar)"
            end

            read -l -P "Nome da nota: " notename
            if test -n "$notename"
                set -l dest "$home/$cat/$notename.md"
                mkdir -p "$home/$cat"

                # cabeçalho Setext exigido pelo notes-cli
                set -l underline (string repeat -n (string length $notename) "=")
                echo $notename   > $dest
                echo $underline >> $dest

                # corpo do template com {{DATA}} substituído
                cat $tmpl_file | sed "s/{{DATA}}/"(date +%Y-%m-%d)"/g" >> $dest

                $EDITOR $dest
            end

        # ── edit-template: edita o template de uma categoria ─────────────
        case edit-template
            set -l home (__notes_home)
            set -l tmpl_dir "$home/.templates"
            mkdir -p $tmpl_dir
            set -l cat (notes categories 2>/dev/null | __notes_pick "categoria do template:")
            if test -n "$cat"
                set -l tmpl_file "$tmpl_dir/$cat.md"
                if not test -f "$tmpl_file"
                    printf ""            > $tmpl_file
                    echo "tags: "       >> $tmpl_file
                    echo "data: {{DATA}}" >> $tmpl_file
                    echo ""             >> $tmpl_file
                    echo "## Conteúdo" >> $tmpl_file
                end
                $EDITOR $tmpl_file
            end

        # ── sync: git add + commit com timestamp + push ───────────────────
        case sync save
            set -l msg $rest[1]
            if test -z "$msg"
                set msg "sync "(date "+%Y-%m-%d %H:%M")
            end
            notes save --message "$msg" 2>/dev/null
            set -l home (__notes_home)
            if git -C $home remote | grep -q .
                git -C $home push
                echo "Push concluído."
            end

        # ── help ──────────────────────────────────────────────────────────
        case help --help -h
            echo "n — wrapper para notes-cli"
            echo ""
            echo "Comandos:"
            echo "  n                        abre fzf para editar nota"
            echo "  n new <cat> <nome>       cria nota (via notes-cli)"
            echo "  n edit                   fzf → abre no editor"
            echo "  n find [query]           busca no conteúdo (rg + fzf)"
            echo "  n delete                 fzf → apaga com confirmação"
            echo "  n rename                 fzf → renomeia nota e atualiza título"
            echo "  n move                   fzf → move de categoria"
            echo "  n preview                lista com snippet do conteúdo"
            echo "  n template [cat]         cria nota a partir de template"
            echo "  n edit-template          edita template de uma categoria"
            echo "  n sync [\"mensagem\"]      git add + commit + push"
            echo ""
            echo "Passthrough: qualquer outro subcomando é repassado ao notes-cli"
            echo "  n list, n categories, n tags, n config ..."

        # ── passthrough: repassa para notes-cli ───────────────────────────
        case "*"
            notes $cmd $rest

    end
end
