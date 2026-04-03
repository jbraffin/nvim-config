-- ╔═══════════════════════════════════════════════════════════╗
-- ║           Neovim Configuration - Main Entry Point          ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Load the base configuration first
require("config.settings")

-- Configure file type associations
require("config.filetypes")

-- Then setup the plugin manager (lazy.nvim)
require("config.lazy")

-- Load global keymaps
require("config.keymaps")

-- Load custom git graph command
require("config.git-graph")

-- ═══════════════════════════════════════════════════════════
-- Auto-launch nvim-tree on startup
-- ═══════════════════════════════════════════════════════════
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    -- Use vim.schedule to ensure plugins are fully loaded
    vim.schedule(function()
      -- Open nvim-tree
      vim.cmd("NvimTreeToggle")
    end)
  end,
  nested = true,
})
