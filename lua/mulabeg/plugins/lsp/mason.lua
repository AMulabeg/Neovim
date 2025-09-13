local keymap = vim.keymap
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "ruff",
          "pyright",
          "ts_ls",
          "emmet_ls",
          "svelte",
          "graphql",
          "gopls",
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "black",
          "clang-format",
          "prettierd",
          "eslint_d",
          "gofumpt",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()

      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })
      vim.lsp.config["luals"] = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc" },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
          },
        },
      }
      vim.lsp.config["clangd"] = {
        cmd = { "clangd", "--offset-encoding=utf-16" },
        filetypes = { "c", "cpp" },
      }
      --
      -- vim.lsp.config["ts_ls"] = {
      --   disableSuggestions = true,
      -- }
      --
      -- vim.lsp.config["emmet_ls"] = {
      --   filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      -- }
      --
      -- vim.lsp.config["svelte"] = {
      --   on_attach = function(client, bufnr)
      --     vim.api.nvim_create_autocmd("BufWritePost", {
      --       pattern = { "*.js", "*.ts" },
      --       callback = function(ctx)
      --         client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      --       end,
      --     })
      --   end,
      -- }
      --
      -- vim.lsp.config["graphql"] = {
      --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      -- }
      --
      vim.lsp.enable = {
        "clangd",
        "luals",
        "pyright",
        --   "ts_ls",
        --   "emmet_ls",
        --   "svelte",
      }
    end,
  },
}
