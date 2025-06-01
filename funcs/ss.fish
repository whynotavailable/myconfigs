function ss-attach
    set targetPane (tmux list-sessions -F '#D:#{session_name}' | grep ":$argv[1]")

    if test -n "$targetPane"
        set actualPane (string split : $targetPane)[1]
        tmux switch-client -t "$actualPane"
    else
        return 1
    end

end

function ss
    set path (pwd)
    if test -n "$argv[1]"
        set sessionName "$argv[1]"
    else
        # TODO: This this as the basename if it's not in the home
        if test "$path" = "$HOME"
            set sessionName "sesh-$(uuidgen)"
        else
            set sessionName (path basename $PWD)
        end
    end

    ss-attach "$sessionName"

    if test $status -eq 0
        return
    end

    tmux new-session -d -s $sessionName

    ss-attach "$sessionName"
end

function ss-list
    for s in (tmux ls 2> /dev/null)
        set parts (string split : "$s")
        echo "$parts[1]"
    end
end

complete -c ss -f

complete -c ss -a "(ss-list)"
