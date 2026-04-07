return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		filesystem = {
			-- This removes the Git status logic from the main file tree
			bind_to_cwd = true,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},
		diagnostics = {
			enable = true,
			show_name = true,
		},
		-- Disable the global Git status integration for the file tree
		enable_git_status = false,
		renderers = {
			file = {
				{ "indent" },
				{ "icon" },
				{
					"name",
					use_git_status_colors = false,
					zindex = 10,
					highlight_groups = {
						-- Mapping the internal node state to your highlight groups
						error = "DiagnosticError",
						warn = "DiagnosticWarn",
						info = "DiagnosticInfo",
						hint = "DiagnosticHint",
					},
				},
				{ "diagnostics", errors_only = false },
			},
		},
	},
}
