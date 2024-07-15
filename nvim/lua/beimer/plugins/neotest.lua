local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = "npm test --",
			jestConfigFile = function(file)
				-- TODO: improve thi validation
				-- NOTE: for e2e tests could be great to ask for config file if it's not founded
				if string.match(file, ".*/(.-)%.e2e%-spec%.ts$") then
					vim.notify("Test e2e detected!")
					return "test/jest-e2e.json"
				end

				if string.find(file, "/packages/") then
					return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
				end

				return vim.fn.getcwd() .. "/jest.config.ts"
			end,
			env = { CI = true },
			cwd = function()
				local cwd = vim.fn.getcwd()
				return cwd
			end,
			jest_test_discovery = true,
		}),
	},
	discovery = {
		enabled = false,
	},
})

vim.keymap.set("n", "<leader>tn", function()
	neotest.run.run()
end, { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>tf",
	"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ts",
	"<cmd>lua require('neotest').run.stop()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>ta",
	"<cmd>lua require('neotest').run.attach()<cr>",
	{ noremap = true, silent = true }
)
