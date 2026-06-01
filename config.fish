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
        set msg (git diff --name-only --cached)
        set full tap "$msg"
        git commit -m $full
    end

    if test -n "$(git remote | grep origin)"
        git push
    end
end

function boom
    argparse f/force -- $argv
    or return

    if set -ql _flag_force
        set -e is_boom
    end

    if test -n "$is_boom"
        return
    end

    if test -e "./.env"
        for row in (cat './.env')
            set parts (string split --max=1 "=" "$row")
            set -gx "$parts[1]" "$parts[2]"
        end
        echo 'envs set'
    else
        echo 'no .env found'
    end

    if test -e "./.init.fish"
        source ./.init.fish
        echo init sourced
    else
        echo init missing
    end

    set -g is_boom boom
end

# bun
set --export BUN_INSTALL "$HOME/.bun"

# Created by `pipx` on 2025-09-22 12:50:04
set PATH $PATH /home/tom/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2026-02-26 11:18:59
set PATH $PATH /Users/bob/.local/bin
