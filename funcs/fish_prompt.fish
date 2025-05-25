function fish_prompt
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_char_dirtystate 1

    set_color $fish_color_cwd

    set path "$(pwd)"
    if test "$path" = "$HOME"
        echo -n "~"
    else
        echo -n (path basename $PWD)
    end

    set_color normal

    fish_git_prompt

    set_color $fish_color_comment
    echo -n ':> '
    set_color normal
end
