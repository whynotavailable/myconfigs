function sr -d "rename current session"
    set path "$(pwd)"
    if test "$path" = "$HOME"
        set sessionName HOME
    else
        set sessionName (path basename $PWD)
    end

    tmux command-prompt -I "$sessionName" 'rename-session "%1"'
end
