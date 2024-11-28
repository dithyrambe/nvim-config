return {
  "juacker/git-link.nvim",
  opts = {
    url_rules = {
      {
        pattern = "^ssh://[^@]+@([^:]+):29418/(.+)$",
        replace = "https://%1/plugins/gitiles/%2",
        format_url = function(base_url, params)
          -- Generates Gerrit Gitiles URLs: https://host/plugins/gitiles/project/+/refs/heads/branch/path#number
          return string.format(
            "%s/+/refs/heads/%s/%s#%d",
            base_url,
            params.branch,
            params.file_path,
            params.line_number
          )
        end,
      },
    },
  },
  keys = {
    {
      "<leader>gu",
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
