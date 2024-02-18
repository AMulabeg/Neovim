return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.adapters.lldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "/Users/amer/.local/share/nvim/mason/bin/codelldb",
        args = { "--port", "${port}" },
      },
    }
    dap.configurations.c = {
      {
        type = "lldb",
        request = "launch",
        name = "Launch file",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
          local x = vim.fn.input("Args: ", "", "file")
          local a = {}
          while string.len(x) >= 1 do
            table.insert(a, x)
            x = vim.fn.input("Args: ", "", "file")
          end
          return a
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    vim.keymap.set("n", "<leader>xb", dap.toggle_breakpoint, { desc = "Add breakpoint at Line" })
    vim.keymap.set("n", "<leader>xr", dap.continue, { desc = "Start Debugging" })
    vim.keymap.set("n", "<leader>xs", dap.step_into, { desc = "Step Intp" })
    vim.keymap.set("n", "<leader>xo", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>xp", dap.repl.open, { desc = "Repl Open" })
  end,
}
