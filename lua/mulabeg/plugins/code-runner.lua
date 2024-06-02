return {
  "CRAG666/code_runner.nvim",
  lazy = true,
  config = function()
    local code_runner = require("code_runner")
    code_runner.setup({
      runners = {
        python = {
          command = "python3",
          args = { "-u" },
          output = "buffer",
        },
        lua = {
          command = "lua",
          args = { "-e", "io.stdout:setvbuf('no')" },
          output = "buffer",
        },
        c = {
          command = "gcc",
          args = { "-o", "/tmp/a.out", "-Wall", "-Wextra", "-Werror", "-pedantic", "-std=c99", "-x", "c", "-" },
          output = "buffer",
          run = "/tmp/a.out",
        },
      },
    })
  end,
}
