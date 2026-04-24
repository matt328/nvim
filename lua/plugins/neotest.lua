return {
  "nvim-neotest/neotest",
  dependencies = {
    "rouge8/neotest-rust",
    "nvim-neotest/nvim-nio",
    "andythigpen/nvim-coverage",
    "mrcjkb/rustaceanvim",
  },
  opts = function(_, opts)
    opts.adapters = {
      require "rustaceanvim.neotest",
    }

    -- Extend the adapters or listeners
    opts.consumers = opts.consumers or {}

    -- Uncomment this block to run coverage automatically after each test
    -- probably want a separate keybinding for watching with coverage
    -- as parsing the coverage info does take a second or two
    --
    -- We create a custom consumer to bridge Neotest and nvim-coverage
    -- opts.consumers.coverage = function(client)
    -- 	client.listeners.results = function(adapter_id, results, partial)
    -- 		-- Only trigger if this is a Rust adapter and not a partial result
    -- 		if adapter_id:match("rust") and not partial then
    -- 			-- Run llvm-cov in the background
    -- 			vim.fn.system("cargo llvm-cov --lcov --output-path lcov.info")
    --
    -- 			-- Schedule the UI update so Neovim stays responsive
    -- 			vim.schedule(function()
    -- 				require("coverage").load_lcov(vim.fn.getcwd() .. "/lcov.info", true)
    -- 				require("coverage").show()
    -- 			end)
    -- 		end
    -- 	end
    -- 	return {}
    -- end
  end,
}
