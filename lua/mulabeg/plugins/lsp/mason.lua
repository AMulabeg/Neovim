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
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
<<<<<<< HEAD

      local capabilities = require("blink.cmp").get_lsp_capabilities()
=======
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local capabilities = cmp_nvim_lsp.default_capabilities()
>>>>>>> parent of 836a6ff (Changes)

      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local on_attach = function(client, bufnr)
        local bufmap = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
        end

        bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
        bufmap("n", "K", vim.lsp.buf.hover, "Show hover info")
        bufmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        bufmap("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Show code actions")
        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        bufmap("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostics")
        bufmap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        bufmap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
      end

      mason_lspconfig.setup_handlers({
        function(server)
          lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["clangd"] = function()
          lspconfig.clangd.setup({
            capabilities = capabilities,
            cmd = { "clangd", "--offset-encoding=utf-16" },
            on_attach = on_attach,
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            disableSuggestions = true,
          })
        end,
        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["svelte"] = function()
          lspconfig.svelte.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
              on_attach(client, bufnr)
            end,
          })
        end,
        ["graphql"] = function()
          lspconfig.graphql.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,
      })
    end,
  },
}
