vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.lsp.enable({ "gopls", "lua_ls", "bashls", "ruff", "basedpyright", --[["marksman",]] "typescript", --[["rustanalyzer"]] })

require("lazy").setup("plugins", {
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "zipPlugin" },
    },
  },
  change_detection = { notify = false },
})
require("core")
