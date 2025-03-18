return {
  -- define which LSPs should be automatically installed by mason
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = { "angularls" },
    },
  },
  -- configure LSPs and define key maps to communicate with LSPs
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
