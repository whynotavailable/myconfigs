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

