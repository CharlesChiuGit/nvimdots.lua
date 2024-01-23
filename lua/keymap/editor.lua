local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode
require("keymap.helpers")

local plug_map = {
	-- Plugin: accelerate-jk
	["n|j"] = map_callback(function()
		return et("<Plug>(accelerated_jk_gj)")
	end):with_expr(),
	["n|k"] = map_callback(function()
		return et("<Plug>(accelerated_jk_gk)")
	end):with_expr(),

	-- Plugin persisted.nvim
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: nvim-bufdel
	["n|<F4>"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),

	-- Plugin: comment-frame
	["n|<leader>cf"] = map_callback(function()
		require("nvim-comment-frame").add_comment()
	end):with_desc("edit: Add comment box around the texts"),
	["n|<leader>cF"] = map_callback(function()
		require("nvim-comment-frame").add_multiline_comment()
	end):with_desc("edit: Add comment box around multi lines of texts"),

	-- Plugin: comment.nvim
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gbc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
	["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: flash
	["nxo|s"] = map_callback(function()
			require("flash").jump()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: Flash search"),
	["nxo|S"] = map_callback(function()
			require("flash").treesitter()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("edit: Flash Treesitter"),
	["c|<C-s>"] = map_callback(function()
			require("flash").toggle()
		end)
		:with_silent()
		:with_noremap()
		:with_desc("editi: Flash Telescope"),

	-- Plugin: diffview
	["n|<leader>gd"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader>gD"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: vim-easy-align
	["nx|gea"] = map_cr("EasyAlign"):with_desc("edit: Align with delimiter"),

	--- Plugin: nvim-surround
	["n|ys"] = map_callback(function()
			return et("<Plug>(nvim-surround-normal)")
		end)
		:with_expr()
		:with_desc("edit: Add a surrounding pair around a motion"),
	["n|yss"] = map_callback(function()
			return et("<Plug>(nvim-surround-normal-cur")
		end)
		:with_expr()
		:with_desc("edit: Add a surrounding pair around current line"),
	["n|yS"] = map_callback(function()
			return et("<Plug>(nvim-surround-normal-line)")
		end)
		:with_expr()
		:with_desc("edit: Add a surrounding pair around a motion, on new lines"),
	["n|ySS"] = map_callback(function()
			return et("<Plug>(nvim-surround-normal-cur-line)")
		end)
		:with_expr()
		:with_desc("edit: Add a surrounding pair around the current line, on new lines"),
	["x|ys"] = map_callback(function()
			return et("<Plug>(nvim-surround-visual")
		end)
		:with_expr()
		:with_desc("edit: Add a surrounding pair around a visual selection"),
	["x|yS"] = map_callback(function()
			return et("<Plug>(nvim-surround-visual-line")
		end)
		:with_expr()
		:with_desc("edit: Add a surrounding pair around a visual selection, on new lines"),
	["n|ds"] = map_callback(function()
			return et("<Plug>(nvim-surround-delete")
		end)
		:with_expr()
		:with_desc("edit: Delete a surrounding pair"),
	["n|cs"] = map_callback(function()
			return et("<Plug>(nvim-surround-change")
		end)
		:with_expr()
		:with_desc("edit: Change a surrounding pair"),

	-- Plugin: tabout
	["i|<A-l>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("edit: Goto end of pair"),
	["i|<A-h>"] = map_cmd("<Plug>(TaboutBackMulti)"):with_silent():with_noremap():with_desc("edit: Goto begin of pair"),

	-- Plugin suda.vim
	["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),
}

bind.nvim_load_mapping(plug_map)
