-- ╔═══════════════════════════════════════════════════════════╗
-- ║           Treesitter - Syntax Highlighting                ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Treesitter utilise une analyse de l'AST (Abstract Syntax Tree)
-- pour fournir une coloration syntaxique plus précise et des
-- capacités d'analyse de code supérieures à regex.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Vérifier que les parseurs sont disponibles avant de les charger
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("Treesitter configs not loaded yet", vim.log.levels.WARN)
        return
      end

      configs.setup({
        -- Tous les parseurs qui seront automatiquement installés
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "csv",
          "dockerfile",
          "dot",
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "sql",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        -- Fonctionnalités activées
        highlight = {
          enable = true,
          -- Désactiver pour les fichiers très larges pour la performance
          disable = function(lang, bufnr)
            local buf_size = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
            return buf_size > 10000
          end,
          additional_vim_regex_highlighting = false,
        },
        -- Indentation automatique intelligente
        indent = {
          enable = true,
        },
        -- Sélection incrémentale (Ctrl+Space)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-backspace>",
          },
        },
        -- Meilleure navigation au-dessus du code
        textobjects = {
          enable = true,
        },
      })

      -- Foldage (repliage) de code basé sur Treesitter
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- Ne pas plier par défaut au démarrage
    end,
  },
}
