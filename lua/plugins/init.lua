return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            local on_attach = require("nvchad.configs.lspconfig").on_attach
            local capabilities = require("nvchad.configs.lspconfig").capabilities

            on_attach(client, bufnr)
          end,
        },
        tools = {
          hover_actions = {
            border = "rounded",
            auto_focus = false,
          },
        },
      }
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "terminal" },
    },
    config = function(_, opts)
      require("persistence").setup(opts)

      -- Fix: Re-open NvimTree after the session loads
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceLoadPost",
        callback = function()
          require("nvim-tree.api").tree.toggle(false, true)
        end,
      })
    end,
  },
  {
    "nvchad/nvterm",
    opts = {
      terminals = {
        type_opts = {
          horizontal = {
            location = "rightbelow", -- Ensures it opens at the very bottom
            split_ratio = 0.3,
          },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "mrcjkb/rustaceanvim",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "rustaceanvim.neotest",
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "rust",
        "ron",
      },
      highlight = { enabled = true },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "User FilePost", -- Loads after you open a file
    config = function()
      require("illuminate").configure {
        delay = 100, -- Highlight after 100ms of staying still
        filetypes_denylist = { "NvimTree", "TelescopePrompt" },
      }
    end,
  },
}
