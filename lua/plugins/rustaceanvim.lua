return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,

    opts = function(_, opts)
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      local astrolsp_opts = (astrolsp_avail and astrolsp.lsp_opts "rust_analyzer") or {}

      local server = {
        ---@type table | (fun(project_root:string|nil, default_settings: table|nil):table)
        settings = function(project_root, default_settings)
          local astrolsp_settings = astrolsp_opts.settings or {}

          local merge_table = require("astrocore").extend_tbl(default_settings or {}, astrolsp_settings)
          local ra = require "rustaceanvim.config.server"

          return ra.load_rust_analyzer_settings(project_root, {
            settings_file_pattern = "rust-analyzer.json",
            default_settings = merge_table,
          })
        end,
      }
      return { server = require("astrocore").extend_tbl(astrolsp_opts, server) }
    end,

    config = function(_, opts) vim.g.rustaceanvim = require("astrocore").extend_tbl(opts, vim.g.rustaceanvim) end,
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      handlers = { rust_analyzer = false },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "rust-analyzer", "codelldb" },
    },
  },
}
