return {
  -- lazy.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not avail:w
      --   able, we use `mini` as the fallback
      "rcarriga/nvim-notify",

      "onsails/lspkind.nvim", -- vs-code like pictograms
    },
  },
}
