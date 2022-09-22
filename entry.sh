#!/bin/bash
mkdir -p "/home/gsh-user/GameShell"
cd /home/gsh-user/GameShell
if [[ ! -f "gameshell.sh" ]]; then
    wget https://github.com/phyver/GameShell/releases/download/latest/gameshell.sh
    chown gsh-user:gsh-user gameshell.sh
fi
bash ./gameshell.sh