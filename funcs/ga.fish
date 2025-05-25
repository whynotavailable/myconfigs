set -l gaCommands "s c cap"

function ga -V gaCommands
    argparse --min-args=1 -- $argv
    or return

    switch $argv[1]
        case s
            git status
        case c
            argparse --min-args=2 -- $argv
            or return

            git add -A
            git commit -m $argv[2]
        case cap
            argparse --min-args=2 -- $argv
            or return

            git add -A
            git commit -m $argv[2]
            git push
        case '*'
            echo "no valid command found. Valid options are ($gaCommands)"
    end
end

complete -c ga -f
complete -c ga -n "not __fish_seen_subcommand_from $gaCommands" -ra "$gaCommands"
