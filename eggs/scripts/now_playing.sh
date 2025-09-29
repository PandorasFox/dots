#!/bin/zsh
# deps: timg and mpc/mpd. curl, grep, shuf, awk, tr, and jq are needed to catch 'em all

last_albumart=""
tput clear

function print_centered {
	# trust me bro you do not need to comprehend the horrors
	str_len=${#1}
	spaze=$(( ($COLUMNS - $str_len)/2 ))
	left_padding=$((spaze + str_len))	
	left_padded=${(l:left_padding:)1}
	echo -n "${(r:COLUMNS:)left_padded}"
}

# blinking cursor is a distraction
function unhide_cursor {
	tput cnorm
	[[ $wait_pid ]] && kill "$wait_pid"
	tput clear
	exit
}
trap unhide_cursor EXIT INT TERM

function random_pokemon {
	# gen 3 up to 386, 4 to 493
	id=$(shuf -i "1-386" -n 1)
	sprite_url=$(curl -s "https://pokeapi.co/api/v2/pokemon/$id" | jq '.sprites.versions."generation-iii".emerald' | grep front | shuf -n 1 | awk '{ print $2 }' | tr -d '",')
	next_album_art=$(curl -s --output - $sprite_url)
}

function draw {
	IMAGE_HEIGHT=$((LINES - 3))
	artist=$(playerctl metadata xesam:albumArtist)
	title=$(playerctl metadata xesam:title)
	albumname=$(playerctl metadata xesam:album)
	headline="[$artist] - $title"
	art_url=$(playerctl metadata mpris:artUrl 2>/dev/null | sed -re 's/&?size=[0-9]+//')
	album_art_state=$?
	if [[ $album_art_state == 0 ]]; then
		timg_mode='k'
		next_album_art=$(curl -s "$art_url" --output -)
	else
		timg_mode='h'
		random_pokemon
	fi
	if [[ $next_album_art != $last_albumart ]] tput clear

	tput cup 0 0 && timg -p $timg_mode -C -gx$IMAGE_HEIGHT - <<<$next_album_art
	print_centered $headline
	print_centered $albumname
	tput civis
	last_albumart=$next_album_art
}

function redraw {
	clear && draw
}
trap redraw SIGWINCH

stty -echo
export FUNCS=$(functions print_centered unhide_cursor random_pokemon draw)
while true; do
	playerctl metadata 'xesam:title' -F | xargs -n1 -d'\n' zsh -c "eval $FUNCS; draw"
done
