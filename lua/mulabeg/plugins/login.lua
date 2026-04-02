-- ============================================================
--  INITIAL D DASHBOARD — alpha-nvim config
--  Drop in: ~/.config/nvim/lua/plugins/dashboard.lua
--  Requires: alpha-nvim  (goolord/alpha-nvim)
-- ============================================================

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ── Palette ─────────────────────────────────────────────────
    -- We set highlights in the setup block at the bottom.
    -- Names used in the header/footer color overrides:
    --   DashRed      #FF2D2D
    --   DashYellow   #FFD200
    --   DashWhite    #F0EDE6
    --   DashGray     #7A7A7A
    --   DashDim      #2C2C2C

    -- ── ASCII Art ───────────────────────────────────────────────
    -- AE86 Trueno silhouette + touge header
    local header = {
      "                                                                                ",
      "                                                                                ",
      "  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ",
      "  ░                                                                      ░  ",
      "  ░   ██╗███╗   ██╗██╗████████╗██╗ █████╗ ██╗         ██████╗            ░  ",
      "  ░   ██║████╗  ██║██║╚══██╔══╝██║██╔══██╗██║         ██╔══██╗           ░  ",
      "  ░   ██║██╔██╗ ██║██║   ██║   ██║███████║██║         ██║  ██║           ░  ",
      "  ░   ██║██║╚██╗██║██║   ██║   ██║██╔══██║██║         ██║  ██║           ░  ",
      "  ░   ██║██║ ╚████║██║   ██║   ██║██║  ██║███████╗    ██████╔╝           ░  ",
      "  ░   ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝    ╚═════╝            ░  ",
      "  ░                                                                      ░  ",
      "  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ",
      "                                                                                ",
      "              ──────── AKAGI MOUNTAIN PASS  ·  GUNMA  ────────                 ",
    }

    -- ── Taglines (picked randomly on open) ──────────────────────
    local taglines = {
      "「もう行くぞ」— FUJIWARA TAKUMI",
      "「峠は俺のもの」— THE GHOST OF AKAGI",
      "RUNNING BLIND THROUGH THE MOUNTAIN PASS",
      "GUTTER TECHNIQUE ACTIVATED",
      "INERTIA DRIFT  ·  APEX HUNTING  ·  CODE FLOWING",
      "「俺のエンジンは まだ 死んでいない」",
      "EUROBEAT INTENSIFIES",
    }
    math.randomseed(os.time())
    local tagline = taglines[math.random(#taglines)]

    -- ── Footer ──────────────────────────────────────────────────
    local function get_footer()
      local stats = require("lazy").stats()
      local plugins = stats.loaded .. "/" .. stats.count .. " plugins"
      local date = os.date("  %d.%m.%Y    %H:%M")
      return {
        "",
        "  " .. tagline,
        "",
        "  ⚡ " .. plugins .. "   " .. date,
      }
    end

    dashboard.section.buttons.val = {}

    -- ── Header & Footer sections ─────────────────────────────────
    dashboard.section.header.val = header
    dashboard.section.header.opts.hl = "DashHeader"

    dashboard.section.footer.val = get_footer()
    dashboard.section.footer.opts.hl = "DashFooter"

    -- ── Layout spacing ───────────────────────────────────────────
    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    dashboard.config.opts.noautocmd = true

    alpha.setup(dashboard.config)

    -- ── Highlights ───────────────────────────────────────────────
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        -- Header: hot red (the AE86's colour)
        vim.api.nvim_set_hl(0, "DashHeader", { fg = "#FF2D2D", bold = true })
        -- Buttons: clean white with yellow shortcut keys
        vim.api.nvim_set_hl(0, "DashBtn", { fg = "#F0EDE6" })
        vim.api.nvim_set_hl(0, "DashShortcut", { fg = "#FFD200", bold = true })
        -- Footer: dim grey for stats, bright for tagline (handled below)
        vim.api.nvim_set_hl(0, "DashFooter", { fg = "#7A7A7A", italic = true })
      end,
    })

    -- Fire immediately for the current colorscheme
    vim.api.nvim_set_hl(0, "DashHeader", { fg = "#FF2D2D", bold = true })
    vim.api.nvim_set_hl(0, "DashBtn", { fg = "#F0EDE6" })
    vim.api.nvim_set_hl(0, "DashShortcut", { fg = "#FFD200", bold = true })
    vim.api.nvim_set_hl(0, "DashFooter", { fg = "#7A7A7A", italic = true })

    -- ── Disable statusline / tabline on the dashboard buffer ─────
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.showtabline = 0
        vim.opt_local.laststatus = 0
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = 0,
          callback = function()
            vim.opt.showtabline = 2
            vim.opt.laststatus = 3
          end,
        })
      end,
    })
  end,
}
