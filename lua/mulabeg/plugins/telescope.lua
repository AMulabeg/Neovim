return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-file-browser.nvim", -- Add the file browser dependency
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup({
      defaults = {

        -- Ivy style layout
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 0.4, -- Adjust the height as needed
          prompt_position = "top",
        },
        -- initial_mode = "normal",
        sorting_strategy = "ascending", -- Keep the prompt at the top
        winblend = 10, -- Add transparency if you want
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        -- Default behavior for built-in pickers
        find_files = {
          theme = "ivy",
        },
        live_grep = {
          theme = "ivy",
        },
      },
      extensions = {
        file_browser = {
          -- Add custom options for the file browser if needed
          theme = "ivy",
          hijack_netrw = true,
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser") -- Load the file browser extension

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffer" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>fg", "<cmd>Telescope spell_suggest<cr>", { desc = "Find Correct Spelling" })
    keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<cr>", { desc = "Open file browser" }) -- Add keymap for file browser
  end,
}
