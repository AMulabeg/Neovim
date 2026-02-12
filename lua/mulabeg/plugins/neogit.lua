return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  config = function()
    require("neogit").setup({
      kind = "split", -- Magit-style
      disable_hint = true,
      disable_commit_confirmation = true,

      signs = {
        section = { ">", "v" },
        item = { ">", "v" },
        hunk = { "", "" },
      },

      sections = {
        untracked = { folded = false },
        unstaged = { folded = false },
        staged = { folded = false },
        stashes = { folded = true },
        recent = { folded = true },
      },

      integrations = {
        diffview = true,
      },

      commit_editor = {
        kind = "split",
      },

      popup = {
        kind = "split",
      },

      mappings = {
        status = {
          ["q"] = "Close",
          ["TAB"] = "Toggle",
          ["s"] = "Stage",
          ["u"] = "Unstage",
          ["c"] = "Command", -- commit popup
          ["P"] = "Command", -- push popup
          ["F"] = "Command", -- pull/fetch popup
          ["l"] = "Command", -- log popup
          ["d"] = "Command", -- diff popup
        },
      },
    })
  end,
  vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<CR>"),
}
