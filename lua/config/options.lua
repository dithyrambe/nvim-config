-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true
-- vim.g.lazyvim_python_lsp = "pyright"
vim.opt.mouse = ""

vim.api.nvim_create_user_command("Pr", function(opts)
  vim.cmd("Octo pr " .. (opts.args or ""))
end, { nargs = "*" })
