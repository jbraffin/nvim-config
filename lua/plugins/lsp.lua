-- ╔═══════════════════════════════════════════════════════════╗
-- ║        LSP Configuration - Language Servers                ║
-- ╚═══════════════════════════════════════════════════════════╝

-- LSP = Language Server Protocol
-- Permet à l'éditeur de communiquer avec des serveurs de langage
-- pour l'autocomplétion, les diagnostics, la navigation, etc.

return {
  -- ═══════════════════════════════════════════════════════════
  -- Mason: Gestionnaire de LSP/tools/formatters
  -- ═══════════════════════════════════════════════════════════
  -- Installe et gère les serveurs de langage facilement
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Mason LSP Config: Intégration Nvim + Mason
  -- ═══════════════════════════════════════════════════════════
  -- Relie Mason à nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",              -- Lua
          "pyright",             -- Python
          "ts_ls",               -- TypeScript/JavaScript
          "gopls",               -- Go
          "jdtls",               -- Java
          "jsonls",              -- JSON
          "html",                -- HTML
          "cssls",               -- CSS
          "dockerls",            -- Docker
          "yamlls",              -- YAML
          "terraformls",         -- Terraform
        },
        automatic_installation = true,
        run_on_start = true,
      })

      -- Forcer l'installation immédiate au démarrage
      local installed_ok, mlc = pcall(require, "mason-lspconfig.install")
      if installed_ok and mlc.install_all then
        vim.defer_fn(mlc.install_all, 100)
      end
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Nvim LSPConfig: Configuration des serveurs de langage
  -- ═══════════════════════════════════════════════════════════
  -- Permet de configurer et de démarrer les LSPs
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Capacités de complétion pour tous les LSPs
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Configuration des serveurs installés par Mason (nouvelle API Neovim 0.11+)
      local servers = {
        -- ───────────────────────────────────────────────────────
        -- Scripting & Configuration
        -- ───────────────────────────────────────────────────────
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },

        -- ───────────────────────────────────────────────────────
        -- Compiled Languages
        -- ───────────────────────────────────────────────────────
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
            },
          },
        },
        jdtls = {
          settings = {
            java = {
              home = nil, -- auto-detect
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              implementationsCodeLens = {
                enabled = true,
              },
              referencesCodeLens = {
                enabled = true,
              },
              references = {
                includeDecompiledSources = true,
              },
              format = {
                enabled = false,
              },
            },
          },
        },

        -- ───────────────────────────────────────────────────────
        -- Interpreted Languages
        -- ───────────────────────────────────────────────────────
        pyright = {
          settings = {
            python = {
              pythonPath = "python3",
              analysis = {
                typeCheckingMode = "standard",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- ───────────────────────────────────────────────────────
        -- Web & Data
        -- ───────────────────────────────────────────────────────
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
              },
            },
          },
        },
        jsonls = {},
        html = {},
        cssls = {},
        dockerls = {},
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = true,
              },
              validate = true,
            },
          },
        },
        terraformls = {
          settings = {
            terraform = {
              validateOnSave = true,
            },
          },
        },
      }

      for server_name, config in pairs(servers) do
        -- Fusionner les capacités avec la config
        config.capabilities = capabilities
        
        -- Utiliser la nouvelle API Neovim 0.11+
        vim.lsp.config(server_name, config)
      end

      -- Activer tous les serveurs configurés
      for server_name, _ in pairs(servers) do
        vim.lsp.enable(server_name)
      end

      -- ───────────────────────────────────────────────────────
      -- Keymaps pour les fonctionnalités LSP
      -- ───────────────────────────────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, noremap = true, silent = true }
          local keymap = vim.keymap.set

          keymap("n", "gD", vim.lsp.buf.declaration, opts)
          keymap("n", "gd", vim.lsp.buf.definition, opts)
          keymap("n", "K", vim.lsp.buf.hover, opts)
          keymap("n", "gi", vim.lsp.buf.implementation, opts)
          keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          keymap("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
          keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          keymap("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          
          -- Diagnostics
          keymap("n", "[d", vim.diagnostic.goto_prev, opts)
          keymap("n", "]d", vim.diagnostic.goto_next, opts)
          keymap("n", "<leader>e", vim.diagnostic.open_float, opts)
          keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
        end,
      })

      -- Personnalisation de l'apparence des diagnostics
      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        float = {
          border = "rounded",
        },
      })
    end,
  },
}
