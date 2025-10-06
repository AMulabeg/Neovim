return {
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      "obsidian-nvim/obsidian.nvim",
    },
    event = "VeryLazy",
    version = "1.*",

    opts = {
      keymap = {
        preset = "enter",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },

      snippets = { preset = "luasnip" },

      completion = {
        accept = {
          auto_brackets = { enabled = true },
        },
        list = {
          selection = { preselect = false, auto_insert = true },
          max_items = 10,
        },
        ghost_text = { enabled = true },
        documentation = {
          auto_show = true,
          window = { scrollbar = false, border = "solid" },
        },
        trigger = { show_on_trigger_character = true },
        menu = { border = "rounded", scrollbar = false },
      },

      --   signature = {
      --     enabled = true,
      --     window = { border = "rounded" },
      --   },
      --
      --   cmdline = {
      --     enabled = true,
      --     completion = {
      --       menu = { auto_show = true },
      --       list = {
      --         selection = { preselect = false, auto_insert = false },
      --       },
      --     },
      --   },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
        markdown = { "obsidian", "path", "buffer" },
      },
      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },

    config = function(_, opts)
      require("blink.cmp").setup(opts)
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
      })
    end,
  },
}
