-- Applies whichever theme is currently selected via `theme-picker <name>`
-- (~/Projects/ThemePicker). Reads the shared state file at startup, and
-- watches it (same fs_event pattern as plugins/dankcolors.lua) so already
-- open nvim instances pick up a live switch without restarting.

local state_file = vim.fn.expand("~/.config/theme-picker/current")
local default_theme = "gruber-darker"

local THEMES = {
  ["gruber-darker"] = {
    repo = "blazkowolf/gruber-darker.nvim",
    name = "gruber-darker.nvim",
    colorscheme = "gruber-darker",
  },
  ["catppuccin-mocha"] = {
    repo = "catppuccin/nvim",
    name = "catppuccin",
    colorscheme = "catppuccin-mocha",
  },
  ["tokyo-night"] = {
    repo = "folke/tokyonight.nvim",
    name = "tokyonight.nvim",
    colorscheme = "tokyonight-night",
  },
  ["nord"] = {
    repo = "gbprod/nord.nvim",
    name = "nord.nvim",
    colorscheme = "nord",
  },
  ["onedark"] = {
    repo = "navarasu/onedark.nvim",
    name = "onedark.nvim",
    colorscheme = "onedark",
    setup = function()
      require("onedark").setup({ style = "dark" })
    end,
  },
}

-- Make sure the state file exists so fs_event has something to watch, and
-- so `theme-picker current` / other tools have a sane default to read.
if vim.fn.filereadable(state_file) == 0 then
  vim.fn.mkdir(vim.fn.fnamemodify(state_file, ":h"), "p")
  local f = io.open(state_file, "w")
  if f then
    f:write(default_theme .. "\n")
    f:close()
  end
end

local function read_theme()
  local f = io.open(state_file, "r")
  if not f then
    return default_theme
  end
  local slug = f:read("l")
  f:close()
  slug = slug and vim.trim(slug) or ""
  return THEMES[slug] and slug or default_theme
end

local function apply(slug)
  local t = THEMES[slug]
  if not t then
    return
  end
  if t.setup then
    t.setup()
  end
  vim.cmd.colorscheme(t.colorscheme)
end

local current = read_theme()

if not _G._theme_picker_watcher then
  local uv = vim.uv or vim.loop
  _G._theme_picker_watcher = uv.new_fs_event()
  _G._theme_picker_watcher:start(
    state_file,
    {},
    vim.schedule_wrap(function()
      local slug = read_theme()
      local t = THEMES[slug]
      if t then
        require("lazy").load({ plugins = { t.name } })
        apply(slug)
        print("Theme reload: " .. slug)
      end
    end)
  )
end

local specs = {}
for slug, t in pairs(THEMES) do
  local spec = {
    t.repo,
    name = t.name,
  }
  if slug == current then
    spec.lazy = false
    spec.priority = 1000
    spec.config = function()
      apply(slug)
    end
  end
  table.insert(specs, spec)
end

return specs
