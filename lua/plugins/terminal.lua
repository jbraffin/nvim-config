-- ╔═══════════════════════════════════════════════════════════╗
-- ║        Terminal Integration - ToggleTerm                  ║
-- ╚═══════════════════════════════════════════════════════════╝

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Taille du terminal
        size = 20,
        open_mapping = [[<C-\>]],  -- Ctrl+\ pour ouvrir/fermer
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",  -- float, horizontal, vertical, tab
        close_on_exit = true,
        shell = vim.o.shell,
        autochdir = false,
      })

      -- Keymaps pratiques
      local opts = { noremap = true, silent = true }
      
      -- Escape pour sortir du mode terminal (revenir en mode command)
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
      
      -- Terminal flottant
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
      
      -- Terminal horizontal en bas
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<CR>", opts)
      
      -- Terminal vertical à droite
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", opts)

      -- Fonction pour lancer des commandes dans le terminal
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Terminal nodejs/npm
      local node_toggle = Terminal:new({
        cmd = "node",
        direction = "float",
        hidden = true,
        display_name = "Node",
      })
      
      vim.keymap.set("n", "<leader>tn", function() node_toggle:toggle() end, opts)
      
      -- Terminal git graph avec toutes les branches
      local git_graph_toggle = Terminal:new({
        cmd = function()
          local file_path = vim.fn.expand("%:p")
          local git_root = vim.fn.systemlist("git -C " .. vim.fn.fnamemodify(file_path, ":h") .. " rev-parse --show-toplevel")[1] or vim.fn.getcwd()
          return "cd " .. git_root .. " && git log --graph --all --oneline --decorate"
        end,
        direction = "float",
        hidden = true,
        display_name = "Git Log Graph",
      })
      
      vim.keymap.set("n", "<leader>gla", function() git_graph_toggle:toggle() end, opts)
    end,
  }
}
