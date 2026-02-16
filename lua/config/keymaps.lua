-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- d any additional keymaps here
--
--
vim.api.nvim_set_keymap("i", "kk", "<Esc>", { noremap = false })
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

local map = vim.keymap.set

-- CMake Shortcuts
map("n", "<leader>mg", "<cmd>CMakeGenerate<cr>", { desc = "CMake Generate" })
map("n", "<leader>mb", "<cmd>CMakeBuild<cr>", { desc = "CMake Build" })
map("n", "<leader>mr", "<cmd>CMakeRun<cr>", { desc = "CMake Run" })
map("n", "<leader>mq", "<cmd>CMakeClose<cr>", { desc = "CMake Close" })

-- Automation: Build AND Run with one key (e.g., <F5>)
map("n", "<F5>", "<cmd>CMakeBuild<cr><cmd>CMakeRun<cr>", { desc = "CMake Build and Run" })
