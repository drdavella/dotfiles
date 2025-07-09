#!/usr/bin/env bash

# Enable flakes + nix-command and install Home Manager
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

nix run home-manager/master -- init --switch --flake ".#dan"
