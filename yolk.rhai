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

// ========= TODO break out into personal wizard tome file
let secrets = #{};

fn full_secret_path(secret_name) {
	return io::env("HOME", "/home/hecate") + "/.config/yolk/secrets/" + secret_name;
}

fn secret_exists(secret_name) {
	let f = full_secret_path(secret_name);
	if io::path_exists(f) && io::path_is_file(f) {
		return true;
	}
	return false;
}

fn read_secret_file(secret_name) {
	if secret_exists(secret_name) {
		return io::read_file(full_secret_path(secret_name));
	}
	return "";
}

fn get_secret(secret_name) {
	return secrets[secret_name] ?? "";
}
// =======


for secret_name in secrets_mapping.keys() {
	let config_map = secrets_mapping[secret_name];
	if secret_exists(secret_name) {
		secrets[secret_name] = read_secret_file(secret_name);
		// TODO: make these work better with varied data types
		// (e.g. no 'templates', targets being an array => turn into map..... ugh.....
		eggs[config_map.egg].targets += config_map.targets;
		eggs[config_map.egg].templates += config_map.templates;
	}
}

export secrets;
export eggs;
