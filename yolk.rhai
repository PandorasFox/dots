let eggs = #{
	ghostty: #{
		targets: "~/.config/ghostty",
		enabled: true,
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
			"ncmpcpp.config": "~/.config/ncmpcpp/config",
		},
		templates: ["mpdscribble.conf"],
	},
};

let secrets_mapping = #{
	"last.fm": #{
		"music": #{
			targets: #{
				"mpdscribble.conf": "~/.config/mpdscribble/mpdscribble.conf",
			},
			templates: ["mpdscribble.conf"],
		},
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
	if secret_exists(secret_name) {
		secrets[secret_name] = read_secret_file(secret_name);
		// merge templates into eggs mapping so they get synced into place
		eggs += secrets_mapping[secret_name]
	}
}

export secrets;
export eggs;
