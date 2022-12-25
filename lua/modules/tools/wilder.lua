local wilder = require("wilder")
local icons = { ui = require("modules.ui.icons").get("ui") }

wilder.setup({ modes = { ":", "/", "?" } })
wilder.set_option("use_python_remote_plugin", 0)
wilder.set_option("pipeline", {
	wilder.branch(
		wilder.cmdline_pipeline({
			use_python = 0,
			fuzzy = 1,
			fuzzy_filter = wilder.lua_fzy_filter(),
		}),
		wilder.vim_search_pipeline(),
		{
			wilder.check(function(_, x)
				return x == ""
			end),
			wilder.history(),
			wilder.result({
				draw = {
					function(_, x)
						return icons.ui.Calendar .. x
					end,
				},
			}),
		}
	),
})

local string_fg = vim.api.nvim_get_hl_by_name("String", true).foreground
local match_hl = string_fg ~= nil and string.format("#%06x", string_fg) or "#ABE9B3"

local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
	max_height = "25%",
	border = "rounded",
	highlights = {
		border = "Title", -- highlight to use for the border
		accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 0 }, { a = 0 }, { foreground = match_hl } }),
	},
	empty_message = wilder.popupmenu_empty_message_with_spinner(),
	highlighter = wilder.lua_fzy_highlighter(),
	left = {
		" ",
		wilder.popupmenu_devicons(),
		wilder.popupmenu_buffer_flags({
			flags = " a + ",
			icons = { ["+"] = icons.ui.Pencil, a = icons.ui.Indicator, h = icons.ui.File },
		}),
	},
	right = {
		" ",
		wilder.popupmenu_scrollbar(),
	},
}))

local wildmenu_renderer = wilder.wildmenu_renderer({
	highlighter = wilder.lua_fzy_highlighter(),
	apply_incsearch_fix = true,
	separator = " · ",
	left = { " ", wilder.wildmenu_spinner(), " " },
	right = { " ", wilder.wildmenu_index() },
})

wilder.set_option(
	"renderer",
	wilder.renderer_mux({
		[":"] = popupmenu_renderer,
		["/"] = wildmenu_renderer,
		substitute = wildmenu_renderer,
	})
)
