-- ╔═══════════════════════════════════════════════════════════╗
-- ║          Lazy.nvim Plugin Manager Setup                    ║
-- ╚═══════════════════════════════════════════════════════════╝

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Load all plugins from the spec
require("lazy").setup({
  spec = "plugins",
  defaults = {
    lazy = false,  -- Charger tous les plugins par défaut
    version = false,
  },
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  ui = {
    border = "rounded",
  },
}, {
  change_detection = {
    enabled = true,
    notify = false,
  },
})
