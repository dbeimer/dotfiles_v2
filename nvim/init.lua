require("beimer.plugins-setup")
require("beimer.core.options")
require("beimer.core.colorscheme")
require("beimer.core.keymaps")

require("beimer.plugins.comment")
require("beimer.plugins.nvim-tree")
require("beimer.plugins.lualine")
require("beimer.plugins.nvim-cmp")
require("beimer.plugins.telescope")

-- lsp
require("beimer.plugins.lsp.mason")
require("beimer.plugins.lsp.lspsaga")
require("beimer.plugins.lsp.lspconfig")

require("beimer.plugins.null-ls")
require("beimer.plugins.autopairs")
require("beimer.plugins.treesitter")
require("beimer.plugins.gitsigns")

-- still in config
require("beimer.plugins.nvim-dap")
require("beimer.plugins.neotest")
require("beimer.plugins.notify")
