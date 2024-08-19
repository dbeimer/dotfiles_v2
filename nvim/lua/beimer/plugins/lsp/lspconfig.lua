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
	-- vim.spi.nvim_create_autocmd("CursorHold", {
	-- 	buffer = bufnr,
	-- 	callback = function()
	-- 		local opts = {
	-- 			focusable = false,
	-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	-- 			-- border = 'double',
	-- 			-- source = 'always',
	-- 			-- prefix = ' ',
	-- 			scope = "cursor",
	-- 			style = "minimal",
	-- 		}
	-- 		vim.diagnostic.open_float(nil, opts)
	-- 	end,
	-- })
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

lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

local signs = { Error = " ", Warn = " ", Hint = "󰵷 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

function PrintDiagnostics(opts, bufnr, line_nr, _)
	bufnr = bufnr or 0
	line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
	opts = opts or { ["lnum"] = line_nr }

	local line_diagnostics = vim.diagnostic.get(bufnr, opts)
	if vim.tbl_isempty(line_diagnostics) then
		return
	end

	local diagnostic_message = ""
	for i, diagnostic in ipairs(line_diagnostics) do
		diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
		print(diagnostic_message)
		if i ~= #line_diagnostics then
			diagnostic_message = diagnostic_message .. "\n"
		end
	end
	-- vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
	require("notify")(diagnostic_message, "error", {
		timeout = 0,
		title = "Diagnostics",
		icon = "",
	})
end

vim.diagnostic.config({ virtual_text = false }) -- disable virtual text
-- vim.cmd([[ autocmd! CursorHold,CursorHoldI * lua PrintDiagnostics() ]])
vim.api.nvim_command(
	"autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float({border='rounded', focusable=false})"
)
