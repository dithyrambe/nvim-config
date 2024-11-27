return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-j>"] = cmp.mapping(function(_) end, { "i", "s" }),
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>o", "<Cmd> Telescope find_files <CR>", desc = "Open file" },
      { "<leader>sg", "<Cmd> Telescope git_files <CR>", desc = "Search git files" },
      { "<leader> ", "<Cmd> Telescope buffers <CR>", desc = "Find buffers" },
      { "<leader>gr", "<Cmd> Telescope live_grep <CR>", desc = "Live grep" },
      { "<leader>G", "<Cmd> Telescope grep_string <CR> <Esc>", desc = "Grep string" },
      { "<leader>G", "<Cmd> Telescope grep_string <CR> <Esc>", desc = "Grep string", mode = { "v" } },
    },
  },
  {
    "numToStr/FTerm.nvim",
    config = function()
      local fterm = require("FTerm")
      vim.keymap.set("n", "<C-t>", function()
        fterm:toggle()
      end)
      vim.keymap.set("t", "<C-t>", function()
        fterm:toggle()
      end)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "pyright" },
      })
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
      })
    end,
    keys = {
      {
        "gd",
        function()
          vim.lsp.buf.declaration()
        end,
        desc = "Go to declaration",
      },
    },
  },
}
