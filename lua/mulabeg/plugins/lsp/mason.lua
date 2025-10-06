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
        ensure_installed = { "lua_ls", "clangd", "ruff", "jedi_language_server" },
      })

      require("mason-tool-installer").setup({
        ensure_installed = { "stylua", "clang-format" },
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
      "ibhagwan/fzf-lua",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      capabilities.positionEncoding = { "utf-16" }
      local fzf = require("fzf-lua")

      -- Diagnostics configuration
      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          -- fzf-lua pickers
          keymap.set("n", "gd", fzf.lsp_definitions, opts)
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          keymap.set("n", "gR", fzf.lsp_references, opts)
          keymap.set("n", "gi", fzf.lsp_implementations, opts)
          keymap.set("n", "gt", fzf.lsp_typedefs, opts)

          -- LSP actions
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          keymap.set("n", "K", vim.lsp.buf.hover, opts)

          -- Diagnostics
          keymap.set("n", "<leader>D", fzf.diagnostics_document, opts)
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

          -- LSP management
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end,
      })

      -- Individual LSP servers
      vim.lsp.config["lua_ls"] = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc" },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
          },
        },
      }

      vim.lsp.config["clangd"] = {
        cmd = { "clangd", "--offset-encoding=utf-16" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        capabilities = capabilities,
      }

      vim.lsp.config["jedi_language_server"] = {
        filetypes = { "python" },
        capabilities = capabilities,
      }

      vim.lsp.enable("lua_ls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("jedi_language_server")
    end,
  },
}
