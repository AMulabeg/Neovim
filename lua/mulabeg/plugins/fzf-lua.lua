return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local fzf = require("fzf-lua")

    local function emacs_find_file()
      vim.ui.input({
        prompt = "Find file: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
      }, function(input)
        if not input then
          return
        end

        local expanded = vim.fn.expand(input)
        if vim.fn.isdirectory(expanded) == 1 then
          require("oil").open(expanded)
        else
          vim.cmd("edit " .. vim.fn.fnameescape(expanded))
        end
      end)
    end

    fzf.setup({
      winopts = {
        height = 0.40,
        width = 1.00,
        row = 0.95,
        col = 0.5,
        relative = "editor",
      },
      fzf_opts = {
        ["--layout"] = "reverse",
        ["--info"] = "inline",
        ["--prompt"] = "❯ ",
        ["--pointer"] = "▶",
        ["--marker"] = "✓",
      },
      keymap = {
        builtin = {
          ["<C-k>"] = "toggle-preview-up",
          ["<C-j>"] = "toggle-preview-down",
          ["<C-q>"] = "select-all+accept",
        },
        fzf = {
          ["ctrl-q"] = "toggle-all",
        },
      },
      files = {
        prompt = "Files❯ ",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
        actions = {
          ["ctrl-h"] = function(_, opts)
            local parent = vim.fn.fnamemodify(opts.cwd or vim.loop.cwd(), ":h")
            fzf.files({ cwd = parent })
          end,
          ["ctrl-l"] = function(selected, opts)
            if not selected or #selected == 0 then
              return
            end
            local entry = fzf.path.entry_to_file(selected[1], opts)
            local path = entry.path or entry.file
            if vim.fn.isdirectory(path) == 1 then
              fzf.files({ cwd = path })
            end
          end,
        },
      },
      grep = {
        prompt = "Rg❯ ",
      },
    })

    local map = vim.keymap.set
    map("n", "<leader>ff", fzf.files, { desc = "Fuzzy find files in cwd" })
    map("n", "<leader>fe", emacs_find_file, { desc = "Edit path to open file/directory" })
    map("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
    map("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
    map("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
    map("n", "<leader>fb", fzf.buffers, { desc = "Find buffer" })
    map("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
    map("n", "<leader>fg", fzf.spell_suggest, { desc = "Find correct spelling" })
  end,
}
