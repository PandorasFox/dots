import "secrets" as secrets;

let eggs = #{
	ghostty: #{
		targets: "~/.config/ghostty",
	},
	zsh: #{
		targets: #{
			".zshenv": "~/.zshenv",
			"zsh": "~/zsh"
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
	vim: #{ targets: "~", strategy: "merge" },
};

let secrets_mapping = #{
	"last.fm": #{
		egg: "music",
		targets: #{
			"mpdscribble.conf": "~/.config/mpdscribble/mpdscribble.conf",
		},
		templates: ["mpdscribble.conf"],
	},
};

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
