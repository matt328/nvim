return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- 1. Map the filetype
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = { "prettier" }

      -- 2. Define the exact command and arguments
      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = {
        -- Force the use of the Mason-installed binary
        command = vim.fn.stdpath "data" .. "/mason/bin/prettier",
        -- Use 'args' (not prepend_args) to define the full command string
        args = {
          "--no-config",
          "--print-width",
          "120",
          "--prose-wrap",
          "always",
          "--stdin-filepath",
          "$FILENAME",
        },
      }
    end,
  },
}
