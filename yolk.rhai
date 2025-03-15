export let data = #{
    for_vcs: LOCAL,
    cool_setting: if SYSTEM.hostname == "pantheon" { 10 } else { 25 }
};
export let eggs = #{
	ghostty: #{
		targets: "~/.config/ghostty",
		templates: ["config"],
		enabled: true,
	}
};
