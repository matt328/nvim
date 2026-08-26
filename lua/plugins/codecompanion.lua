return {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      http = {
        ["llama.cpp"] = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://192.168.50.2:8080", -- your llama-server address
              chat_url = "/v1/chat/completions",
              api_key = "TERM", -- llama-server doesn't check this, but a non-empty string keeps the schema happy
            },
            schema = {
              model = {
                -- purely a display label — llama-server ignores it and serves whatever model it was started with
                default = "local-model",
              },
              num_ctx = {
                default = 16384,
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = { adapter = "llama.cpp" },
      inline = { adapter = "llama.cpp" },
      cmd = { adapter = "llama.cpp" },
    },
  },
}
