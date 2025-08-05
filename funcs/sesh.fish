set seshFile "$HOME/.sesh.yaml"

set --local sessionEditor nvim

set --local seshDocs "sesh, the simple session manager
commands:
  -i,--init initialize the current directory as a session. Can pass a value to customize key.
  -l,--list list current sessions.
  -h,--help print these instructions
  [key] cd into the session directory

examples:
  `sesh -i=hi` Save the CWD as they key 'hi'
  `sesh hi` cd into the directory saved to the 'hi' session

Once you use sesh once during a session \$seshFile will be made available.
It's missing originally due to autoloading."

function sesh -V seshDocs -V sessionEditor
    if test ! -e $seshFile
        echo "{}" >$seshFile
    end

    set sessions (yq -r 'keys[]' $seshFile)

    argparse i/init=? l/list h/help -- $argv
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
        for s in $sessions
            echo $s
        end

        return
    end

    if set -ql _flag_help
        echo $seshDocs
        return
    end

    argparse --min-args=1 -- $argv
    or return

    set sessionPath "$(yq -r ".\"$argv[1]\"" $seshFile)"

    if test "$sessionPath" = null
        echo "No session found with key $argv[1]"
    else
        ss --path "$sessionPath" "$argv[1]"
    end
end

set --local seshCommands help init list
complete -c sesh -f

for s in $seshCommands
    complete -c sesh -n "not __fish_contains_opt -s $seshCommands" -l $s
    set --local -a seshLongs "--$s"
end

complete -c sesh -n "not __fish_contains_opt -s $seshCommands" -a "(sesh --list)"
