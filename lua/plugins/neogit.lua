return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
    "echasnovski/mini.pick", -- optional
  },
  config = true,
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>" },
  },
}
