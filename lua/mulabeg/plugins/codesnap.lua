return {
  "mistricky/codesnap.nvim",
  lazy = true,
  build = "make",
  cmd = "CodeSnapPreviewOn",
  config = function(_, opts)
    require("codesnap").setup(opts)
  end,
}
