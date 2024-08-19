-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- lvim.colorscheme = "tokyonight"
-- lvim.transparent_window = true

-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup { { name = "black" }, }

-- Comment for golang projects
vim.o.expandtab = false

lvim.format_on_save = true
vim.wo.relativenumber = true
-- xnoremap("<leader>p", "\"_dP")


-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   { command = "metals", filetypes = { "scala" } },
-- }


-- Below config is required to prevent copilot overriding Tab with a suggestion
-- when you're just trying to indent!
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end
local on_tab = vim.schedule_wrap(function(fallback)
	local cmp = require("cmp")
	if cmp.visible() and has_words_before() then
		cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	else
		fallback()
	end
end)
lvim.builtin.cmp.mapping["<Tab>"] = on_tab



function SetupDapGo()
	require('dap-go').setup {
		dap_configurations = {
			{
				type = "go",
				name = "Attach remote",
				mode = "remote",
				request = "attach",
			},
		},
		delve = {
			path = "dlv",
			initialize_timeout_sec = 20,
			port = "${port}",
			args = { "serve" },
			build_flags = "",
		},
	}
end

lvim.plugins = {
	{ "folke/tokyonight.nvim" },
	{ "puremourning/vimspector" },
	{ "nvim-lua/plenary.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-vsnip" },
	{ "hrsh7th/vim-vsnip" },
	{ "mfussenegger/nvim-dap" },
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		-- config = SetupDapGo(),
	},
	{
		"scalameta/nvim-metals",
		config = function()
			require("user.metals").config()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup({
				suggestion = { enabled = false },
				panel = { enabled = false }
			})
		end
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"clangd"
			}
		}
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = "mfussenegger/nvim-dap",
	}
	-- {
	--   'sourcegraph/sg.nvim',
	--   build = 'nvim -l build/init.lua'
	-- }
}

lvim.builtin.telescope.pickers = {
	find_files = {
		layout_config = {
			width = 0.90,
			height = 0.9
		},
	},
	live_grep = {
		layout_config = {
			width = 0.90,
			height = 0.9
		},
	},
}

lvim.keys.normal_mode["go"] = "<cmd>lua require('metals').organize_imports()<cr>"
lvim.keys.normal_mode["gws"] = "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>"
-- lvim.lsp.buffer_mappings.normal_mode["go"] = "<cmd>lua require('metals').organize_imports()<cr>"
-- lvim.builtin.which_key.mappings["go"] = {
--   "<cmd>lua require('metals').organize_imports()<cr>", "Organize Imports"
-- }
-- lvim.lsp.buffer_mappings.normal_mode["gi"] = "<cmd>lua require('telescope.builtin').lsp_implementations<cr>"

-- Set vimspector options
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.g.vimspector_sidebar_width = 60

-- Define Lua functions for mappings
function GotoWindow(id)
	vim.cmd("call win_gotoid(" .. id .. ")")
end

function AddToWatch()
	local word = vim.fn.expand("<cexpr>")
	vim.fn['vimspector#AddWatch'](word)
end

-- Define key mappings
-- vim.api.nvim_set_keymap('n', '<leader>da', ':call vimspector#Launch()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dc', ':lua GotoWindow(vim.g.vimspector_session_windows.code)<CR>',
--   { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dv', ':lua GotoWindow(vim.g.vimspector_session_windows.variables)<CR>',
--   { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dw', ':lua GotoWindow(vim.g.vimspector_session_windows.watches)<CR>',
--   { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>ds', ':lua GotoWindow(vim.g.vimspector_session_windows.stack_trace)<CR>',
--   { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>do', ':lua GotoWindow(vim.g.vimspector_session_windows.output)<CR>',
--   { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>di', ':lua AddToWatch()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dx', ':call vimspector#Reset()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dX', ':call vimspector#ClearBreakpoints()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<S-k>', ':call vimspector#StepOut()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<S-l>', ':call vimspector#StepInto()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<S-j>', ':call vimspector#StepOver()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>d_', ':call vimspector#Restart()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dn', ':call vimspector#Continue()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>drc', ':call vimspector#RunToCursor()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>dh', ':call vimspector#ToggleBreakpoint()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<leader>de', ':call vimspector#ToggleConditionalBreakpoint()<CR>', { noremap = true })





-- require 'lspconfig'.metals.setup {}
local map = vim.keymap.set

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

-- LSP mappings
-- map("n", "gds", vim.lsp.buf.document_symbol)
-- map("n", "gws", vim.lsp.buf.workspace_symbol)
-- map("n", "<leader>cl", vim.lsp.codelens.run)
-- map("n", "<leader>ca", vim.lsp.buf.code_action)

-- map("n", "<leader>ws", function()
--   require("metals").hover_worksheet()
-- end)

-- all workspace diagnostics
map("n", "<leader>aa", vim.diagnostic.setqflist)

-- all workspace errors
map("n", "<leader>ae", function()
	vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
map("n", "<leader>aw", function()
	vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
map("n", "<leader>d", vim.diagnostic.setloclist)

map("n", "[c", function()
	vim.diagnostic.goto_prev({ wrap = false })
end)

map("n", "]c", function()
	vim.diagnostic.goto_next({ wrap = false })
end)


-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "RunOrTest",
		metals = {
			runType = "runOrTestFile",
			--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
}
dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	-- command = '/home/amirphl/Downloads/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
	command = '/home/amirphl/.vscode/extensions/ms-vscode.cpptools-1.20.5/debugAdapters/bin/OpenDebugAD7'
}
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			return vim.fn.input('Path to executable: ' .. vim.fn.getcwd() .. '/')
		end,
		cwd = '${workspaceFolder}',
		stopAtEntry = true,
		setupCommands = {
			{
				text = '-enable-pretty-printing',
				description = 'enable pretty printing',
				ignoreFailures = false
			},
		},
	},
	{
		name = 'Attach to gdbserver :1234',
		type = 'cppdbg',
		request = 'launch',
		MIMode = 'gdb',
		miDebuggerServerAddress = '127.0.0.1:1234',
		miDebuggerPath = '/usr/bin/gdb',
		cwd = '${workspaceFolder}',
		program = function()
			-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			return vim.fn.input('Path to executable: ' .. vim.fn.getcwd() .. '/')
		end,
		setupCommands = {
			{
				text = '-enable-pretty-printing',
				description = 'enable pretty printing',
				ignoreFailures = false
			},
		},
	},
}
dap.adapters.delve = {
	type = 'server',
	port = '${port}',
	executable = {
		command = 'dlv',
		args = { 'dap', '-l', '127.0.0.1:${port}' },
		-- add this if on windows, otherwise server won't open successfully
		-- detached = false
	}
}
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		-- program = "${file}"
		program = "/home/amirphl/user-management/cmd/http/"
		-- program = "/home/amirphl/user-management/cmd/grpc/main.go"
	},
	{
		type = "delve",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}"
	},
	-- works with go.mod packages and sub packages
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}"
	}
}


