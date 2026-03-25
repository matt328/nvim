-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLine = { link = "Visual" },
  },
}

-- Auto-load session on startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("Persistence", { clear = true }),
  callback = function()
    -- Only load if we aren't opening a specific file (e.g., 'nvim main.rs')
    -- and we aren't in a git commit message or empty buffer.
    if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
      require("persistence").load()
    end
  end,
  nested = true,
})

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
