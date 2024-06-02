return {
  -- // this doesnt not work
  "mfussenegger/nvim-dap",
  lazy = true,

  config = function()
    local dap = require("dap")

    -- Set up C/C++ debugging
    dap.adapters.cpp = {
      type = "executable",
      attach = {
        pidProperty = "pid",
        pidSelect = "ask",
      },
      command = "lldb-vscode",
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
        args = {},
        runInTerminal = false,
      },
    }

    vim.keymap.set("n", "<leader>xb", dap.toggle_breakpoint, { desc = "Add breakpoint at Line" })
    vim.keymap.set("n", "<leader>xr", dap.continue, { desc = "Start Debugging" })
    vim.keymap.set("n", "<leader>xs", dap.step_into, { desc = "Step Intp" })
    vim.keymap.set("n", "<leader>xo", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>xp", dap.repl.open, { desc = "Repl Open" })
  end,
}
