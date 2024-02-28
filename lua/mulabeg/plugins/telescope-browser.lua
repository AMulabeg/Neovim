return --lazy
{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        file_browser = {
          hijack_netrw = true,
          theme = "ivy",
        },
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
      },
    })
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>ft", "<cmd>Telescope file_browser<CR>", { desc = "File Tree" })

    telescope.load_extension("file_browser")
  end,
}
