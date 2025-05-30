function gc -d "Alias for git commit with -p flag to autopush"
    argparse --min-args=1 p/push -- $argv
    or return

    git add -A
    git commit -m $argv[1]

    if set -ql _flag_push
        git push
    end
end
