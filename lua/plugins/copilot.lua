-- ╔═══════════════════════════════════════════════════════════╗
-- ║        GitHub Copilot Integration                         ║
-- ╚═══════════════════════════════════════════════════════════╝

return {
  -- ═══════════════════════════════════════════════════════════
  -- Copilot: AI Code Completion
  -- ═══════════════════════════════════════════════════════════
  -- Nécessite authentification GitHub (première utilisation)
  -- :Copilot auth
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- Configuration de Copilot
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = false
      vim.g.copilot_tab_fallback = ""

      -- Keymaps pour Copilot
      vim.keymap.set("i", "<C-g>", 'copilot#Accept("<CR>")', { 
        expr = true, 
        noremap = true, 
        silent = true,
        desc = "Accept Copilot suggestion"
      })

      -- Navigation dans les suggestions
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { 
        noremap = false,
        desc = "Next Copilot suggestion"
      })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { 
        noremap = false,
        desc = "Previous Copilot suggestion"
      })

      -- Dismiss suggestion
      vim.keymap.set("i", "<M-Bslash>", "<Plug>(copilot-dismiss)", { 
        noremap = false,
        desc = "Dismiss Copilot suggestion"
      })
    end,
  },
}
