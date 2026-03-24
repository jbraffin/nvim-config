-- ╔═══════════════════════════════════════════════════════════╗
-- ║           Neovim Configuration - Main Entry Point          ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Load the base configuration first
require("config.settings")

-- Then setup the plugin manager (lazy.nvim)
require("config.lazy")

-- Load global keymaps
require("config.keymaps")
