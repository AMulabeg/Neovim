return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      'echasnovski/mini.icons',
      version = '*',
      config = function()
        require('mini.icons').setup()
      end,
    },
  },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
