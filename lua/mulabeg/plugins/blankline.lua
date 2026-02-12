return {
  "lukas-reineke/indent-blankline.nvim",
  event = "VeryLazy",
  main = "ibl",
  opts = {
    indent = { char = "│" },
    scope = { enabled = false },
    whitespace = { remove_blankline_trail = true },
  },
}
