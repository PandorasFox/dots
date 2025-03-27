#!/bin/zsh
# deps: timg and mpc/mpd. curl, grep, shuf, awk, tr, and jq are needed to catch 'em all

last_albumart=""
wait_pid=
tput clear

function print_centered {
	# trust me bro you do not need to comprehend the horrors
	str_len=${#1}
	spaze=$(( ($COLUMNS - $str_len)/2 ))
	left_padding=$((spaze + str_len))	
	left_padded=${(l:left_padding:)1}
	echo -n ${(r:COLUMNS:)left_padded}
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
	albumart=$(curl -s --output - $sprite_url)
}

function draw {
	IMAGE_HEIGHT=$((LINES - 2))
	headline=$(mpc current -f '\[%artist%\] - %title%')
	albumname=$(mpc current -f '%album% (%date%)')
	albumart=$(mpc albumart "$(mpc current -f %file%)" 2>/dev/null)
	albumart_state=$?

	if [[ $albumart_state == 0 ]]; then
		timg_mode='k'
	else
		timg_mode='h'
		random_pokemon
	fi
	if [[ $albumart != $last_albumart ]] tput clear

	tput cup 0 0 && timg -p $timg_mode -C -gx$IMAGE_HEIGHT - <<<$albumart
	print_centered $headline
	echo # newline
	print_centered $albumname
	# no newline
	tput civis
	last_albumart=$albumart
}

function redraw {
	clear && draw
}
trap redraw SIGWINCH

stty -echo
while true; do
	draw
	mpc current --wait 2>&1 >/dev/null & wait_pid=$!
	wait
	wait_pid=
	# ILL FUCKEN DO IT AGAIN
done
