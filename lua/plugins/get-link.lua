return {
  "juacker/git-link.nvim",
  keys = {
    {
      "<leader>gl",
      function()
        require("git-link.main").copy_line_url()
      end,
      desc = "Copy code line URL to clipboard",
    },
    {
      "<leader>go",
      function()
        require("git-link.main").open_line_url()
      end,
      desc = "Open code line in browser",
    },
  },
}
