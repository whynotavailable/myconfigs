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

    git add -A

    if test -n "$argv[1]"
        # Test expansion here
        git commit -m "$argv"
    else
        git commit -m tap
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
