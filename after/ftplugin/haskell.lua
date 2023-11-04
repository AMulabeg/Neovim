-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
ht.lsp.start()

--- Stop the LSP client.
ht.lsp.stop()

--- Restart the LSP client.
ht.lsp.restart()

--- Callback for dynamically loading haskell-language-server settings
--- Falls back to the `hls.default_settings` if no file is found
--- or one is found, but it cannot be read or decoded.

--- Evaluate all code snippets in comments

vim.g.haskell_tools = {
  -- ...
  hls = {
    settings = function(project_root)
      return ht.lsp.load_hls_settings(project_root, {
        settings_file_pattern = "hls.json",
      })
    end,
  },
}
local def_opts = { noremap = true, silent = true, buffer = bufnr }
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, { desc = "auto-refresh" }, opts)
-- Evaluate all code snippets
vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, { desc = "Evaluate code snippets" }, opts)
-- Toggle a GHCi repl for the current package
vim.keymap.set("n", "<leader>rr", ht.repl.toggle, { desc = "GHCi for current package" }, opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rf", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, { desc = " GHCi for current buffer" }, def_opts)
vim.keymap.set("n", "<leader>rq", ht.repl.quit, { desc = "Close" }, opts)
