-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/lua_ls.lua

return {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				enable = true,
				globals = { "vim" },
				disable = { "different-requires" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 2000,
				preloadFileSize = 1000,
			},
			hint = { enable = true, setType = true },
			format = { enable = false },
			telemetry = { enable = false },
			-- Do not override treesitter lua highlighting with lua_ls's highlighting
			semantic = { enable = false },
		},
	},
}
