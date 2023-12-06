return {
  "mfussenegger/nvim-dap-python",
  event = "VeryLazy",
  config = function()
    require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
  end,
}
