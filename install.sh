#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

function insert_line () {
    LINE=$1
    FILE=$2
    grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}

function remove_line () {
    SEDSTRING="/$1/d"
    sed -i.bak $SEDSTRING $2
}

source $DIR/sh-func.cfg

# tmux
cd $HOME
ln -s -f $DIR/tmux.cfg $HOME/.tmux.conf

# shell
remove_line "MYCFGDIR" "$HOME/.bashrc"
insert_line "export MYCFGDIR=\"$DIR\"" "$HOME/.bashrc"
insert_line "source \$MYCFGDIR/sh.cfg" "$HOME/.bashrc"

echo "Done!"
