return {
  "mfussenegger/nvim-dap-python",
  event = "VeryLazy",
  config = function()
    require("dap-python").setup("~/Uni/WSRechnen/.venv/bin/python")
  end,
}
