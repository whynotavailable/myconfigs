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

function sesh
    # Init sesh file.
    if test "$argv[1]" = --list
        for s in $sesh
            if test -z "$s"
                continue
            end
            set parts (string split : $s)
            echo $parts[1]
        end

        return
    end

    if test "$argv[1]" = --init
        if test -z "$argv[2]"
            set ldir $(string split / $(pwd))
            set key "$ldir[-1]"
        else
            set key "$argv[2]"
        end

        set -aUu sesh "$key:$(pwd)"

        return
    end

    if test "$argv[1]" = --rmhere
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

    activate-sesh $argv[(count $argv)]
end

complete -c sesh -l init
complete -c sesh -l list
complete -c sesh -l rmhere
complete -c sesh -a "(sesh --list)"
