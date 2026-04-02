-- ╔═══════════════════════════════════════════════════════════╗
-- ║              Git Integration Plugins                       ║
-- ╚═══════════════════════════════════════════════════════════╝

return {
  -- ═══════════════════════════════════════════════════════════
  -- Gitsigns: Git changes visualization
  -- ═══════════════════════════════════════════════════════════
  -- Affiche les changements Git à côté des numéros de ligne
  -- et fournit des commandes pour reviewer les changements
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "▎" },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })

      -- Keymaps
      local gs = require("gitsigns")
      local opts = function(desc)
        return { noremap = true, silent = true, desc = desc }
      end

      vim.keymap.set("n", "]h", gs.next_hunk, opts("Next Hunk"))
      vim.keymap.set("n", "[h", gs.prev_hunk, opts("Previous Hunk"))
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts("Stage Hunk"))
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts("Reset Hunk"))
      vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, opts("Stage Hunk"))
      vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, opts("Reset Hunk"))
      vim.keymap.set("n", "<leader>hS", gs.stage_buffer, opts("Stage Buffer"))
      vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, opts("Undo Stage Hunk"))
      vim.keymap.set("n", "<leader>hR", gs.reset_buffer, opts("Reset Buffer"))
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts("Preview Hunk"))
      vim.keymap.set("n", "<leader>hb", function() gs.blame_line({full=true}) end, opts("Blame Line"))
      vim.keymap.set("n", "<leader>hd", gs.diffthis, opts("Diff This"))
      vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, opts("Diff This ~"))
      vim.keymap.set("n", "<leader>hc", gs.toggle_current_line_blame, opts("Toggle Blame"))
      vim.keymap.set("n", "<leader>hx", gs.toggle_deleted, opts("Toggle Deleted"))

      -- Text object
      vim.keymap.set({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts("Git Hunk"))
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Fugitive: Git wrapper
  -- ═══════════════════════════════════════════════════════════
  -- Interface Git complète dans Neovim
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Rhubarb: GitHub integration for Fugitive
  -- ═══════════════════════════════════════════════════════════
  -- Permet de voir les fichiers sur GitHub directement
  {
    "tpope/vim-rhubarb",
    dependencies = "vim-fugitive",
    cmd = { "GBrowse" },
  },
}
