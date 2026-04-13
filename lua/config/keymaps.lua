-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- d any additional keymaps here
--
--
vim.api.nvim_set_keymap("i", "kk", "<Esc>", { noremap = true })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

local map = vim.keymap.set

-- CMake Shortcuts
map("n", "<leader>mg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>mb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>mr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
map("n", "<leader>mq", "<cmd>CMakeClose<cr>", { desc = "CMake Close" })

-- Automation: Build AND Run with one key (e.g., <F5>)
map("n", "<F5>", "<cmd>CMakeBuild<cr><cmd>CMakeRun<cr>", { desc = "CMake Build and Run" })

vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")

-- Jump to next closing delimiter in Insert Mode
vim.keymap.set("i", "<C-l>", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  -- Find the next ), ], }, ", or ' after the cursor
  local next_delimiter = line:find("[%)]%}%]\"']", col + 1)

  if next_delimiter then
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], next_delimiter })
  else
    -- Fallback: just move right if no delimiter is found, or do nothing
    local char_at_cursor = line:sub(col + 1, col + 1)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", true)
  end
end, { desc = "Jump to next closing delimiter" })

vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Add line below without leaving normal mode" })
