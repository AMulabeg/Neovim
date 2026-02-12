return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- icons
    "folke/todo-comments.nvim", -- for todos picker
  },
  config = function()
    local fzf = require("fzf-lua")

    -- Custom Emacs-style file finder - opens oil.nvim for directories
    local function emacs_find_file()
      vim.ui.input({
        prompt = "Find file: ",
        default = vim.fn.getcwd() .. "/",
        completion = "file",
      }, function(input)
        if input then
          local expanded = vim.fn.expand(input)
          if vim.fn.isdirectory(expanded) == 1 then
            -- If it's a directory, open oil.nvim
            require("oil").open(expanded)
          elseif vim.fn.filereadable(expanded) == 1 then
            -- If it's a file, open it
            vim.cmd("edit " .. vim.fn.fnameescape(expanded))
          else
            -- Try to create/open the file
            vim.cmd("edit " .. vim.fn.fnameescape(expanded))
          end
        end
      end)
    end

    fzf.setup({
      winopts = {
        -- Ivy-style bottom pane for normal fzf
        height = 0.40,
        width = 1.00,
        row = 0.95,
        col = 0.5,
        border = "none",
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
          -- Navigate up one directory
          ["ctrl-h"] = function(selected, opts)
            local cwd = opts.cwd or vim.loop.cwd()
            local parent = vim.fn.fnamemodify(cwd, ":h")
            require("fzf-lua").files({ cwd = parent })
          end,
          -- Enter directory
          ["ctrl-l"] = function(selected, opts)
            if selected and #selected > 0 then
              local entry = require("fzf-lua").path.entry_to_file(selected[1], opts)
              local path = entry.path or entry.file
              if vim.fn.isdirectory(path) == 1 then
                require("fzf-lua").files({ cwd = path })
              end
            end
          end,
        },
      },
      grep = {
        prompt = "Rg❯ ",
      },
    })

    local keymap = vim.keymap.set
    keymap("n", "<leader>ff", fzf.files, { desc = "Fuzzy find files in cwd" })
    keymap("n", "<leader>fe", emacs_find_file, { desc = "Edit path to open file/directory" })
    keymap("n", "<leader>fr", fzf.oldfiles, { desc = "Fuzzy find recent files" })
    keymap("n", "<leader>fs", fzf.live_grep, { desc = "Find string in cwd" })
    keymap("n", "<leader>fc", fzf.grep_cword, { desc = "Find string under cursor in cwd" })
    keymap("n", "<leader>fb", fzf.buffers, { desc = "Find buffer" })
    keymap("n", "<leader>ft", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
    keymap("n", "<leader>fg", fzf.spell_suggest, { desc = "Find Correct Spelling" })
  end,
}
