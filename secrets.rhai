export let secrets_map = #{};

fn full_path(secret_name) {
	return io::env("HOME", "/home/hecate") + "/.config/yolk/secrets/" + secret_name;
}

fn exists(secret_name) {
	let f = full_path(secret_name);
	if io::path_exists(f) && io::path_is_file(f) {
		return true;
	}
	return false;
}

fn read_file(secret_name) {
	if exists(secret_name) {
		return io::read_file(full_path(secret_name));
	}
	return "";
}

fn get(secret_name) {
	return secrets::secrets_map[secret_name] ?? "";
}
