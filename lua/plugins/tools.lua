-- ╔═══════════════════════════════════════════════════════════╗
-- ║       Tools & Utilities Plugins                            ║
-- ╚═══════════════════════════════════════════════════════════╝

return {
  -- ═══════════════════════════════════════════════════════════
  -- Telescope: Fuzzy Finder
  -- ═══════════════════════════════════════════════════════════
  -- Recherche rapide de fichiers, contenu, symboles, etc.
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find by Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
      { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Buffer" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
      { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Find Commits" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          color_devicons = true,
          file_ignore_patterns = { "node_modules", ".git", "dist", "build" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-c>"] = actions.close,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      telescope.load_extension("fzf")
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Nvim-tree: File Explorer
  -- ═══════════════════════════════════════════════════════════
  -- Explorateur de fichiers intégré au côté gauche
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            glyphs = {
              default = "",
              symlink = "",
              bookmark = "󰆤",
              folder = {
                arrow_open = "",
                arrow_closed = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "?",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
          git_ignored = true,
        },
        git = {
          enable = true,
          timeout = 400,
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Undotree: Undo History
  -- ═══════════════════════════════════════════════════════════
  -- Visualise l'arborescence complète de l'historique d'édition
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
    },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Which-key: Affiche les keybindings disponibles
  -- ═══════════════════════════════════════════════════════════
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
      })

      wk.register({
        ["<leader>"] = {
          f = { name = "+find" },
          l = { name = "+lsp" },
          g = { name = "+git" },
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Conform: Code Formatter
  -- ═══════════════════════════════════════════════════════════
  -- Format automatique du code (prettier, black, stylua, etc.)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format file",
      },
    },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Nvim-lint: Linting
  -- ═══════════════════════════════════════════════════════════
  -- Linting en temps réel (eslint, pylint, etc.)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        python = { "pylint" },
        bash = { "shellcheck" },
        lua = { "luacheck" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
