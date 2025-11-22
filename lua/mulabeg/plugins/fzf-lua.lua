return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- icons
    "folke/todo-comments.nvim", -- for todos picker
  },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        -- Ivy-style bottom pane
        height = 0.40,
        width = 1.00,
        row = 1.0, -- bottom of the screen
        col = 0.5,
        border = "none",
        --   preview = {
        --     -- hidden = "hidden", -- disable preview by default
        --   },
      },
      fzf_opts = {
        ["--layout"] = "reverse", -- prompt at top
        ["--info"] = "inline",
      },
      keymap = {
        builtin = {
          ["<C-k>"] = "toggle-preview-up", -- similar to move_selection_previous
          ["<C-j>"] = "toggle-preview-down", -- similar to move_selection_next
          ["<C-q>"] = "select-all+accept", -- send all to quickfix
        },
        fzf = {
          ["ctrl-q"] = "toggle-all", -- multi-select
        },
      },
      files = {
        prompt = "Files❯ ",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      grep = {
        prompt = "Rg❯ ",
        -- rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!.git'",
      },
    })

    local keymap = vim.keymap.set
    keymap("n", "<leader>ff", fzf.files, { desc = "Fuzzy find files in cwd" })
    keymap("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
    keymap("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
    keymap("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
    keymap("n", "<leader>fb", fzf.buffers, { desc = "Find buffer" })
    keymap("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" }) -- todo-comments integration
    keymap("n", "<leader>fg", fzf.spell_suggest, { desc = "Find Correct Spelling" })
    keymap("n", "<leader>fe", fzf.files, { desc = "Open file browser (basic)" }) -- fzf-lua has no full file browser like telescope
  end,
}
