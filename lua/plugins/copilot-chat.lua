return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
  },
  build = "make tiktoken",
  opts = {
    -- auto approve file reads, require approval for writes/edits
    trusted_tools = { "file", "glob", "grep", "gitdiff" },
  },
}
