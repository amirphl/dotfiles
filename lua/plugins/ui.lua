return {
  -- Tokyo Night colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,              -- Load immediately (not lazy-loaded)
    priority = 1000,           -- High priority to ensure it loads first
    opts = { style = "moon" }, -- Optional: Configure colorscheme
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight") -- Apply the colorscheme
    end,
  },

  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- Your todo-comments config here (or leave empty for defaults)
    },
  },
}
