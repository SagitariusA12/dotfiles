if type -q starship && not functions -q fish_prompt_starship
    starship init fish | source
end
