return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = "VeryLazy",
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/Documents/Obsidian Vault",
      },
    },
    ui = {
      enable = false,
    },

    keybindings = {
      vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian" }),
      vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Backlinks" }),
      vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Obsidian Search" }),
      vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Obsidian Links" }),
      vim.keymap.set("n", "<leader>of", "<cmd>ObsidianFollowLink<cr>", { desc = "Obsidian Follow link" }),
      vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Quick Switch" }),
    },

    -- see below for full list of options 👇
  },
}
