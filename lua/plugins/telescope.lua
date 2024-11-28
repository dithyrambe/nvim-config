return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>o", "<Cmd> Telescope find_files <CR>", desc = "Open file" },
    { "<leader>sg", "<Cmd> Telescope git_files <CR>", desc = "Search git files" },
    { "<leader> ", "<Cmd> Telescope buffers <CR>", desc = "Find buffers" },
    { "<leader>gr", "<Cmd> Telescope live_grep <CR>", desc = "Live grep" },
    { "<leader>G", "<Cmd> Telescope grep_string <CR> <Esc>", desc = "Grep string" },
    { "<leader>G", "<Cmd> Telescope grep_string <CR> <Esc>", desc = "Grep string", mode = { "v" } },
  },
}
