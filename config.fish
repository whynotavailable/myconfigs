if status is-interactive
    # Commands to run in interactive sessions can go here
    set -p fish_function_path "$HOME/myconfigs/funcs/"
    set fish_greeting ""

    alias sa="tmux at"
end

function tap
    git add -A

    if test -n "$argv[1]"
        # Test expansion here
        git commit -m "$argv"
    else
        # claude -p "Generate a one or two line commit message based on current git diff, return only the message." | read msg
        git commit -m tap
    end

    if test -n "$(git remote | grep origin)"
        git push
    end
end

function clr
    clear && tmux clear-history
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2026-02-26 11:18:59
set PATH $PATH /Users/bob/.local/bin
