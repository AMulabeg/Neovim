return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    event = "VeryLazy",
    config = function()
      -- Import mason and its dependencies
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      -- Enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Configure mason-lspconfig
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "gopls",
          "ruff",
          "pyright",
          -- "basedpyright",
          "jdtls",
          "solargraph",
          "nil_ls",
          "hls",
        },
      })

      -- Configure mason-tool-installer
      mason_tool_installer.setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "black", -- python formatter
          "clang-format",
          "rubyfmt",
          "nixpkgs-fmt",
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
      -- Import lspconfig and its dependencies
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Setup cmp for LSP autocompletion
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Configure diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Lazy load the LSP key mappings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          local keymap = vim.keymap -- for conciseness

          -- Set keybinds
          local keymaps = {
            { "n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references" },
            { "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
            { "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions" },
            { "n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations" },
            { "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions" },
            { "n", "<leader>ca", vim.lsp.buf.code_action, "See available code actions" },
            { "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
            { "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics" },
            { "n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics" },
            { "n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic" },
            { "n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic" },
            { "n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor" },
            { "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
          }

          for _, map in ipairs(keymaps) do
            keymap.set(map[1], map[2], map[3], { buffer = ev.buf, silent = true, desc = map[4] })
          end
        end,
      })

      -- Setup handlers for LSP servers
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["clangd"] = function()
          lspconfig["clangd"].setup({
            capabilities = capabilities,
            cmd = { "clangd", "--offset-encoding=utf-16" },
          })
        end,
        ["lua_ls"] = function()
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            cmd = { "lua-language-server" },
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
              },
            },
          })
        end,
        ["pyright"] = function()
          lspconfig["pyright"].setup({
            capabilities = capabilities,
          })
        end,
        ["nil_ls"] = function()
          lspconfig["nil_ls"].setup({
            capabilities = capabilities,
            settings = {
              ["nil"] = {
                formatting = { command = { "nixpkgs-fmt" } }, -- Ensure nixfmt is used for formatting
                autoarchive = true, -- If there's a similar setting related to autoarchive
              },
            },
          })
        end,
      })
    end,
  },
}
