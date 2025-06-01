function ss
    if test -n "$argv[1]"
        set sessionName "$argv[1]"
    else
        set sessionName "sesh-$(uuidgen)"
    end

    if test -n "$TMUX"
        echo "already in a session, setting as detached"
        tmux new-session -d -s $sessionName
    else
        tmux new-session -A -s $sessionName
    end

end

function ss-list
    for s in (tmux ls 2> /dev/null)
        set parts (string split : "$s")
        echo "$parts[1]"
    end
end

complete -c ss -f

complete -c ss -a "(ss-list)"
