import "secrets" as secrets;

let eggs = #{
	zsh: #{
		targets: #{
			".zshenv": "~/.zshenv",
			"zsh": "~/zsh",
		},
	},
	vim: #{
		targets: #{
			"vimrc": "~/.vimrc",
			"vim": "~/.vim",
		},
	},
	neovim: #{
		targets: "~/.config/nvim/",
	},
	ghostty: #{
		targets: "~/.config/ghostty/",
	},
	niri: #{
		targets: "~/.config/niri/",
	},
	swaylock: #{
		targets: "~/.config/swaylock/",
	},
	waybar: #{
		targets: "~/.config/waybar/",
	},
	unit_files: #{
		targets: #{
			"swaybg.service": "~/.config/systemd/user/swaybg.service",
			"swayidle.service": "~/.config/systemd/user/swayidle.service",
		},
	},
	music: #{
		targets: #{
			"mpd.conf": "~/.config/mpd/mpd.conf",
			"now_playing.sh": "~/bin/now_playing.sh",
			"ncmpcpp.config": "~/.config/ncmpcpp/config",
		},
		templates: [],
	},
	scripts: #{
		targets: #{
			// TODO: guard against `bw` installed?
			"gen_yolk_secrets_files.sh": "~/bin/gen_yolk_secrets_files.sh",
		},
	},
};

let secrets_mapping = #{
	"last.fm": #{
		egg: "music",
		targets: #{
			"mpdscribble.conf": "~/.config/mpdscribble/mpdscribble.conf",
			// wild that this nonsense actually works as intended and avoids
			// committing secrets
		},
		templates: ["mpdscribble.conf"],
	},
};

// todo: split up above eggs file into categories, merge based on hostname
// todo: collate {waybar, swayidle, swaylock, swaybg} together into one egg?
//   -- i want to keep it separate from Niri so that WM remains theoretically
//   -- swappable.

// todo: condense and move into secrets.rhai

for secret_name in secrets_mapping.keys() {
	let config_map = secrets_mapping[secret_name];
	if secrets::exists(secret_name) {
		secrets::secrets_map[secret_name] = secrets::read_file(secret_name);
		// TODO: make these work better with varied data types
		// (e.g. no 'templates', targets being an array => turn into map..... ugh.....
		eggs[config_map.egg].targets += config_map.targets;
		eggs[config_map.egg].templates += config_map.templates;
	}
}

export eggs;
