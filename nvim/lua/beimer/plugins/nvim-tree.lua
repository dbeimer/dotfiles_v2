local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings form nvim-tree documentation

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
})
