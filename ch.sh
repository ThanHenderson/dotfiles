#!/usr/bin/env bash

langs=`printf "cpp go rust c javascript typescript" | tr ' ' '\n'`

selection=`printf "$langs" | fzf`

printf "Language: $selection\n"
read -p "Search term: " term
if printf "$langs" | grep -qs $selection; then
    echo "heere"
    tmux neww bash -c "curl cht.sh/$selection/`echo $term | tr ' ' '+'` & while [ : ]; do sleep 1; done"
fi
