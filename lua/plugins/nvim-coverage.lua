return {
	"andythigpen/nvim-coverage",
	dependencies = "nvim-lua/plenary.nvim",
	cmd = { "Coverage", "CoverageShow", "CoverageLoad", "CoverageToggle" },
	opts = {
		auto_reload = true,
		lang = {
			rust = {
				-- Use an absolute path or a robust relative path
				coverage_command = "cargo llvm-cov --lcov --output-path lcov.info",
				report_files = {
					-- This searches the project root first
					vim.fn.getcwd() .. "/lcov.info",
					"lcov.info",
				},
			},
		},
	},
	keys = {
		{
			"<leader>Tc",
			function()
				-- 1. Generate the data
				vim.fn.system("cargo llvm-cov --lcov --output-path lcov.info")
				-- 2. Load the data using the absolute path we know works
				require("coverage").load_lcov(vim.fn.getcwd() .. "/lcov.info", true)
				-- 3. Show it
				require("coverage").show()
				vim.notify("Coverage Updated", vim.log.levels.INFO)
			end,
			desc = "Rust: Run & Load Coverage",
		},
	},
}
