-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/emmet_ls.lua
-- https://github.com/pedro757/emmet
-- npm i -g ls_emmet
return {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"haml",
		"xml",
		"xsl",
		"pug",
		"slim",
		"sass",
		"stylus",
		"less",
		"sss",
		"hbs",
		"handlebars",
	},
}
