local files=(
	history.zsh
	completion.zsh
	aliases.zsh
	keybinds.zsh
)

for i in $files; do
	# TODO tidy up ? 
	if [[ -e $ZDOTDIR/$i ]]; then
		source $ZDOTDIR/$i
	fi
done

eval "$(starship init zsh)"

# Created by `pipx` on 2025-03-15 22:03:58
# TODO CLEANUP
export PATH="$PATH:/home/hecate/.local/bin"
