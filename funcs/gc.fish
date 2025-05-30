function gc
    argparse p/push -- $argv
    or return

    argparse --min-args=1 -- $argv
    or return

    git add -A
    git commit -m $argv[1]

    if set -ql _flag_push
        git push
    end
end
