vim.g.mapleader = " "

local keymap = vim.keymap

--general keymaps

if vim.g.vscode then
	local vscode = require("vscode-neovim")

	keymap.set("n", "<leader>w", function()
		vscode.call("workbench.action.files.save")
	end)

	keymap.set("n", "<leader>q", function()
		vscode.call("workbench.action.closeWindowActiveEditor")
	end)

	keymap.set("n", "<leader>Q", function()
		vscode.call("workbench.action.closeWindow")
	end)

	keymap.set("n", "<leader>nt", function()
		-- vscode.call("workbench.view.explorer")
		vscode.call("workbench.action.toggleSidebarVisibility")
	end)
else
	keymap.set("i", "jk", "<ESC>")
	keymap.set("n", "<leader>w", ":w<CR>")
	keymap.set("n", "<leader>q", ":q<CR>")
	keymap.set("n", "<leader>Q", ":wq<CR>")
	keymap.set("n", "<leader>nh", ":nohl<CR>")

	--explorer
	keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
	-- keymap.set("i", "C-j", function()
	-- 	copilot.Accept("/<CR>")
	-- end)

	-- Debugger
	keymap.set("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { noremap = true })
	keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
	keymap.set("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
	keymap.set("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", { noremap = true })

	--text tabbing
	vim.keymap.set("n", "<S-Tab>", "<")
	vim.keymap.set("i", "<S-Tab>", "<Esc><i")
	vim.keymap.set("v", "<S-Tab>", "<gv")
	vim.keymap.set("v", "<Tab>", ">gv")
end
