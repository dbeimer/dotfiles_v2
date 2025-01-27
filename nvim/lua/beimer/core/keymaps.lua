vim.g.mapleader = " "

local keymap = vim.keymap

--general keymaps

if vim.g.vscode then
-- this has been added into the other file
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

	-- which-key
	keymap.set("n", "<leader>?", function()
		require("which-key").show({ global = false })
	end)

	require("which-key").register({
		c = {
			name = "ChatGPT",
			c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
			e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
			g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
			t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
			k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
			d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
			a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
			o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
			s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
			f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
			x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
			r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
			l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
		},
	}, { prefix = "<leader>" })
end
