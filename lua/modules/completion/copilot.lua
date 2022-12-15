vim.defer_fn(function()
	require("copilot").setup({
		cmp = {
			enabled = true,
			method = "getCompletionsCycling",
		},
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = false,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			yaml = false,
			toml = false,
			json = false,
			markdown = false,
			help = false,
			terraform = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
			["dap-repl"] = false,
		},
		plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
		-- Use this field to provide the path to a specific node version such as one installed by nvm. Node version must be < 18.
		-- copilot_node_command = vim.fn.expand("$HOME") .. "/tools/nodejs/bin/node", -- Node version must be < 18
		server_opts_overrides = {},
	})
end, 100)
