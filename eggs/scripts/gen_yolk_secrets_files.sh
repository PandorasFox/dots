#!/bin/sh
BW_SESSION=$(bw login --raw || bw unlock --raw)

bw sync

# future: for-loop the domains & outputs
mkdir -p ~/.config/yolk/secrets

bw get password last.fm > ~/.config/yolk/secrets/last.fm
bw get password mpd     > ~/.config/yolk/secrets/mpd
