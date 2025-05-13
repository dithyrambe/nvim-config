-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps hereby

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

-- IPython embed
vim.keymap.set("n", "<leader>bp", 'O__import__("IPython").embed()<Esc>')
vim.keymap.set("n", "<leader>yy", "<cmd>%y+<cr>")
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua<cr>")

function RunAthenaCLI()
  -- Get buffer content
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local input = table.concat(lines, "\n")

  -- Create a new scratch buffer for output
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf }) -- Wipe buffer when closed
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })

  -- Open in a split window like Vim's help docs
  vim.api.nvim_command("new") -- Open in vertical split
  vim.api.nvim_win_set_buf(0, buf) -- Set buffer in new window
  vim.api.nvim_set_option_value("filetype", "athenacli_output", { buf = buf })

  -- Disable line wrapping for horizontal scrolling
  vim.api.nvim_set_option_value("wrap", false, { win = 0 })
  vim.api.nvim_set_option_value("cursorline", true, { win = 0 })
  vim.api.nvim_set_option_value("wrap", false, { win = 0 })

  vim.api.nvim_buf_set_keymap(buf, "n", "<Left>", "10zh", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Right>", "10zl", { noremap = true, silent = true })
  -- Enable horizontal scrolling
  vim.api.nvim_set_option_value("sidescrolloff", 5, { win = 0 })

  -- Map 'q' to close the window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>bd<CR>", { noremap = True, silent = true })

  -- Command to run Athena query
  local cmd = "echo " .. vim.fn.shellescape(input) .. " | athenacli --table-format ascii -e -"

  -- Async execution
  local start_time = vim.fn.reltime()
  local output = {}

  local function on_output(_, data, _)
    if data then
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(output, line)
        end
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
    end
  end

  local function on_exit(_, code, _)
    local elapsed_time = vim.fn.reltimefloat(vim.fn.reltime(start_time))
    table.insert(output, "")
    table.insert(output, string.format("Query completed in %.2f seconds", elapsed_time))
    if code ~= 0 then
      table.insert(output, "Error: Query execution failed")
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  end

  -- Run Athena query asynchronously
  vim.fn.jobstart(cmd, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = on_output,
    on_stderr = on_output,
    on_exit = on_exit,
  })
end

vim.api.nvim_set_keymap("n", "<leader>ac", ":lua RunAthenaCLI()<CR>", { noremap = true, silent = true })
