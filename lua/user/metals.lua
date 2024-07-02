local M = {}

M.config = function()
  local lvim_lsp = require("lvim.lsp")
  local metals_config = require("metals").bare_config()
  metals_config.on_init = lvim_lsp.common_on_init
  metals_config.on_exit = lvim_lsp.common_on_exit
  metals_config.capabilities = lvim_lsp.common_capabilities()
  metals_config.on_attach = function(client, bufnr)
    lvim_lsp.common_on_attach(client, bufnr)
    require("metals").setup_dap()
  end
  metals_config.settings = {
    superMethodLensesEnabled = true,
    showImplicitArguments = true,
    showInferredType = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = {},
  }
  -- metals_config.init_options.statusBarProvider = true
  vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt", "java" },
    callback = function() require("metals").initialize_or_attach(metals_config) end,
    group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
  })
end

-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()


-- completion related settings
-- This is similiar to what I use
-- local cmp = require("cmp")
-- cmp.setup({
--   sources = {
--     { name = "nvim_lsp" },
--     { name = "vsnip" },
--   },
--   snippet = {
--     expand = function(args)
--       -- Comes from vsnip
--       vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     -- None of this made sense to me when first looking into this since there
--     -- is no vim docs, but you can't have select = true here _unless_ you are
--     -- also using the snippet stuff. So keep in mind that if you remove
--     -- snippets you need to remove this select
--     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--     -- I use tabs... some say you should stick to ins-completion but this is just here as an example
--     ["<Tab>"] = function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       else
--         fallback()
--       end
--     end,
--     ["<S-Tab>"] = function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       else
--         fallback()
--       end
--     end,
--   })
-- })
return M
