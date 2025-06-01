function gc -d "Alias for git commit with an autopush"
    argparse --min-args=1 -- $argv
    or return

    git add -A
    git commit -m $argv[1]

    git push
end
