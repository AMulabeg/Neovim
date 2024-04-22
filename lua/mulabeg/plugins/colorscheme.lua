return {
  {
    -- "oxfist/night-owl.nvim",
    --"folke/tokydark.nvim",
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Lua
      require("onedark").setup({
        -- style = "deep",
      })
      require("onedark").load() --load the colorscheme here
    end,
  },
}
