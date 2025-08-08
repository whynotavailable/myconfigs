set seshFile "$HOME/.sesh.yaml"

function sesh
    if test ! -e $seshFile
        echo "{}" >$seshFile
    end

    set sessions (yq -r 'keys[]' $seshFile)

    argparse i/init=? l/list s/save -- $argv
    or return

    if set -ql _flag_init
        if test -n "$_flag_init"
            set key "$_flag_init"
        else
            set key "$(path basename (pwd))"
        end

        set data "$(yq ".\"$key\" = \"$(pwd)\"" $seshFile)"
        echo $data >$seshFile

        return
    end

    if set -ql _flag_list
        # TODO: De-dup this list
        for s in $sessions
            echo $s
        end

        for s in (tmux ls 2> /dev/null)
            set parts (string split : "$s")
            echo "$parts[1]"
        end

        return
    end

    if set -ql _flag_save
        set currentSession "$(tmux ls 2> /dev/null | grep attached)"
        if test -n "$currentSession"
            set parts (string split : "$currentSession")

            # I hate this.
            set data "$(yq ".\"$parts[1]\" = \"$(pwd)\"" $seshFile)"
            echo $data >$seshFile
        end

        return
    end

    argparse --min-args=1 -- $argv
    or return

    set sessionPath "$(yq -r ".\"$argv[1]\"" $seshFile)"

    if test "$sessionPath" = null
        ss "$argv[1]"
    else
        ss --path "$sessionPath" "$argv[1]"
    end
end

set --local seshCommands list save
complete -c sesh -f

for s in $seshCommands
    complete -c sesh -n "not __fish_contains_opt -s $seshCommands" -l $s
    set --local -a seshLongs "--$s"
end

complete -c sesh -n "not __fish_contains_opt -s $seshCommands" -a "(sesh --list)"
