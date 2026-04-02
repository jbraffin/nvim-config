-- ╔═══════════════════════════════════════════════════════════╗
-- ║              UI & Appearance Plugins                       ║
-- ╚═══════════════════════════════════════════════════════════╝

return {
  -- ═══════════════════════════════════════════════════════════
  -- COLOR SCHEME (Catppuccin)
  -- ═══════════════════════════════════════════════════════════
  -- Thème cohérent, fourni avec de nombreuses intégrations
  -- Offre 4 variantes: latte, frappe, macchiato, mocha
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          lsp_saga = false,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- STATUS LINE (Lualine)
  -- ═══════════════════════════════════════════════════════════
  -- Affiche l'état courant: mode, fichier, diagnostics, git
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- INDENTATION GUIDES (Indent Blankline)
  -- ═══════════════════════════════════════════════════════════
  -- Affiche des traits verticaux pour visualiser l'indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│" },
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- ICONS LIBRARY
  -- ═══════════════════════════════════════════════════════════
  -- Fournit les icônes pour tous les autres plugins
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- ═══════════════════════════════════════════════════════════
  -- NOTIFICATIONS
  -- ═══════════════════════════════════════════════════════════
  -- Notifications non-intrusive en bas à droite
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
      vim.notify = require("notify")
    end,
  },
}
