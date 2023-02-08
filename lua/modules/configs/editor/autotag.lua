return function()
	require("nvim-ts-autotag").setup({
		filetypes = {
			"glimmer",
			"handlebars",
			"hbs",
			"html",
			"javascript",
			"javascriptreact",
			"jsx",
			"markdown",
			"php",
			"rescript",
			"svelte",
			"tsx",
			"typescript",
			"typescriptreact",
			"vue",
			"xml",
		},
		skip_tags = {},
	})
end
