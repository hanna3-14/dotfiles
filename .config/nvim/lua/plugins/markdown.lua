return {
	{
		-- rendering markdown directly in neovim
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		opts = {},

		config = function()
			require("render-markdown").setup()
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		config = function()
			vim.fn["mkdp#util#install"]()
			vim.keymap.set("n", "<C-r>", ":MarkdownPreviewToggle<CR>")
		end,
	},
}
