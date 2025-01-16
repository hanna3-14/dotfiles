return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		config = require("nvim-treesitter.configs")
		config.setup({
			-- ensure_installed = { "lua", "rust" }, -- auto_install = true
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
