function fish_prompt
    set_color $fish_color_cwd

    set path "$(pwd)"
    if test "$path" = "$HOME"
        echo -n "~"
    else
        echo -n (path basename $PWD)
    end

    set_color normal

    echo -n '> '
end
