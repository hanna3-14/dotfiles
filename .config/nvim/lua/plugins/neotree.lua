-- https://github.com/nvim-neo-tree/neo-tree.nvim?tab=readme-ov-file#longer-example-for-lazynvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Neotree" },
  keys = {
    {
      "<C-n>",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "toggle Neotree",
    },
  },
  opts = {
    close_if_last_window = true,
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
