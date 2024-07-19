local neotest = require("neotest")

local package_scripts = nil
local package_test_scripts = nil
local test_choises = { "Chose default command:" }
local default_unit_command = nil

local function get_npm_scripts()
	-- Ejecutar el comando 'npm run --json' y obtener la salida
	local handle = io.popen("npm run --json")
	local result = handle:read("*a")
	handle:close()

	-- Intentar decodificar el JSON
	local success, scripts = pcall(vim.fn.json_decode, result)
	if not success then
		print("Error al decodificar la salida de npm: " .. scripts)
		return {}
	end

	return scripts
end

local function find_in_scripts(scripts, text)
	local test_scripts = {}
	for name, command in pairs(scripts) do
		if string.find(name, text) or name == text then
			table.insert(test_scripts, { name = name, command = command })
			table.insert(test_choises, name)
		end
	end
	return test_scripts
end

neotest.setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = function()
				if package_scripts == nil then
					vim.notify("Scripts extracted!")
					package_scripts = get_npm_scripts()
				end
				if package_test_scripts == nil then
					package_test_scripts = find_in_scripts(package_scripts, "test")
				end

				if default_unit_command == nil then
					default_unit_command = package_test_scripts[vim.fn.inputlist(test_choises)]["command"]
					vim.notify(default_unit_command)
				end
				if default_unit_command then
					return default_unit_command
				end

				return require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h"))
			end,
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

vim.keymap.set("n", "<leader>td", function()
	neotest.run.run({ strategy = "dap" })
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
