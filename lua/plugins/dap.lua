return {
	{
		"rcarriga/nvim-dap-ui",
		opts = {
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.5 },
						{ id = "breakpoints", size = 0.2 },
						{ id = "stacks", size = 0.3 },
					},
					position = "right",
					size = 40,
				},
				{
					elements = { { id = "repl", size = 1.0 } },
					position = "bottom",
					size = 10,
				},
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)

			print("CONFIG LOADED")

			-- Define an adapter
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb",
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Game",
					type = "codelldb",
					request = "launch",
					program = vim.fn.getcwd() .. "/target/debug/game",
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					showDisassembly = "never",
					sourceLanguages = { "rust" },
					expressions = "native",
				},
			}

			-- Auto open the debug ui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			-- Auto close the debug ui
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
