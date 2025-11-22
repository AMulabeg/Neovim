return {

  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = { "markdown", "quarto" },
  opts = {},
  event = "VeryLazy",
  config = function()
    require("render-markdown").setup({
      render_modes = true,
      latex = {
        enabled = true,
        converter = "latex2text",
        highlight = "RenderMarkdownMath",
        top_pad = 0,
        bottom_pad = 0,
      },
    })
  end,
}
