return {
  "andythigpen/nvim-coverage",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = { "Coverage", "CoverageShow", "CoverageLoad", "CoverageToggle" },
  opts = {
    auto_reload = true,
    lang = {
      rust = {
        coverage_command = "cargo llvm-cov --lcov --output-path lcov.info",
        report_files = {
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
        vim.fn.system "cargo llvm-cov --lcov --output-path lcov.info"
        require("coverage").load_lcov(vim.fn.getcwd() .. "/lcov.info", true)
        require("coverage").show()
        vim.notify("Coverage Updated", vim.log.levels.INFO)
      end,
      desc = "Rust: Run & Load Coverage",
    },
  },
}
