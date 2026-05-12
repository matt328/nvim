return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    templates = { "builtin", "vscode" },
    task_list = {},
  },
  config = function(_, opts)
    local overseer = require "overseer"
    overseer.setup(opts)
  end,
}
