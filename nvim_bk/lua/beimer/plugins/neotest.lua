require("neotest").setup({
	adapters = {
		require("neotest-jest")({
			jestCommand = "node 'node_modules/.bin/jest' ",
			env = { CI = true },
			-- jestConfigFile = "custom.jest.config.ts",
			-- cwd = function(path)
			-- 	return vim.fn.getcwd()
			-- end,
			jestConfigFile = function(file)
				if string.find(file, "/packages/") then
					return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
				end

				return vim.fn.getcwd() .. "/jest.config.ts"
			end,
			cwd = function(file)
				if string.find(file, "/packages/") then
					return string.match(file, "(.-/[^/]+/)src")
				end
				return vim.fn.getcwd()
			end,
		}),
	},
})
