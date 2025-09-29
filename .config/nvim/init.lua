----------------
-- CHEATSHEET --
----------------

-- errors/warning		     : leader + do
-- signature			     : shift + k
-- signature while writing   : ctrl + s
-- Lsp goto definition		 : gd
-- Lsp Code action			 : ga
-- Lsp rename				 : gr

-- To add an lsp server add it to `lsp_servers` and mason will automatically install it.
-- The lsp will be also automatically be enabled with `vim.lsp.enable` and sane defaults from nvim-lspconfig
-- See the LSP section if you want to customize servers

vim.g.mapleader = " "

-------------
-- Plugins --
-------------

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- These will be automatically installed by mason and enabled
local lsp_servers = {
	'bashls',
	'clangd',
	'emmet_ls',
	'ts_ls',
	'rust_analyzer',
	'jdtls',
	'pylsp',
	'lua_ls',
}

require('lazy').setup({
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			opts = {
				event_handlers = {
					{
						event = "file_open_requested",
						handler = function()
							-- auto close
							require("neo-tree.command").execute({ action = "close" })
						end
					},
				}
			},
			keys = {
				{ '<leader>n', mode = 'n', '<cmd>Neotree toggle<CR>', desc = "Neotree toggle" }
			},
		},
		{
			"nvim-treesitter/nvim-treesitter",
			event = 'BufEnter', config = function()
				require('nvim-treesitter.configs').setup({
					ensure_installed = { "go", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

					auto_install = true,

					highlight = {
						enable = true,
					},
				})
			end,
		},
		-- Colorschemes, use vim.cmd.colorscheme in the configuration below to change the default one
		{ "luisiacc/gruvbox-baby",            name = "gruvbox-baby", priority = 1000, lazy = false },
		{ "catppuccin/nvim",                  name = "catppuccin",   priority = 1000, lazy = false },
		{ "nyoom-engineering/oxocarbon.nvim", priority = 1000,       lazy = false },
		{ "rebelot/kanagawa.nvim",            priority = 1000,       lazy = false },
		{ "sho-87/kanagawa-paper.nvim",       priority = 1000,       lazy = false },
		{ "navarasu/onedark.nvim",            priority = 1000,       lazy = false },
		-- Autocomplete
		{ 'neovim/nvim-lspconfig',            lazy = false },
		{
			'hrsh7th/cmp-nvim-lsp',
			lazy = false,
			config = function()
				local c = require('cmp_nvim_lsp').default_capabilities()
				for i = 1, #lsp_servers do
					vim.lsp.config(lsp_servers[i], { capabilities = c })
				end
			end
		},
		{
			'hrsh7th/nvim-cmp',
			dependencies = 'L3MON4D3/LuaSnip',
			event = 'InsertEnter',
			config = function()
				local cmp = require('cmp')
				cmp.setup({
					sources = {
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
						{ name = 'buffer' },
					},
					snippet = {
						expand = function(args)
							require('luasnip').lsp_expand(args.body)
						end,
					},
					mapping = require('cmp').mapping.preset.insert({}),
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},

					matching = {
						disallow_fuzzy_matching = false,
						disallow_fullfuzzy_matching = false,
						disallow_partial_fuzzy_matching = false,
						disallow_partial_matching = false,
						disallow_prefix_unmatching = false,
					},
				})
			end,
		},
		{
			'L3MON4D3/LuaSnip',
			event = 'InsertEnter',
		},
		{
			"williamboman/mason.nvim", opts = {}, lazy = false
		},
		{
			"mason-org/mason-lspconfig.nvim",
			lazy = false,
			opts = {
				ensure_installed = lsp_servers
			},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{
			'kylechui/nvim-surround',
			version = '*',
			opts = {},
			keys = { 'cs', 'ds', 'ys', { 'S', mode = 'x' } },
		},
		{
			'ibhagwan/fzf-lua',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			lazy = false,
			config = function()
				require('fzf-lua').register_ui_select()
			end,
			keys = {
				{ '<leader>ff', mode = 'n', function() require('fzf-lua').files() end,     desc = 'Fzf files' },
				{ '<leader>fg', mode = 'n', function() require('fzf-lua').buffers() end,   desc = 'Fzf buffers' },
				{ '<leader>fb', mode = 'n', function() require('fzf-lua').live_grep() end, desc = 'Fzf grep' }
			},
		},
		{
			'folke/which-key.nvim',
			event = 'VeryLazy',
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			opts = {}
		},
	},
	{
		defaults = {
			lazy = true
		},
	})

-------------------
-- Configuration --
-------------------

vim.wo.number = true
vim.o.relativenumber = true

vim.opt.winborder = 'rounded'

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Hide mouse cursor
vim.opt.mouse = ""

vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.undolevels = 5000
vim.opt.undofile = true
vim.opt.autoread = true
vim.opt.scrolloff = 10

-- Colorscheme --

