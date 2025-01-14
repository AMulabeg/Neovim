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
vim.opt.conceallevel = 1
vim.opt.rtp:prepend(lazypath)
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.g.python3_host_prog = "/sbin/python3"

require("lazy").setup({ { import = "mulabeg.plugins" }, { import = "mulabeg.plugins.lsp" } }, {
  defaults = { lazy = true },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
