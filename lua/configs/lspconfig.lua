require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

vim.lsp.handlers["text_document/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

vim.lsp.handlers["text_document/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded",
  }
)
-- read :h vim.lsp.config for changing options of lsp servers 
