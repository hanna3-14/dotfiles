return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    keys = {
      {
        "K",
        vim.lsp.buf.hover,
      },
      {
        "gd",
        vim.lsp.buf.definition,
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
      },
    },
  },
}
