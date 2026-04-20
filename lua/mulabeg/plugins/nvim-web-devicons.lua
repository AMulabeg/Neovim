return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.icons").setup()
    -- This makes mini.icons respond to any require("nvim-web-devicons")
    -- calls from other plugins, so nothing breaks:
    MiniIcons.mock_nvim_web_devicons()
  end,
}
