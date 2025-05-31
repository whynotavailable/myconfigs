function ss
    if test -n "$TMUX"
        echo "already in a session lol"
        return
    end

    if test -n "$argv[1]"
        set sessionName "$argv[1]"
    else
        set sessionName "sesh-$(uuidgen)"
    end

    tmux new-session -A -s $sessionName
end

function ss-list
    for s in (tmux ls 2> /dev/null)
        set parts (string split : "$s")
        echo "$parts[1]"
    end
end

complete -c ss -f

complete -c ss -a "(ss-list)"
