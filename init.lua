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
-- Auto-launch nvim-tree and terminal on startup
-- ═══════════════════════════════════════════════════════════
vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    -- Use vim.schedule to ensure plugins are fully loaded
    vim.schedule(function()
      -- Open nvim-tree
      vim.cmd("NvimTreeToggle")

      -- Give plugins time to respond to state changes
      vim.defer_fn(function()
        -- Navigate to the main editor window
        vim.cmd("wincmd l")
        -- Open terminal vertically on the right
        vim.cmd("ToggleTerm direction=vertical size=80")
      end, 200)
    end)
  end,
  nested = true,
})
