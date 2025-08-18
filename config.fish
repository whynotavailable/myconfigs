if status is-interactive
    # Commands to run in interactive sessions can go here
    set -p fish_function_path "$HOME/myconfigs/funcs/"
    set fish_greeting ""

    alias sa="tmux at"
end

function tap
    if test -e "./.pre_tap.fish"
        fish ./.pre_tap.fish
    end

    if test -n "$argv[1]"
        git c "$argv[1]"
    else
        git c tap
    end

    if test -n "$(git remote | grep origin)"
        git push
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
