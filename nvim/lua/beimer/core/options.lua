local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs # indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- seach settings

opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- parse it into lua
-- vim.g.copilot_no_tab_map = true
vim.cmd('imap <silent><script><expr> <C-J> copilot#Accept("<CR>")')
vim.cmd("let g:copilot_no_tab_map = v:true")

-- autosave folds
local autosaveFoldsId = vim.api.nvim_create_augroup("AutoSaveFolds", { clear = true })

vim.api.nvim_create_autocmd("BufWinLeave", {
	pattern = "?*",
	command = "mkview 1",
	group = autosaveFoldsId,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "?*",
	command = "silent! loadview 1",
	group = autosaveFoldsId,
})
