return {
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
}
