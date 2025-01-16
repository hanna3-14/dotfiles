return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"buffers",
						show_filename_only = true,
						hide_filename_extension = false,
						show_modified_status = true,
						mode = 2,
						buffers_color = {
							active = "MyActiveBuffer",
							inactive = "lualine_c_inactive",
						},
						symbols = {
							modified = " ●",
							alternate_file = "",
							directory = "",
							readonly = "",
						},
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
