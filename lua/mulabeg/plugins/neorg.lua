return {
  {
    "nvim-neorg/neorg",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/neorg",
                ds = "~/neorg/DS",
              },
              default_workspace = "notes",
            },
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
