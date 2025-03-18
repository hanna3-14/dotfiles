return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    servers = {
      angularls = {
        mason = true,
      },
    },
    config = function()
      require("lspconfig").angularls.setup({
        on_attach = require("blink.cmp").on_attach,
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
  },
  {
    "joeveiga/ng.nvim",
    dependencies = { "mason.nvim" }, -- needs angularls to be configured
    config = function()
      local opts = { noremap = true, silent = true }
      local ng = require("ng")
      vim.keymap.set("n", "<leader>at", ng.goto_template_for_component, opts)
      vim.keymap.set("n", "<leader>ac", ng.goto_component_with_template_file, opts)
      vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
    end,
  },
}