-- vim.cmd.colorscheme("catppuccin-mocha")
-- vim.cmd.colorscheme("gruvbox-baby")
vim.cmd.colorscheme("kanagawa-wave")

-- Transparent Background

-- vim.cmd([[
--  hi Normal guibg=NONE ctermbg=NONE
--  hi NormalNC guibg=NONE ctermbg=NONE
--  hi VertSplit guibg=NONE ctermbg=NONE
--  hi StatusLine guibg=NONE ctermbg=NONE
--  hi LineNr guibg=NONE ctermbg=NONE
-- ])


-- Keymaps --

-- add line when pressing ESC
vim.api.nvim_set_keymap('n', '<Enter>', 'o<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-CR>', 'O<Esc>', { noremap = true, silent = true })

-- Leader key mappings
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })      -- Save file
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })      -- Quit file
vim.api.nvim_set_keymap('n', '<leader>e', ':wq<CR>', { noremap = true, silent = true })     -- save and quit file

vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true }) -- vertical split
vim.api.nvim_set_keymap('n', '<leader>h', ':split<CR>', { noremap = true, silent = true })  -- horizontal split

vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })          -- move to left split
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })          -- move to bottom split
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })          -- move to top split
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })          -- move to right split

vim.api.nvim_set_keymap('n', '<leader>a', 'gg0vG$', { noremap = true, silent = true })      -- copy all file

-- Center cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Clipboard/Registers --

-- sync OS and vim clipboard
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })  -- Delete without yanking
vim.keymap.set("x", "x", '"_x', { noremap = true, silent = true })  -- Delete without yanking
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true }) -- Paste without overwriting register--vim.clipboard

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Indentation --
-- Let tree sitter handle indentation except for when it doesn't work

vim.opt.smartindent = false
vim.opt.autoindent = false
vim.opt.cindent = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.expandtab = false

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
	desc = 'Set indentation settings for curly brace languages',
	pattern = { '*.c', '*.cc', '*.cpp', '*.h', '*.hh', '*.hpp', '.y', '.yy', '.l', '.ll' },
	callback = function()
		vim.opt.expandtab = false
		vim.opt.cinoptions = ':0l1b1(0'
		vim.opt.cindent = true
	end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
	desc = 'Remove trailing spaces',
	-- pattern = '^(.*.diff)', -- for `git add -p` when you edit to remove '-' lines TODO: fix
	callback = function()
		vim.cmd([[%s/\s\+$//e]])
	end
})

-- Diagnostics --

vim.diagnostic.config({
	underline = true,
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN]  = '▲',
			[vim.diagnostic.severity.HINT]  = '⚑',
			[vim.diagnostic.severity.INFO]  = '»',
		},
	},
	virtual_text = false,
	float = {
		border = 'single',
		format = function(diagnostic)
			return string.format(
				'%s (%s) [%s]',
				diagnostic.message,
				diagnostic.source,
				diagnostic.code or diagnostic.user_data.lsp.code
			)
		end,
	},
})

vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- LSP --

vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT', },
			diagnostics = {
				globals = { 'vim', 'require' }, -- Get the language server to recognize the `vim` global
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
			},
			telemetry = { enable = false, },
		},
	},
})

for i = 1, #lsp_servers do
	vim.lsp.enable(lsp_servers[i])
end

local wk = require('which-key')
wk.add({
	{
		mode = 'n',
		{ 'gd',    function() vim.lsp.buf.definition() end,       desc = 'lsp: Go to definition of symbol' },
		{ 'gD',    function() vim.lsp.buf.declaration() end,      desc = 'lsp: Go to declaration of symbol' },
		{ 'gi',    function() vim.lsp.buf.implementation() end,   desc = 'lsp: Go to implementation of symbol' },
		{ 'go',    function() vim.lsp.buf.type_definition() end,  desc = 'lsp: Go to type definition of symbol' },
		{ 'gR',    function() vim.lsp.buf.references() end,       desc = 'lsp: Find references of symbol' },
		{ 'gh',    function() vim.lsp.buf.hover() end,            desc = 'lsp: Show information about symbol under the cursor' },
		{ 'gr',    function() vim.lsp.buf.rename() end,           desc = 'lsp: Rename symbol under cursor' },
		{ 'ga',    function() vim.lsp.buf.code_action() end,      desc = 'lsp: Show code actions for symbol' },
		{ 'gs',    function() vim.lsp.buf.signature_help({}) end, desc = 'lsp: Show signature help for function' },
		{ 'gF',    mode = { 'n', 'x' },                           function() vim.lsp.buf.format({ async = true }) end,                                           desc = 'lsp: Format buffer (async)' },
		{ '<c-s>', mode = 'i',                                    function() vim.lsp.buf.signature_help({ close_events = { "CursorMoved", "InsertLeave" } }) end, desc = 'lsp: Show signature help for function' },
	}
})
