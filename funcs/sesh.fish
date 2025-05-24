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
    # Init sesh file.
    argparse i/init=? l/list rmhere -- $argv
    or return

    if set -ql _flag_init
        echo init
        if test -n "$_flag_init"
            set key "$_flag_init"
        else
            set ldir $(string split / $(pwd))
            set key "$ldir[-1]"
        end

        set -aUu sesh "$key:$(pwd)"

        return
    end

    if set -ql _flag_list
        for s in $sesh
            if test -z "$s"
                continue
            end
            set parts (string split : $s)
            echo $parts[1]
        end

        return
    end

    if set -ql _flag_list
        for i in (seq (count $sesh))
            set parts (string split : $sesh[$i])
            # Probs useless but I don't care
            set path (pwd)
            if test "$path" = "$parts[2]"
                set -e sesh[$i]
                return
            end
        end
        echo "Current path not in session"

        return
    end

    argparse --min-args=1 -- $argv
    or return

    set found 0
    for s in $sesh
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
