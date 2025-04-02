return {
  -- the colorscheme should be available when starting Neovim
	{"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
		vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			animation = true,
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},
	{ "rhaiscript/vim-rhai" },
}
