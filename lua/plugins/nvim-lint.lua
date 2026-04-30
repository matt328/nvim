return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"

    lint.linters_by_ft = {
      terraform = { "tflint" },
      tf = { "tflint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Get the current buffer type
        local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })

        -- Only run linter if the buffer is NOT a terminal
        if buftype ~= "terminal" then lint.try_lint() end
      end,
    })
  end,
}
