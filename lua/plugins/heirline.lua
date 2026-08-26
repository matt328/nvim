return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    local tokens = status.component.builder {
      {
        condition = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local ok, chat = pcall(function() return require("codecompanion").buf_get_chat(bufnr) end)
          return ok and chat ~= nil
        end,
        provider = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local chat = require("codecompanion").buf_get_chat(bufnr)
          if not chat then return "" end
          local total_tokens = 0
          for _, message in ipairs(chat.messages) do
            if message._meta and message._meta.estimated_tokens then
              total_tokens = total_tokens + message._meta.estimated_tokens
            end
          end
          local max_ctx = (chat.settings and chat.settings.num_ctx) or 32768
          local percentage = math.floor((total_tokens / max_ctx) * 100)
          return string.format(" 󰚩 %d/%d (%d%%%%) ", total_tokens, max_ctx, percentage)
        end,
        hl = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local ok, chat = pcall(function() return require("codecompanion").buf_get_chat(bufnr) end)
          if not ok or not chat then return { fg = "fg" } end
          local total_tokens = 0
          for _, message in ipairs(chat.messages) do
            if message._meta and message._meta.estimated_tokens then
              total_tokens = total_tokens + message._meta.estimated_tokens
            end
          end
          local max_ctx = (chat.settings and chat.settings.num_ctx) or 32768
          local ratio = total_tokens / max_ctx
          if ratio > 0.85 then
            return { fg = "fg", bold = true }
          elseif ratio > 0.60 then
            return { fg = "fg" }
          end
          return { fg = "fg" }
        end,
      },
    }

    -- insert wherever you want it, e.g. before the last couple entries
    table.insert(opts.statusline, #opts.statusline - 2, tokens)

    return opts
  end,
}
