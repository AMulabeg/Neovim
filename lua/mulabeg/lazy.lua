local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.conceallevel = 2
vim.opt.rtp:prepend(lazypath)
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.g.netrw_banner = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("lazy").setup({ { import = "mulabeg.plugins" }, { import = "mulabeg.plugins.lsp" } }, {
  defaults = { lazy = true },
  checker = {
    enabled = true,
    notify = false,
  },
  rocks = {
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
})
