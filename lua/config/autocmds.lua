-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-save files when focus is lost
vim.api.nvim_create_autocmd("FocusLost", {
  pattern = "*",
  command = "silent! wall",
})

-- Auto-format on save for specific file types
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.go", "*.lua", "*.py", "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Set filetype for specific files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.env*" },
  command = "set filetype=sh",
})

-- Auto-close quickfix and location list when leaving them
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = { "quickfix", "location-list" },
  command = "close",
})

-- Better terminal behavior
vim.api.nvim_create_autocmd("TermOpen", {
  command = "setlocal nonumber norelativenumber",
})
