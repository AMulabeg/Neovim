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
vim.g.python3_host_prog = "/opt/homebrew/anaconda3/bin/python3"
require("lazy").setup({ { import = "mulabeg.plugins" }, { import = "mulabeg.plugins.lsp" } }, {
  install = {
    colorscheme = { "night-owl" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
