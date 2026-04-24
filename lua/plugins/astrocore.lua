-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local function run_coverage(args)
  -- 1. Notify you that it's started
  vim.notify("Generating coverage...", vim.log.levels.INFO)

  -- 2. Construct the command (you can pass args like a file filter here)
  local cmd = "cargo llvm-cov --lcov --output-path lcov.info " .. (args or "")

  -- 3. Run in background, then update UI
  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.schedule(function()
          -- Reload the newly generated file
          require("coverage").load_lcov(vim.fn.getcwd() .. "/lcov.info", true)
          require("coverage").show()
          vim.notify("Coverage generated!", vim.log.levels.INFO)
        end)
      else
        vim.notify("Coverage generation failed!", vim.log.levels.ERROR)
      end
    end,
  })
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    autocmds = {
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            if vim.fn.argc(-1) == 0 then
              require("resession").load(vim.fn.getcwd(), {
                dir = "dirsession",
                silence_errors = true,
                reset = true, -- This is the key: it clears the current state before loading
              })
            end
          end,
        },
      },
    },
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        termguicolors = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["<Tab>"] = {
          function() require("astrocore.buffer").nav(vim.v.count1) end,
          desc = "Next buffer",
        },
        ["<S-Tab>"] = {
          function() require("astrocore.buffer").nav(-vim.v.count1) end,
          desc = "Previous buffer",
        },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<Leader>dg"] = {
          function()
            local dap = require "dap"
            if dap.configurations.rust and dap.configurations.rust[1] then
              dap.run(dap.configurations.rust[1])
            else
              print "No Rust debug configurations found!"
            end
          end,
          desc = "Debug Game executable",
        },
        ["<leader>ct"] = {
          "<cmd>CoverageToggle<cr>",
          desc = "Toggle Coverage Display",
        },

        -- Run Coverage for entire project
        ["<leader>cC"] = {
          function() run_coverage "" end,
          desc = "Run Coverage (Project)",
        },

        -- Run Coverage for current file
        ["<leader>cf"] = {
          function()
            local file = vim.fn.expand "%:p" -- Get current file path
            run_coverage("-- " .. file)
          end,
          desc = "Run Coverage (File)",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
