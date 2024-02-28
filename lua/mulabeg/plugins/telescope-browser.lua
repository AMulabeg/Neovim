return --lazy
{
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
<<<<<<< HEAD
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
=======
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
>>>>>>> b1c012b3db9ae68337c06fabc8afc3e0a4e29fb8
        },
      },
    })
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>ft", "<cmd>Telescope file_browser<CR>", { desc = "File Tree" })

    telescope.load_extension("file_browser")
  end,
}
