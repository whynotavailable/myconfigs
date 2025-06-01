# Attempt to attach to the target session. This requires a specific pane or you have to use the selector.
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
        # if a name is passed in use it.
        set sessionName "$argv[1]"
    else
        if test "$path" = "$HOME"
            # if it's the root use "home"
            set sessionName home
        else
            set sessionName (path basename $PWD)
        end
    end

    # If you are in a session, try and switch If that doesn't work, make it detached and switch to it.
    # Otherwise just use the -A flag on new session which will create it or attach if it already exists.
    if test -n "$TMUX"
        ss-attach "$sessionName"

        if test $status -eq 0
            return
        end

        tmux new-session -d -s $sessionName

        ss-attach "$sessionName"
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
