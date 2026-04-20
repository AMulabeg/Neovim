return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.icons" },
  event = "VeryLazy",
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()

    require("oil").setup({
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["q"] = "actions.close",
        ["g."] = "actions.toggle_hidden",
      },
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
