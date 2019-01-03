#!/usr/bin/env bash


# formatted print
fprint()
{
    local prio=$1
    local message=$2

    case $prio in
        INFO )
            echo -e "\e[1;46m \e[0m $message"
            ;;
        WARN )
            echo -e "\e[1;43m \e[0m $message"
            ;;
        ERROR|FAIL )
            echo -e "\e[1;41m \e[0m $message"
            ;;
        SUCCESS|PASS|OK )
            echo -e "\e[1;42m \e[0m $message"
            ;;
    esac
}


help_virtualenv()
{
    fprint "INFO" "Virtualenv HowTo:"
    echo ""
    echo " Create Python3 Project: \$ mkproject -p \$(which python3) <PROJECT_NAME>"
    echo "          List Projects: \$ workon"
    echo "        List Virtualenv: \$ lsvirtualenv"
    echo "      Delete Virtualenv: \$ rmvirtualenv"
}


help_tmux()
{
    fprint "INFO" "Tmux HowTo:"
    echo ""
    echo " In a tmux shell: press CTRL+B <command>"
    echo " Create new tmux session: CTRL+B c"
    echo "         Previous window: CTRL+B p"
    echo "             Next window: CTRL+B n"
    echo "            List windows: CTRL+B w"
    echo "           Rename window: CTRL+B ,"
    echo "        Deattach windows: CTRL+B d"
    echo "           List sessions: tmux ls"
    echo "          Attach session: tmux a -t <sessionname>"
    echo "      Scroll in terminal: CTRL+B [ than use Up,Down Arrows or PgUp,PgDn>"

}
