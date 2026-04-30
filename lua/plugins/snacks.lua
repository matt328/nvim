return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        -- This targets the specific "grep" logic
        grep = {
          -- Tell snacks to respect your ignore files
          exclude = { "target", "lcov.info" },
          -- Ensure it doesn't pass -u or --no-ignore
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        },
      },
    },
  },
}
