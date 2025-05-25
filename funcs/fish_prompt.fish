function fish_prompt
    set_color $fish_color_cwd

    set path "$(pwd)"
    if test "$path" = "$HOME"
        echo -n "~"
    else
        echo -n (path basename $PWD)
    end

    set_color normal

    set_color $fish_color_comment
    echo -n '> '
    set_color normal
end
