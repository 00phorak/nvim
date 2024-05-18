return {
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {}
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {},
		init = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<F7>", function() require("dapui").toggle() end,
				{ remap = false, desc = "Debugger Toggle" })
			vim.keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end,
				{ remap = false, desc = "Debugger Add/Remove Breakpoint" })
			vim.keymap.set("n", "<F5>", function() require("dap").continue() end,
				{ remap = false, desc = "Debugger Continue" })
			vim.keymap.set("n", "<F8>", function() require("dap").step_over() end,
				{ remap = false, desc = "Debugger Step Over" })
			vim.keymap.set("n", "<F9>", function() require("dap").step_into() end,
				{ remap = false, desc = "Debugger Step Into" })
			vim.keymap.set("n", "<F10>", function() require("dap").step_out() end,
				{ remap = false, desc = "Debugger Step Out" })
			vim.keymap.set("n", "<F12>", function() require("dap").repl.toggle() end,
				{ remap = false, desc = "Debugger Open REPL" })
			vim.keymap.set("n", "<leader>dr", function() require("dap").run_last() end,
				{ remap = false, desc = "Debugger Open REPL" })

			-- Debuggers
			-- Mostly copy-paste from https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua

			local lldb_vscode_path = io.popen('which lldb-vscode'):read("*a"):gsub("[\n\r]", "")

			local codelldb_config = {
				type = 'server',
				port = '${port}',
				executable = {
					-- command = "codelldb",
					command = lldb_vscode_path,
					args = { '--port', '${port}' },
				},
			}
			if vim.fn.has('win32') == 1 then
				codelldb_config.executable.detached = false
			end
			dap.adapters.codelldb = codelldb_config
			dap.configurations.rust = {
				{
					name = 'LLDB: Launch',
					type = 'codelldb',
					request = 'launch',
					showDisassembly = "never",
					program = function()
						vim.fn.jobstart('cargo build')
						local output = io.popen('find target/debug -name $(basename $(pwd))'):read("*a"):gsub("[\n\r]",
							"")
						print("Starting to debug: " .. output)
						return output
						-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},
					sourceLanguages = { 'rust' },
					terminal = 'integrated',
					console = 'integratedTerminal',
				},
			}

			local BASHDB_DIR = ''
			if
				require('mason-registry').has_package('bash-debug-adapter')
				and require('mason-registry').get_package('bash-debug-adapter'):is_installed()
			then
				BASHDB_DIR = require('mason-registry').get_package('bash-debug-adapter'):get_install_path()
					.. '/extension/bashdb_dir'
			end

			dap.adapters.bash = {
				type = 'executable',
				command = vim.fn.exepath('bash-debug-adapter'),
			}

			dap.configurations.bash = {
				{
					type = 'bash',
					request = 'launch',
					name = 'Bash: Launch file',
					program = '${file}',
					cwd = '${fileDirname}',
					pathBashdb = BASHDB_DIR .. '/bashdb',
					pathBashdbLib = BASHDB_DIR,
					pathBash = 'bash',
					pathCat = 'cat',
					pathMkfifo = 'mkfifo',
					pathPkill = 'pkill',
					env = {},
					args = {},
				},
			}

			dap.adapters.python = {
				type = 'executable',
				command = vim.fn.exepath('debugpy-adapter'),
			}

			local venv_path = os.getenv('VIRTUAL_ENV') or os.getenv('CONDA_PREFIX')
			dap.configurations.python = {
				{
					-- The first three options are required by nvim-dap
					type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
					request = 'launch',
					name = 'Python: Launch file',
					program = '${file}', -- This configuration will launch the current file if used.
					-- venv on Windows uses Scripts instead of bin
					pythonPath = venv_path
						and ((vim.fn.has('win32') == 1 and venv_path .. '/Scripts/python') or venv_path .. '/bin/python')
						or nil,
					console = 'integratedTerminal',
				},
			}
		end

	}
}
