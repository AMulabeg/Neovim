return --lazy
{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  lazy = true,
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        theme = "center",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.3,
          },
        },
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
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
    keymap.set("n", "<leader>fn", "<cmd>Telescope file_browser<CR>", { desc = "File Tree" })

    telescope.load_extension("file_browser")
  end,
}
