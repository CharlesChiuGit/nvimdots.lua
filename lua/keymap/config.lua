local vim = vim

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.enhance_jk_move = function(key)
	local map = key == "j" and "<Plug>(accelerated_jk_gj)" or "<Plug>(accelerated_jk_gk)"
	return t(map)
end

-- _G.enhance_align = function(key)
-- 	vim.api.nvim_command([[packadd vim-easy-align]])
-- 	local map = { ["nga"] = "<Plug>(EasyAlign)", ["xga"] = "<Plug>(EasyAlign)" }
-- 	return t(map[key])
-- end

-- local _lazygit = nil
-- _G.toggle_lazygit = function()
-- 	if not _lazygit then
-- 		local Terminal = require("toggleterm.terminal").Terminal
-- 		_lazygit = Terminal:new({
-- 			cmd = "lazygit",
-- 			hidden = true,
-- 			direction = "float",
-- 		})
-- 	end
-- 	_lazygit:toggle()
-- end
