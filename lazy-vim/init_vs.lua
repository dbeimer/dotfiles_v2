vim.g.mapleader = " "

local keymap = vim.keymap

--general keymaps
local vscode = require("vscode-neovim")

keymap.set("n", "<leader>w", function()
  vscode.call("workbench.action.files.save")
end)

keymap.set("n", "<leader>q", function()
  vscode.call("workbench.action.closeActiveEditor")
end)

keymap.set("n", "<leader>Q", function()
  vscode.call("workbench.action.closeWindow")
end)

keymap.set("n", "<leader>e", function()
  -- vscode.call("workbench.view.explorer")
  vscode.call("workbench.action.toggleSidebarVisibility")
end)

keymap.set("n", "gr", function()
  vscode.call("editor.action.goToReferences")
end)
keymap.set("n", "r", function()
  vscode.call("editor.action.rename")
end)

keymap.set("n", "<leader>ff", function()
  vscode.call("workbench.action.quickOpen")
end)

keymap.set("n", "<leader>fg", function()
  vscode.call("workbench.view.search")
end)

keymap.set("n", "<leader>fb", function()
  vscode.call("workbench.action.showAllEditors")
end)
