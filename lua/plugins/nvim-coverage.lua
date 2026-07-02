-- Coverage as an on-demand, scoped visualization, not a number to chase.
--
-- <Leader>Tc runs the skeleton repo's `cargo cov-lcov` alias (nextest + llvm-cov
-- with the Vulkan/FFI and windowing code excluded) asynchronously, then paints
-- covered/uncovered signs in the gutter for the logic you actually regress-test.
-- Deliberately a separate, explicit action rather than something that fires after
-- every test run: generating the report takes a few seconds.
--
-- The built-in `:Coverage` loader for rust is intentionally not used: it expects
-- llvm-cov JSON on stdout and treats any stderr (cargo's compile progress) as an
-- error, so this drives everything through `cargo cov-lcov` writing lcov.info and
-- `load_lcov` reading it back.
return {
  "andythigpen/nvim-coverage",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = { "CoverageLoadLcov", "CoverageShow", "CoverageHide", "CoverageToggle", "CoverageSummary", "CoverageClear" },
  opts = {
    auto_reload = true,
  },
  keys = {
    {
      "<Leader>Tc",
      function()
        local lcov = vim.fn.getcwd() .. "/lcov.info"
        vim.notify("Running coverage (cargo cov-lcov)...", vim.log.levels.INFO)
        vim.fn.jobstart({ "cargo", "cov-lcov" }, {
          on_exit = function(_, code)
            vim.schedule(function()
              if code == 0 then
                require("coverage").load_lcov(lcov, true)
                vim.notify("Coverage loaded", vim.log.levels.INFO)
              else
                vim.notify("Coverage failed (exit " .. code .. ")", vim.log.levels.ERROR)
              end
            end)
          end,
        })
      end,
      desc = "Test: run + load coverage",
    },
    {
      "<Leader>TC",
      function() require("coverage").toggle() end,
      desc = "Test: toggle coverage signs",
    },
    {
      "<Leader>Ts",
      function() require("coverage").summary() end,
      desc = "Test: coverage summary",
    },
  },
}
