set seshFile "$HOME/.sesh"

set --local sessionEditor nvim

set --local seshDocs "sesh, the simple session manager
commands:
  -i,--init initialize the current directory as a session. Can pass a value to customize key.
  -l,--list list current sessions.
  -h,--help print these instructions
  --edit open the session file in \$sessionEditor (currently $sessionEditor)
  {key} cd into the session directory

examples:
  `sesh -i=hi` Save the CWD as they key 'hi'
  `sesh hi` cd into the directory saved to the 'hi' session"

function sesh -V seshDocs -V sessionEditor
    if test ! -e $seshFile
        touch $seshFile
    end

    for s in (cat $seshFile)
        if test -n "$s"
            set -a sessions "$s"
        end
    end

    argparse i/init=? l/list h/help edit -- $argv
    or return

    if set -ql _flag_init
        if test -n "$_flag_init"
            set key "$_flag_init"
        else
            set ldir $(string split / $(pwd))
            set key "$ldir[-1]"
        end

        echo "$key:$(pwd)" >>$seshFile

        return
    end

    if set -ql _flag_list
        for s in $sessions
            set parts (string split : $s)
            echo $parts[1]
        end

        return
    end

    if set -ql _flag_edit
        $sessionEditor $seshFile
        return
    end

    if set -ql _flag_help
        echo $seshDocs
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

            set extras $argv[2..]

            if test -n "$extras"
                $extras
            end
        end
    end

    if test $found -ne 1
        echo "No session found with key $argv[1]"
    end
end

set --local seshCommands help init list edit

complete -c sesh -f

for s in $seshCommands
    complete -c sesh -l $s
    set --local -a seshLongs "--$s"
end

complete -c sesh -n "not __fish_seen_argument $seshLongs" -a "(sesh --list)"
