if status is-interactive
    # Commands to run in interactive sessions can go here
    set -p fish_function_path "$HOME/myconfigs/funcs/"
    set fish_greeting ""

    alias sa="tmux at"
end

function tap
    git c tap

    if test -n "$(git remote | grep origin)"
        git push
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
