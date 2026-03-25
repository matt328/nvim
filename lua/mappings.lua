require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>ca", function()
  vim.cmd.RustLsp "codeAction"
end, { desc = "Rust Code Actions" })

map("n", "<leader>vr", function()
  vim.cmd "vsplit"
  vim.lsp.buf.definition()
end, { desc = "LSP definition in vertical split" })

map("n", "K", function()
  vim.cmd.RustLsp { "hover", "actions" }
end, { desc = "RustaceanVim Hover Actions" })

map("n", "<leader>tl", function()
  vim.cmd "Telescope lsp_document_symbols"
end, { desc = "Document Symbols" })

map("n", "<leader>tw", function()
  vim.cmd "Telescope lsp_dynamic_workspace_symbols"
end, { desc = "Workspace Symbols" })

-- Neotest Mappings
map("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "Run Nearest Test" })

map("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run Current File" })

map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle Test Summary" })

map("n", "<leader>to", function()
  require("neotest").output.open { enter = true }
end, { desc = "Open Test Output" })

map("n", "<leader>tS", function()
  require("neotest").run.stop()
end, { desc = "Stop Running Test" })

map("n", "<leader>tw", function()
  require("neotest").watch.toggle()
end, { desc = "Toggle Watch Nearest Test" })

-- Watch the current file (The "Feature" Watch)
map("n", "<leader>tW", function()
  local neotest = require "neotest"
  if neotest.watch then
    neotest.watch.toggle(vim.fn.expand "%")
  else
    vim.notify "Neotest watch module not found"
  end
end, { desc = "Toggle Watch Current File" })

map("n", "<leader>le", function()
  vim.diagnostic.open_float()
end, { desc = "LSP Show Diagnostic Error" })

map("n", "<leader>lD", function()
  vim.diagnostic.setloclist()
end, { desc = "LSP Diagnostics List" })

map({ "n", "t" }, "<A-i>", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "Toggle Floating Terminal" })

map({ "n", "t" }, "<A-h>", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "Toggle Horizontal Terminal" })
