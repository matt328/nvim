return {
	"rebelot/heirline.nvim",
	opts = function(_, opts)
		-- This physically removes the tabline from the UI engine
		opts.tabline = nil
		return opts
	end,
}