-- setup adapters
local dapVscodeJs = require("dap-vscode-js")
dapVscodeJs.setup({
	debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
	debugger_cmd = { 'js-debug-adapter' },
	adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

-- custom adapter for running tasks before starting debug
local custom_adapter = 'pwa-node-custom'
dap.adapters[custom_adapter] = function(cb, config)
	if config.preLaunchTask then
		local async = require('plenary.async')
		local notify = require('notify').async

		async.run(function()
			---@diagnostic disable-next-line: missing-parameter
			notify('Running [' .. config.preLaunchTask .. ']').events.close()
		end, function()
			vim.fn.system(config.preLaunchTask)
			config.type = 'pwa-node'
			dap.run(config)
		end)
	end
end

-- language config
for _, language in ipairs({ 'typescript', 'javascript' }) do
	dap.configurations[language] = {
		{
			name       = 'Launch',
			type       = 'pwa-node',
			request    = 'launch',
			program    = '${file}',
			rootPath   = '${workspaceFolder}',
			cwd        = '${workspaceFolder}',
			sourceMaps = true,
			skipFiles  = { '<node_internals>/**', 'node_modules/**' },
			protocol   = 'inspector',
			console    = 'integratedTerminal',
			-- runtimeArgs = {
			-- 	"--loader",
			-- 	"ts-node/esm"
			-- },
			-- runtimeExecutable = 'node',
			-- args = {
			-- 	"${file}"
			-- },
			-- resolveSourceMapLocations = {
			-- 	"${workspaceFolder}/**",
			-- 	"!**/node_modules/**"
			-- },
		},
		{
			name      = 'Attach to node process',
			type      = 'pwa-node',
			request   = 'attach',
			rootPath  = '${workspaceFolder}',
			processId = require('dap.utils').pick_process,
			cwd       = '${workspaceFolder}',
			-- sourceMaps = true,
		},
		{
			name = 'Debug Main Process (Electron)',
			type = 'pwa-node',
			request = 'launch',
			program = '${workspaceFolder}/node_modules/.bin/electron',
			args = {
				'${workspaceFolder}/dist/index.js',
			},
			outFiles = {
				'${workspaceFolder}/dist/*.js',
			},
			resolveSourceMapLocations = {
				'${workspaceFolder}/dist/**/*.js',
				'${workspaceFolder}/dist/*.js',
			},
			rootPath = '${workspaceFolder}',
			cwd = '${workspaceFolder}',
			sourceMaps = true,
			skipFiles = { '<node_internals>/**' },
			protocol = 'inspector',
			console = 'integratedTerminal',
		},
		{
			name = 'Compile & Debug Main Process (Electron)',
			type = custom_adapter,
			request = 'launch',
			preLaunchTask = 'npm run build-ts',
			program = '${workspaceFolder}/node_modules/.bin/electron',
			args = {
				'${workspaceFolder}/dist/index.js',
			},
			outFiles = {
				'${workspaceFolder}/dist/*.js',
			},
			resolveSourceMapLocations = {
				'${workspaceFolder}/dist/**/*.js',
				'${workspaceFolder}/dist/*.js',
			},
			rootPath = '${workspaceFolder}',
			cwd = '${workspaceFolder}',
			sourceMaps = true,
			skipFiles = { '<node_internals>/**' },
			protocol = 'inspector',
			console = 'integratedTerminal',
		},
	}
end
