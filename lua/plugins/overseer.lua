return {
  "stevearc/overseer.nvim",
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    templates = { "builtin", "just" },
    task_list = {
      direction = "bottom",
      min_height = 15,
    },
    component_aliases = {
      default = {
        { "on_output_parse", problem_matcher = "$rustc" },
        "on_exit_set_status",
        "on_complete_notify",
        { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
      },
    },
  },
  config = function(_, opts)
    local overseer = require "overseer"
    overseer.setup(opts)
  end,
}
