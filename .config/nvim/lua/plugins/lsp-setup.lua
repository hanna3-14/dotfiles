-- mason is a plugin for managing external editor tooling such as LSP servers, DAP servers, linters and formatters
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	-- define which LSPs should be automatically installed by mason
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "marksman", "pyright" },
			})
		end,
	},
	-- configure LSPs and define key maps to communicate with LSPs
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities() -- use LSP for suggestions in snipped window
			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							-- get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require",
							},
						},
					},
				},
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			})
			lspconfig.marksman.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	-- for linting and formatting
	-- linters and formatters can either be defined by the respective LSP via nvim-lspconfig or with none-ls
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				-- sources need to be manually added with :MasonInstall
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.markdownlint,
					-- python
					null_ls.builtins.diagnostics.pylint,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort, -- sort imports alphabetically
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	-- add type annotations for rust
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
	},
}
