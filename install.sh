#!/bin/sh

OPTSTRING=":s"
use_stow=0

while getopts ${OPTSTRING} opt; do
  case $opt in 
    s)
      use_stow=1
      ;;

  esac
done

if [ $use_stow -eq 0 ]
then
  echo "Copying, not stow'ing."
  cp -r ./.config/** ~/.config/
  cp -r ./.local/bin/* ~/.local/bin/
else
  echo "Stow'ing, not copying."
  stow . -t ~/
fi

