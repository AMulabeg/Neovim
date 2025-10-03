return {
  -- "folke/tokyonight.nvim",
  "blazkowolf/gruber-darker.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd([[colorscheme gruber-darker]])
    -- vim.cmd([[colorscheme tokyonight-night]])
  end,
}
