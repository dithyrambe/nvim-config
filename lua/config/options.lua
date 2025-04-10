-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true
vim.opt.mouse = ""
vim.opt.relativenumber = false

vim.api.nvim_create_user_command("Pr", function(opts)
  vim.cmd("Octo pr " .. (opts.args or ""))
end, { nargs = "*" })
vim.api.nvim_create_user_command("Review", function(opts)
  vim.cmd("Octo review " .. (opts.args or ""))
end, { nargs = "*" })
