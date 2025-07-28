return {
  -- nvim-cmp (Autocompletion)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
    },
    config = function()
      -- Your nvim-cmp config here (or use LazyVim defaults)
    end,
    optional = true,
    opts = function(_, opts)
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = opts.sorting.comparators or {}
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
      table.insert(opts.auto_brackets, "python")
    end,
  },

  -- Plenary (Required by many plugins)
  { "nvim-lua/plenary.nvim" },
}
