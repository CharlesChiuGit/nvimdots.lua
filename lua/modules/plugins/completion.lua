local completion = {}
local use_copilot = require("core.settings").use_copilot

completion["neovim/nvim-lspconfig"] = {
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = require("completion.lsp"),
	dependencies = {
		{ "mason-org/mason.nvim" },
		{ "mason-org/mason-lspconfig.nvim" },
		{ "b0o/schemastore.nvim" },
	},
}
completion["nvimdev/lspsaga.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.lspsaga"),
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
completion["dnlhc/glance.nvim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("completion.glance"),
}
completion["joechrisellis/lsp-format-modifications.nvim"] = {
	lazy = true,
	event = "LspAttach",
}
completion["nvimtools/none-ls.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("completion.null-ls"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
}
completion["rachartier/tiny-inline-diagnostic.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	priority = 1000, -- needs to be loaded in first
	config = require("completion.tiny-inline-diagnostic"),
}

completion["Saghen/blink.cmp"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("completion.blink"),
	version = "*",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			config = require("completion.luasnip"),
			dependencies = { "rafamadriz/friendly-snippets" },
		},
		"mikavilpas/blink-ripgrep.nvim",
		"xzbdmw/colorful-menu.nvim",
	},
	opts_extend = { "sources.default" },
}

if use_copilot then
	completion["zbirenbaum/copilot.lua"] = {
		lazy = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = require("completion.copilot"),
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = require("completion.copilot-cmp"),
			},
		},
	}
end

-- completion["barreiroleo/ltex_extra.nvim"] = {
-- 	lazy = true,
-- 	ft = "tex",
-- }

-- Adding *nvim config dir*, *nvim runtime dir*, *all plugin dir(with /lua dir)* to get
-- hover docs and function signatures, but it takes too much time to load all dirs, use it if needed.
completion["folke/lazydev.nvim"] = {
	lazy = true,
	ft = "lua",
	dependencies = {
		{ "gonstoll/wezterm-types", lazy = true },
		{ "Bilal2453/luvit-meta", lazy = true },
	},
	config = require("completion.lazydev"),
}

return completion
