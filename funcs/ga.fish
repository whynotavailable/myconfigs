function ga
    argparse --min-args=1 -- $argv
    or return

    if test $argv[1] = s
        git status
    else if test $argv[1] = c
        argparse --min-args=2 -- $argv
        or return

        git add -A
        git commit -m $argv[2]
    else if test $argv[1] = cap
        argparse --min-args=2 -- $argv
        or return

        git add -A
        git commit -m $argv[2]
        git push

    end
end

set -l gaCommands "s c cap"

complete -c ga -f
complete -c ga -n "not __fish_seen_subcommand_from $gaCommands" -ra "$gaCommands"
