return {
  "ericrswanny/chkn.nvim",
  config = function()
    require("chkn").setup() -- Use the default configuration
  end,
  lazy = false,
  keys = {
    {
      "<leader>sp",
      function()
        vim.cmd("silent! ChknToggle")
      end,
      desc = "Toggle Scratchpad",
    },
  },
}
