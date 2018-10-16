function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    NAME="Default"
    echo -e "\033]50;SetProfile=$NAME\a"
}

function colorssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "login*" ]]; then
            tabc Login
        else
            tabc Test
        fi
    fi
    ssh $*
}

function printServers () {
  echo '\033[32m\t1 - production \033[2;33m(ssh #@login.#.com)\n\t\033[0;32m2 - test \033[2;33m(ssh #@test.#.com)\033[0;39m'
  read REPLY

  if [[ $REPLY =~ ^[1]$ ]]
    then
      colorssh #@login.#.com
  elif [[ $REPLY =~ ^[2]$ ]]
    then
      colorssh #@test.#.com
  else
    echo 'Invalid option'
  fi
}

compdef _ssh tabc=ssh

alias servers="printServers"
