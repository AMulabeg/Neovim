return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.adapters.lldb = {
      type = "executable",
      port = "${port}",
      command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed, must be absolute path
      name = "lldb",
    }
    local dap = require("dap")
    dap.configurations.c = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
      },
    }
    vim.keymap.set("n", "<leader>xb", dap.toggle_breakpoint, { desc = "Add breakpoint at Line" })
    vim.keymap.set("n", "<leader>xr", dap.continue, { desc = "Start Debugging" })
    vim.keymap.set("n", "<leader>xs", dap.step_into, { desc = "Step Intp" })
    vim.keymap.set("n", "<leader>xo", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>xp", dap.repl.open, { desc = "Repl Open" })
  end,
}
