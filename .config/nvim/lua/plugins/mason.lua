-- for managing external editor tooling such as LSP servers, DAP servers, linters and formatters
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
}

