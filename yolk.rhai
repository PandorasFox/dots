import "secrets" as secrets;

let eggs = #{
	zsh: #{
		targets: #{
			"zshenv": "~/.zshenv",
			"zshrc": "~/.config/zsh/.zshrc",
			"zprofile": "~/.config/zsh/.zprofile",
			"bits": "~/.config/zsh/bits",
		},
		templates: ["bits/*.zsh", "zprofile"],
		main_file: "bits",
		optional_secrets: ["mpd"],
	},
	starship: #{
		enabled: io::command_available("starship"),
		targets: #{
			"config.toml": "~/.config/starship.toml",
		},
		templates: ["config.toml"],
	},
	vim: #{
		targets: #{
			"vimrc": "~/.vimrc",
			"vim": "~/.vim",
		},
	},
	neovim: #{
		enabled: io::command_available("nvim"),
		targets: "~/.config/nvim/",
	},
	ghostty: #{
		targets: "~/.config/ghostty/",
	},
	niri: #{
		enabled: io::command_available("niri"),
		targets: "~/.config/niri/",
	},
	fuzzel: #{
		enabled: io::command_available("fuzzel"),
		targets: "~/.config/fuzzel/",
	},
	swaylock: #{
		enabled: io::command_available("swaylock"),
		targets: "~/.config/swaylock/",
	},
	waybar: #{
		enabled: io::command_available("waybar"),
		targets: #{
			"style.css": "~/.config/waybar/style.css",
			"config.jsonc": "~/.config/waybar/config.jsonc",
		},
		main_file: "config.jsonc",
	},
	unit_files: #{
		targets: #{
			"swaybg.service": "~/.config/systemd/user/swaybg.service",
			"swayidle.service": "~/.config/systemd/user/swayidle.service",
		},
	},
	music: #{
		targets: #{
			"ncmpcpp.config": "~/.config/ncmpcpp/config",
			"mpd.conf": "~/.config/mpd/mpd.conf",
			"mpdscribble.conf": "~/.config/mpdscribble/mpdscribble.conf",
		},
		templates: ["*"],
		required_secrets: ["mpd", "last.fm"],
	},
	scripts: #{
		targets: #{
			"gen_yolk_secrets_files.sh": "~/bin/gen_yolk_secrets_files.sh",
			"now_playing.sh": "~/bin/now_playing.sh",
		},
	},
};

// todo: split up above eggs file into categories, merge based on hostname
// todo: collate {waybar, swayidle, swaylock, swaybg} together into one egg?
//  i want to keep it separate from Niri so that WM remains theoretically swappable.
// todo: maybe also include (a copy of) wallpapers? need to figure out Good art
// storage and categorizing

// todo: condense and move into secrets.rhai

export eggs;
