return function()
	local colors = require("modules.utils").get_palette()
	local floatborder_hl = require("modules.utils").hl_to_rgb("FloatBorder", false, colors.blue)

	require("toggleterm").setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.40
			end
		end,
		on_open = function()
			-- Prevent infinite calls from freezing neovim.
			-- Only set these options specific to this terminal buffer.
			vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
			vim.api.nvim_set_option_value("foldexpr", "0", { scope = "local" })
		end,
		highlights = {
			FloatBorder = {
				guifg = floatborder_hl,
			},
		},
		open_mapping = false, -- [[<c-\>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = false,
		shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = "horizontal",
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell
	})

	---@param program string
	local function not_found_notify(program)
		vim.notify(string.format("[%s] not found!", program), vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end

	local Terminal = require("toggleterm.terminal").Terminal

	local toggleterm_cache = {
		lf = nil,
		htop = nil,
		python = nil,
		nvsmi = nil,
	}

	function _G.toggle_lf()
		if toggleterm_cache.lf then
			toggleterm_cache.lf:toggle()
		else
			if vim.fn.executable("lf") then
				toggleterm_cache.lf = Terminal:new({ cmd = "lf", hidden = true, direction = "float" })
				toggleterm_cache.lf:toggle()
			else
				not_found_notify("Lf")
			end
		end
	end

	function _G.toggle_htop()
		if toggleterm_cache.htop then
			toggleterm_cache.htop:toggle()
		else
			if vim.fn.executable("htop") then
				toggleterm_cache.htop = Terminal:new({ cmd = "htop", hidden = true, direction = "float" })
				toggleterm_cache.htop:toggle()
			else
				not_found_notify("Htop")
			end
		end
	end

	function _G.toggle_py()
		if toggleterm_cache.python then
			toggleterm_cache.python:toggle()
		else
			if vim.fn.executable("python3") then
				toggleterm_cache.python = Terminal:new({ cmd = "python3", hidden = true, direction = "float" })
				toggleterm_cache.python:toggle()
			elseif vim.fn.executable("python") then
				toggleterm_cache.python = Terminal:new({ cmd = "python", hidden = true, direction = "float" })
				toggleterm_cache.python:toggle()
			else
				not_found_notify("Python")
			end
		end
	end

	function _Nvsmi_toggle()
		if toggleterm_cache.nvsmi then
			toggleterm_cache.nvsmi:toggle()
		else
			if vim.fn.executable("nvidia-smi") then
				toggleterm_cache.nvsmi =
					Terminal:new({ cmd = "watch -n 1 nvidia-smi", hidden = true, direction = "float" })
				toggleterm_cache.nvsmi:toggle()
			else
				not_found_notify("nvidia-smi")
			end
		end
	end
end