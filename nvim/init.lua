-- # OTHER #
vim.g.mapleader = "\\"

vim.wo.number = true

vim.cmd [[autocmd BufEnter * TSEnable highlight ]]

vim.g.indent_blankline_filetype_exclude = {"dashboard", "help",}

vim.opt.termguicolors = true

vim.g.gitblame_ignored_filetypes = { "NvimTree" }

-- # LAZY NVIM #
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	"folke/which-key.nvim",
	{
		"sainnhe/gruvbox-material",
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_background = 'hard'
			vim.cmd([[colorscheme gruvbox-material]])
		end,

	},
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	"glepnir/dashboard-nvim",
	"lukas-reineke/indent-blankline.nvim",
	"nvim-treesitter/nvim-treesitter",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	"saadparwaiz1/cmp_luasnip",
	"rafamadriz/friendly-snippets",
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {},
	},
	"romgrk/barbar.nvim",
	"brenoprata10/nvim-highlight-colors",
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
    	},
	"f-person/git-blame.nvim",
	"akinsho/toggleterm.nvim",
})

-- # WHICH-KEY #
local wk = require("which-key")

local wk_mappings = {
	s = { "<cmd>w<cr>", "Save" },
	S = { "<cmd>wq<cr>", "Save & Quit" },
	n = { "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree" },
	c = { "<cmd>HighlightColorsToggle<cr>", "Toggle Highlighting Colors" },
	f = { "<cmd>Telescope find_files hidden=true<cr>", "Find Files" },
	g = { "<cmd>Telescope live_grep hidden=true<cr>", "Live Grep" },
	z = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },
	q = { "<cmd>BufferGoto 1<cr>", "Switch to Buffer #1" },
	w = { "<cmd>BufferGoto 2<cr>", "Switch to Buffer #2" },
	e = { "<cmd>BufferGoto 3<cr>", "Switch to Buffer #3" },
	r = { "<cmd>BufferGoto 4<cr>", "Switch to Buffer #4" },
	t = { "<cmd>BufferGoto 5<cr>", "Switch to Buffer #5" },
	y = { "<cmd>BufferGoto 6<cr>", "Switch to Buffer #6" },
	u = { "<cmd>BufferGoto 7<cr>", "Switch to Buffer #7" },
	i = { "<cmd>BufferGoto 8<cr>", "Switch to Buffer #8" },
	o = { "<cmd>BufferGoto 9<cr>", "Switch to Buffer #9" },
	p = { "<cmd>BufferGoto 0<cr>", "Switch to Buffer #0" },
}

local wk_opts = {prefix = "<leader>"}

wk.register(wk_mappings, wk_opts)

-- # NVIM-TREE #
require("nvim-tree").setup()

-- # LUA-LINE #
require("lualine").setup({
	options = { theme = "gruvbox-material" },
})

-- # LUASNIP #
require("luasnip.loaders.from_vscode").lazy_load()

local lusasnip = require("luasnip")

lusasnip.config.set_config({
	history = true,
	enable_autosnippets = true,
})

-- # CMP #
local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
    	},
    	window = {
      		completion = cmp.config.window.bordered(),
      		documentation = cmp.config.window.bordered(),
    	},
    	mapping = cmp.mapping.preset.insert({
      		['<C-b>'] = cmp.mapping.scroll_docs(-4),
      		['<C-f>'] = cmp.mapping.scroll_docs(4),
      		['<C-Space>'] = cmp.mapping.complete(),
      		['<C-e>'] = cmp.mapping.abort(),
      		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    	}),
    	sources = cmp.config.sources({
		{ name = "luasnip" },
	    	{ name = "path" },
	    	{ name = "buffer" },
      	}),
})

-- # DASHBOARD #
require("dashboard").setup({
	theme = "hyper",
	hide = {
		statusline = true,
	},
	config = {
		shortcut = {
			{ desc = ' Update ', group = 'Number', action = 'Lazy update', key = 'u' },
			{ desc = ' Edit Config ', group = 'Number', action = 'edit ~/.config/nvim/init.lua', key = 'e' },
			{ desc = ' Quit ', group = 'Number', action = 'q', key = 'q' },


		},
		packages = { 
			enable = false,
		},
		footer = {
			'',
			'',
			'',
			[[...capitalism does live by crises and booms, just as a human being lives by inhaling and exhaling.]],
			'',
			[[  Leon Trotsky ]],
		},
		mru = { limit = 5, icon = "  ", label = "Recent Files:" },
		header = {
			[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]],
			[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]],
			[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]],
			[[@@@@@@@@@@@&*@@@@@&   *#(,    @@@@@@@@@@]],
			[[@@@@@@@@@ *@@@@@   @@@@.          (@@@@@]],
			[[@@@@@@#  @@@@@@   @@@@@@@@            /@]],
			[[@@@@@  *@@@@@@   @@@@@@@/  @@@@&     &@@]],
			[[@@@(  ,@@@@@@   @@@@@@@  .@@@@@@@@@@@@@@]],
			[[@@%   @@@@@@   @@@@@/  %@@@@@@@@@@@@@@@@]],
			[[@@   %@@@@@   @@@@@@   @@@@@@@@@@@@@@@@@]],
			[[@#   @@@@@   @@@@@,  *@@@   @@@@@@@@@@@@]],
			[[@(   @@@@   @@@@@  @@@@@   @@@@@@@@@@@@@]],
			[[@&   .@@                   @@@@@@@@@@@@@]],
			[[@@/    #@@@@@&   (@@@@@   @@@@@@@@@@@@@@]],
			[[@@@%      ,@    @@@@@@   @&#  /@@@@@@@@@]],
			[[@@@@@&   #@   .@                @@@@@@@@]],
			[[@@@@@@@@@.   %&           #@@    #@@@@@@]],
			[[@@@@@@@%    @@@@@@@@@@@@@@@@@@.    @@@@@]],
			[[@@@@@@*   *@@@@@@@@@@@@@@@@@@@@&    @@@@]],
			[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]],
			[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]],
			[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]],
			'',
			'',
			'',
		}
	}
})
vim.cmd [[hi DashBoardHeader guifg=#ea6962]]

-- # TREESITTER #
require("nvim-treesitter.configs").setup({
-- 	ensure_installed = { "bash", "c", "cpp", "css", "rust", "python", "scss", "yuck"},
--
-- 	auto_install = true,

	hightlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- # BARBAR #
vim.g.barbar_auto_setup = false
require("barbar").setup({
	animation = true,
	tabpages = true,
	highlight_visible = true,
	filetype = {
		enabled = true,
	},
	icons = {
		separator = {left = '▎', right = ' ▎'},
		separator_at_end = false,
	},
	sidebar_filetypes = {
		NvimTree  = true,
	}
})

vim.cmd [[hi BufferTabpageFill guibg=#1d2021]]

-- # HIGHTLIGHT-COLORS #
require('nvim-highlight-colors').setup()

-- # TELESCOPE #
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    layout_config = {
      width = 0.75,
      prompt_position = "top",
      preview_cutoff = 120,
      horizontal = {mirror = false},
      vertical = {mirror = false}
    },
    find_command = {
      'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
    },
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    }
  }
}

-- # GIT_BLAME #
require("gitblame").setup({
	enabled = true,
})

-- # TOGGLE-TERM #
require("toggleterm").setup()
