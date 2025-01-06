return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<C-f>", builtin.live_grep, {}) -- install ripgrep via pacman to make this work

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						n = {
							["¿"] = actions.close,
						},
					},
				},
			})
		end,
	},
	-- more beautiful window for code actions
	{
	 	"nvim-telescope/telescope-ui-select.nvim",
	 	config = function()
	 		require("telescope").setup({
	 			extensions = {
	 				["ui-select"] = {
	 					require("telescope.themes").get_dropdown({}),
	 				},
	 			},
	 		})
	 		require("telescope").load_extension("ui-select")
	 	end,
	},
}
