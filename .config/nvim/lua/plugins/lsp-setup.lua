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
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"marksman",
					"pyright",
					"gopls",
					"angularls",
				},
			})
		end,
	},
	-- configure LSPs and define key maps to communicate with LSPs
	{
		"neovim/nvim-lspconfig",
		dependencies = { " saghen/blink.cmp" },
		config = function()
			-- local on_attach = require("cmp_nvim_lsp").on_attach
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
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
				on_attach = on_attach,
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
				on_attach = on_attach,
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
			lspconfig.angularls.setup({
				on_attach = on_attach,
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
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				-- sources need to be manually added with :MasonInstall
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.markdownlint,
					-- python
					null_ls.builtins.diagnostics.pylint,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort, -- sort imports alphabetically
					null_ls.builtins.formatting.prettierd, -- supports many file types, e.g. json, yaml, typescript, ...
					-- golang
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.golines,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
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
