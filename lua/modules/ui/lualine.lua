local icon = require("modules.ui.icons")

local function escape_status()
	local ok, m = pcall(require, "better_escape")
	return ok and m.waiting and icon.misc.EscapeST or ""
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local git_blame = require("gitblame")
local gitblame_cond = function()
	return (git_blame.is_blame_text_available() and hide_in_width())
end

local mini_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = { "location" },
}
local simple_sections = {
	lualine_a = { "mode" },
	lualine_b = { "filetype" },
	lualine_c = {},
	lualine_x = {},
	lualine_y = {},
	lualine_z = { "location" },
}
local outline = {
	sections = mini_sections,
	filetypes = { "lspsagaoutline" },
}
local dapui_scopes = {
	sections = simple_sections,
	filetypes = { "dapui_scopes" },
}

local dapui_breakpoints = {
	sections = simple_sections,
	filetypes = { "dapui_breakpoints" },
}

local dapui_stacks = {
	sections = simple_sections,
	filetypes = { "dapui_stacks" },
}

local dapui_watches = {
	sections = simple_sections,
	filetypes = { "dapui_watches" },
}

local function python_venv()
	local function env_cleanup(venv)
		if string.find(venv, "/") then
			local final_venv = venv
			for w in venv:gmatch("([^/]+)") do
				final_venv = w
			end
			venv = final_venv
		end
		return venv
	end

	if vim.bo.filetype == "python" then
		local venv = os.getenv("CONDA_DEFAULT_ENV")
		if venv then
			return string.format(icon.misc.PyEnv .. " :(%s)", env_cleanup(venv))
		end
		venv = os.getenv("VIRTUAL_ENV")
		if venv then
			return string.format(icon.misc.PyEnv .. " :(%s)", env_cleanup(venv))
		end
	end
	return ""
end

-- check your colorscheme in REPO/lua/lualine/themes/THEME.lua -> normal.b.bg
vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#252535" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#252535" })

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "kanagawa",
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "undotree", "neo-tree" },
		component_separators = "|",
		section_separators = { left = "", right = "" },
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				"branch",
				icons_enabled = true,
				-- icon = "",
				icon = "%#SLGitIcon#" .. icon.git.Branch .. "%*" .. "%#SLBranchName#",
			},
			{ "diff", source = diff_source },
		},
		lualine_c = {
			{ git_blame.get_current_blame_text, cond = gitblame_cond },
		},
		lualine_x = {
			{ escape_status },
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = icon.diagnostics.Error .. " ",
					warn = icon.diagnostics.Warning .. " ",
					info = icon.diagnostics.Information .. " ",
				},
			},
		},
		lualine_y = {
			{ "filetype", colored = true, icon_only = true },
			{ python_venv },
			{ "encoding" },
			{
				"fileformat",
				icons_enabled = true,
				symbols = {
					unix = "LF",
					dos = "CRLF",
					mac = "CR",
				},
			},
		},
		lualine_z = { "progress", "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {
		"quickfix",
		"nvim-tree",
		"toggleterm",
		"fugitive",
		outline,
		dapui_scopes,
		dapui_breakpoints,
		dapui_stacks,
		dapui_watches,
	},
})