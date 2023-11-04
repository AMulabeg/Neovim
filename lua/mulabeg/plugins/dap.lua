return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    local dap = require("dap")
    dap.adapters.lldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "/usr/bin/codelldb",
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
          return { vim.fn.input("Args: ", "", "file") }
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Add breakpoint at Line" })
    vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "Start Debugging" })
    vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "Step Intp" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dp", dap.repl.open, { desc = "Repl Open" })
  end,
}
