return {
  "numToStr/Comment.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    -- import comment plugin safely
    local comment = require("Comment")

    -- enable comment
    comment.setup({
      -- for commenting tsx and jsx files
    })
  end,
}
