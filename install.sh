#!/bin/bash

# TODO install nvim, lua, fennel, fnlfmt
#
dir="$HOME/.config/nvim"

if [ -d "$dir" ]; then
  rm -rf "$dir"
fi

ln -s "$HOME/xnvim" "$dir"
