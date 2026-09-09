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
    lazy = false,
    config = function()
      local treesitter = require("nvim-treesitter")
      local languages = {
        "bash",
        "c",
        "cpp",
        "css",
        "csv",
        "dockerfile",
        "dot",
        "hcl",
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
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      }

      treesitter.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
      treesitter.install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = vim.list_extend(vim.deepcopy(languages), { "terraform-vars" }),
        callback = function(args)
          local ok, err = pcall(vim.treesitter.start, args.buf)
          if not ok then
            vim.notify(("Tree-sitter parser unavailable: %s"):format(err), vim.log.levels.WARN)
          end
        end,
      })
    end,
  },
}
