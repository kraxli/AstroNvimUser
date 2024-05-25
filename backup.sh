#!/bin/env bash
# chmod u+x backup.sh

suffix=-astro

# required
mv ~/.config/nvim{,.bak$suffix}

# optional but recommended
mv ~/.local/share/nvim{,.bak$suffix}
mv ~/.local/state/nvim{,.bak$suffix}
mv ~/.cache/nvim{,.bak$suffix}
