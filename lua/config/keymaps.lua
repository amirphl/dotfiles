-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- C/C++ specific keymaps
vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header" })
vim.keymap.set("n", "<leader>ci", "<cmd>ClangdToggleInlayHints<cr>", { desc = "Toggle Inlay Hints" })

-- Better paste behavior
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without overwriting register" })

-- Clear any existing 's' mapping in normal mode to restore default behavior
vim.keymap.del("n", "s", { silent = true })

-- -- Additional useful keymaps
-- vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
-- vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
-- vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all" })

-- -- Better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- -- Better buffer navigation
-- vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- -- Quick fix and location list
-- vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open quickfix" })
-- vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix" })
-- vim.keymap.set("n", "<leader>lo", "<cmd>lopen<cr>", { desc = "Open location list" })
-- vim.keymap.set("n", "<leader>lc", "<cmd>lclose<cr>", { desc = "Close location list" })
