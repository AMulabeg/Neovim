return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",

  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>otd", "<cmd>ObsidianToday<cr>", desc = "[O]bsidian [t]o[d]ay" },
    { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "[O]bsidian [O]pen" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "[O]bsidian [S]earch" },
    { "<leader>ob", ":ObsidianBacklinks<CR>", desc = "[O]bsidian [B]acklinks" },
    { "<leader>otm", ":ObsidianTomorrow<CR>", desc = "[O]bsidian [T]o[m]orrow" },
    { "<leader>oyd", ":ObsidianYesterday<CR>", desc = "[O]bsidian [y]ester[d]ay" },
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "ObsidianVault",
          path = "~/Documents/Obsidian Vault/",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      new_notes_location = "notes_subdir",
      note_id_func = function(title)
        return title
      end,
      note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      ui = {
        enable = true,
      },
    })
  end,
}
