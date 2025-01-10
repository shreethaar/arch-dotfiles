#!/bin/sh

# take all the cache and remove useless packages
sudo pacman -Sc
sudo pacman -Scc
paccache -r
sudo pacman -Qtdq | sudo pacman -Rns -

# clean yay cache
yay -Sc
yay -Scc

# list cache 
sudo du -sh ~/.cache/
rm -rf ~/.cache/*
