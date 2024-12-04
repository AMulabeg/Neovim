return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme monokai-pro]])
    end,
    --   "folke/tokyonight.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   opts = {},
    --   config = function()
    --     vim.cmd([[colorscheme tokyonight-night]])
    --   end,
    -- },
    -- {
    --     "oxfist/night-owl.nvim",
    --     --"folke/tokydark.nvim",
    --     -- "navarasu/onedark.nvim",
    --     lazy = false,
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --       -- Lua
    --       vim.cmd.colorscheme("night-owl")
    --
    --       --   require("onedark").setup({
    --       --     -- style = "deep",
    --       --   })
    --       --   require("onedark").load() --load the colorscheme here
    --     end,
    --   },
  },
}
