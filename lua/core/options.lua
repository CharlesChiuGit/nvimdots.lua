local global = require("core.global")

local function load_options()
	local global_local = {
		-- backupdir = global.cache_dir .. "backup/",
		-- directory = global.cache_dir .. "swap/",
		-- pumblend = 50,
		-- spell = true,
		-- spellfile = global.cache_dir .. "spell/en.uft-8.add",
		-- spelllang = "en_us",
		-- viewdir = global.cache_dir .. "view/",
		-- winblend = 50,
		autoindent = true,
		autoread = true,
		autowrite = true,
		backspace = "indent,eol,start",
		backup = false,
		backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
		breakat = [[\ \	;:,!?]],
		breakindentopt = "shift:2,min:20",
		clipboard = "unnamedplus",
		cmdheight = 2, -- 0, 1, 2
		cmdwinheight = 5,
		complete = ".,w,b,k",
		completeopt = "menuone,noselect",
		concealcursor = "niv",
		conceallevel = 0,
		cursorcolumn = true,
		cursorline = true,
		diffopt = "filler,iwhite,internal,algorithm:patience",
		display = "lastline",
		encoding = "utf-8",
		equalalways = false,
		errorbells = true,
		expandtab = true,
		fileformats = "unix,mac,dos",
		foldenable = true,
		foldlevelstart = 99,
		formatoptions = "1jcroql",
		grepformat = "%f:%l:%c:%m",
		grepprg = "rg --hidden --vimgrep --smart-case --",
		helpheight = 12,
		hidden = true,
		history = 2000,
		ignorecase = true,
		inccommand = "nosplit",
		incsearch = true,
		infercase = true,
		jumpoptions = "stack",
		laststatus = 3, -- global status line
		linebreak = true,
		list = true,
		listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
		magic = true,
		-- mouse = "nv",
		mousescroll = "ver:3,hor:6",
		number = true,
		previewheight = 12,
		pumheight = 15,
		redrawtime = 1500,
		relativenumber = true,
		ruler = true,
		scrolloff = 2,
		sessionoptions = "curdir,help,tabpages,winsize",
		shada = "!,'300,<50,@100,s10,h",
		shiftround = true,
		shiftwidth = 4,
		shortmess = "aoOTIcF",
		showbreak = "↳  ",
		showcmd = false,
		showmode = false,
		showtabline = 2,
		sidescrolloff = 5,
		signcolumn = "yes",
		smartcase = true,
		smarttab = true,
		softtabstop = 4,
		splitbelow = true,
		splitkeep = "screen",
		splitright = true,
		startofline = false,
		swapfile = false,
		switchbuf = "useopen",
		synmaxcol = 2500,
		tabstop = 4,
		termguicolors = true,
		timeout = true,
		timeoutlen = 500,
		ttimeout = true,
		ttimeoutlen = 0,
		undodir = global.cache_dir .. "undo/",
		undofile = true,
		updatetime = 100,
		viewoptions = "folds,cursor,curdir,slash,unix",
		virtualedit = "block",
		visualbell = true,
		whichwrap = "h,l,<,>,[,],~",
		wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
		wildignorecase = true,
		winminwidth = 10,
		winwidth = 30,
		wrap = false,
		wrapscan = true,
		writebackup = false,
	}

	local function isempty(s)
		return s == nil or s == ""
	end

	-- custom python provider
	if not isempty(vim.env.CONDA_PREFIX) then
		vim.g.python3_host_prog = vim.env.CONDA_PREFIX .. "/bin/python"
	elseif global.is_mac then
		vim.g.python_host_prog = "/usr/bin/python"
		vim.g.python3_host_prog = "/usr/local/bin/python3"
	else
		vim.g.python_host_prog = "/usr/bin/python"
		vim.g.python3_host_prog = "/usr/bin/python3"
	end

	-- custom node provider
	vim.g.node_host_prog = vim.env.HOME .. "/tools/nodejs/lib/node_modules/neovim/bin/cli.js"

	-- custom perl provider
	vim.g.perl_host_prog = vim.env.HOME .. "/tools/perl/bin/perl"

	-- custom ruby provider
	vim.g.ruby_host_prog = vim.env.HOME .. "/tools/ruby/bin/neovim-ruby-host"

	for name, value in pairs(global_local) do
		vim.o[name] = value
	end
end

load_options()