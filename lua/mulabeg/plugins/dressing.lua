return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      -- Position at top-left
      enabled = true,
      default_prompt = "Input:",
      title_pos = "left",
      insert_only = true,
      start_in_insert = true,
      relative = "editor",
      prefer_width = 60,
      width = nil,
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },
      buf_options = {},
      win_options = {
        winblend = 0,
        wrap = false,
      },
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
      override = function(conf)
        -- Force top-left position
        conf.anchor = "NW"
        conf.row = 0
        conf.col = 0
        return conf
      end,
    },
  },
}
