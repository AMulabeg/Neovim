return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  ft = { "markdown", "quarto" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    render_modes = true,
    latex = {
      enabled = true,
      highlight = "RenderMarkdownMath",
      top_pad = 0,
      bottom_pad = 0,
    },
  },
}
