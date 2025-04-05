#!/bin/sh
export BW_SESSION=$(bw login --raw || bw unlock --raw)

bw sync

# future: for-loop the domains & outputs
mkdir -p ~/.config/yolk/secrets

bw get password last.fm    > ~/.config/yolk/secrets/last.fm
bw get password mpd        > ~/.config/yolk/secrets/mpd
bw get notes DO_ddns_token > ~/.config/yolk/secrets/DO_ddns_token
