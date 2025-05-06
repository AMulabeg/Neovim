local cmp_config = require("plugins/cmp")
local capabilities = cmp_config.capabilities
vim.lsp.config["luals"] =
  {
    -- Command and arguments to start the server.
    cmd = { "lua-language-server" },
    -- Filetypes to automatically attach to.
    filetypes = { "lua" },
    -- Sets the "root directory" to the parent directory of the file in the
    -- current buffer that contains either a ".luarc.json" or a
    -- ".luarc.jsonc" file. Files that share a root directory will reuse
    -- the connection to the same LSP server.
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    -- Specific settings to send to the server. The schema for this is
    -- defined by the server. For example the schema for lua-language-server
    -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
      },
    },
  }, vim.lsp.enable("luals")

vim.lsp.config["clangd"] = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
}, vim.lsp.enable("clangd")

vim.lsp.config["gopls"] = {
  cmd = { "gopls" },
  filetypes = { "go" },
}, vim.lsp.enable("gopls")

vim.lsp.config["pyright"] =
  {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace", -- ou "openFilesOnly" se preferir
          typeCheckingMode = "basic", -- opções: "off", "basic", "strict"
        },
      },
    },
  }, vim.lsp.enable("pyright")

vim.lsp.config["marksman"] = {
  cmd = { "marksman" },
  filetypes = { "markdown" },
}, vim.lsp.enable("marksman")

vim.lsp.config["tsserver"] =
  {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- false
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- false
        },
      },
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        },
      },
    },
  }, vim.lsp.enable("tsserver")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Desativa o autocompletar nativo do LSP, já que usamos cmp
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(false, client.id, args.buf) -- Desativa explicitamente
    end

    -- Configuração de inlay hints (mantida)
    if client.supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(false)
    end

    -- NÃO definir omnifunc manualmente, deixar o cmp gerenciar
    -- vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- Removido

    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>cw", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>cf", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  end,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
)
