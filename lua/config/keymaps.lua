-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Close buffers
vim.keymap.set("n", "X", "<cmd>bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>X", function()
  local current_buf = vim.fn.bufnr()
  for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if buf.bufnr ~= current_buf and buf.name:find("neo%-tree") == nil then
      vim.cmd("bdelete " .. buf.bufnr)
    end
  end
end, { desc = "Close others" })
