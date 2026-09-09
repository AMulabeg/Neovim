return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },

    scope = { show_start = false, show_end = false },
    -- whitespace = { remove_blankline_trail = true },
  },
}
