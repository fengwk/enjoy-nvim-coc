#!/bin/bash

nvim_path="$HOME/.config/nvim"
coc_path="$HOME/.config/coc"

if [ -e "$coc_path/extensions/node_modules/coc-java" ]; then
    if [ ! -e "$coc_path/extensions/node_modules/coc-java/lombok" ]; then
        mkdir $coc_path/extensions/node_modules/coc-java/lombok
    fi
    if [ ! -e "$coc_path/extensions/node_modules/coc-java/lombok/lombok.jar" ]; then
        ln -s $nvim_path/lib/lombok.jar $coc_path/extensions/node_modules/coc-java/lombok/lombok.jar
    fi
fi
