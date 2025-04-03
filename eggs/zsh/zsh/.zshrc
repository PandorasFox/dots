local files=(
	history.zsh
	completion.zsh
	aliases.zsh
	keybinds.zsh
	atuin.zsh
)

for i in $files; do
	# TODO tidy up ? 
	if [[ -e $ZDOTDIR/$i ]]; then
		source $ZDOTDIR/$i
	fi
done

eval "$(starship init zsh)"
