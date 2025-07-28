-- Neovim Health Check Script
-- Run this with: nvim --headless -l health_check.lua

local function check_plugin(plugin_name)
  local ok, _ = pcall(require, plugin_name)
  if ok then
    print("✅ " .. plugin_name .. " - OK")
    return true
  else
    print("❌ " .. plugin_name .. " - NOT FOUND")
    return false
  end
end

local function check_lsp_server(server_name)
  local lspconfig = require("lspconfig")
  if lspconfig[server_name] then
    print("✅ LSP " .. server_name .. " - CONFIGURED")
    return true
  else
    print("❌ LSP " .. server_name .. " - NOT CONFIGURED")
    return false
  end
end

local function check_mason_tool(tool_name)
  local mason_registry = require("mason-registry")
  local package = mason_registry.get_package(tool_name)
  if package and package:is_installed() then
    print("✅ Mason " .. tool_name .. " - INSTALLED")
    return true
  else
    print("❌ Mason " .. tool_name .. " - NOT INSTALLED")
    return false
  end
end

print("🔍 Neovim Configuration Health Check")
print("=====================================")
print()

-- Check core plugins
print("📦 Core Plugins:")
check_plugin("lazy")
check_plugin("lazyvim")
check_plugin("tokyonight")
print()

-- Check LSP servers
print("🔧 LSP Servers:")
check_lsp_server("gopls")
check_lsp_server("pyright")
check_lsp_server("clangd")
check_lsp_server("tsserver")
print()

-- Check Mason tools
print("🛠️  Mason Tools:")
check_mason_tool("gopls")
check_mason_tool("pyright")
check_mason_tool("clangd")
check_mason_tool("tsserver")
check_mason_tool("delve")
check_mason_tool("debugpy")
check_mason_tool("codelldb")
print()

-- Check debugging
print("🐛 Debugging:")
check_plugin("dap")
check_plugin("dap-go")
check_plugin("dap-python")
check_plugin("dap-vscode-js")
print()

-- Check AI integration
print("🤖 AI Integration:")
check_plugin("avante")
print()

-- Check treesitter
print("🌳 Treesitter:")
local ts_ok, ts = pcall(require, "nvim-treesitter")
if ts_ok then
  local parsers = require("nvim-treesitter.parsers").get_parser_configs()
  local installed = {}
  for parser, _ in pairs(parsers) do
    if vim.treesitter.language.get_lang(parser) then
      table.insert(installed, parser)
    end
  end
  print("✅ Treesitter parsers installed: " .. table.concat(installed, ", "))
else
  print("❌ Treesitter - NOT FOUND")
end
print()

-- Check keymaps
print("⌨️  Keymaps:")
local keymaps = vim.api.nvim_get_keymap("n")
local leader_keymaps = {}
for _, keymap in ipairs(keymaps) do
  if keymap.lhs:match("^<leader>") then
    table.insert(leader_keymaps, keymap.lhs .. " -> " .. (keymap.desc or "no desc"))
  end
end
if #leader_keymaps > 0 then
  print("✅ Leader keymaps configured: " .. #leader_keymaps .. " mappings")
else
  print("❌ No leader keymaps found")
end
print()

print("🏁 Health check completed!")
print("If you see any ❌ marks, check the README.md for installation instructions.") 