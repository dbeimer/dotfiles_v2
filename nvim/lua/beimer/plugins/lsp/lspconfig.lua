local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	-- -- keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	-- -- keymap.set("n", "gf", vim.lsp.buf.lsp_finder, opts)
	-- keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	-- keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	-- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)
	-- -- keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	-- keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	-- keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	-- keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	-- keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	-- keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	-- keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	-- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
	-- keymap.set("n", "<space>f", vim.lsp.buf.formatting, opts)
	--
	-- -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
	-- keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	-- keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	-- keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
	keymap.set("n", "<space>f", vim.lsp.buf.formatting, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["tsserver"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["emmet_language_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["prismals"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

local signs = { Error = " ", Warn = " ", Hint = "󰵷 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
