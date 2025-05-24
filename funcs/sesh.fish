set sessFile "$HOME/.sesh"
set tempSessFile "$HOME/.tempsesh"

function activate-sesh
    if test -z "$argv[1]"
        echo "Missing Session Name"
        return
    end

    for s in $sesh
        set parts (string split : $s)
        if test "$parts[1]" = "$argv[1]"
            cd "$parts[2]"
        end
    end

end

function sesh -d "Manage sessions"
    if test ! -e $sessFile
        touch $sessFile
    end

    for s in (cat $sessFile)
        if test -n "$s"
            set -a sessions "$s"
        end
    end

    # Init sesh file.
    argparse i/init=? l/list rmhere -- $argv
    or return

    if set -ql _flag_init
        if test -n "$_flag_init"
            set key "$_flag_init"
        else
            set ldir $(string split / $(pwd))
            set key "$ldir[-1]"
        end

        echo "$key:$(pwd)" >>$sessFile

        return
    end

    if set -ql _flag_list
        for s in $sessions
            set parts (string split : $s)
            echo $parts[1]
        end

        return
    end

    if set -ql _flag_rmhere
        rm -f $tempSessFile
        set found 0

        for s in $sessions
            set parts (string split : $s)
            if test "$(pwd)" = "$parts[2]"
                set found 1
            else
                echo $s >>$tempSessFile
            end
        end

        if test $found -eq 1
            mv $tempSessFile $sessFile
        else
            rm -f $tempSessFile
            echo "Current directory not found in session"
        end

        return
    end

    argparse --min-args=1 -- $argv
    or return

    set found 0
    for s in $sessions
        set parts (string split : $s)
        if test "$parts[1]" = "$argv[1]"
            set found 1
            cd "$parts[2]"
        end
    end

    if test $found -ne 1
        echo "No session found with key $argv[1]"
    end
end

complete -c sesh -l init
complete -c sesh -l list
complete -c sesh -l rmhere
complete -c sesh -a "(sesh --list)"
