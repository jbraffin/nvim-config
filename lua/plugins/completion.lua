-- ╔═══════════════════════════════════════════════════════════╗
-- ║         Completion Engine & Snippets                       ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Nvim-cmp = moteur de complétion intelligent
-- Combine plusieurs sources (LSP, snippets, buffer, path, etc.)

return {
  -- ═══════════════════════════════════════════════════════════
  -- Nvim-cmp: Completion Engine
  -- ═══════════════════════════════════════════════════════════
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Sources de complétion
      "hrsh7th/cmp-nvim-lsp",      -- LSP
      "hrsh7th/cmp-buffer",         -- Buffer
      "hrsh7th/cmp-path",           -- Chemins de fichiers
      "hrsh7th/cmp-cmdline",        -- Ligne de commande
      "hrsh7th/cmp-nvim-lsp-signature-help", -- Signature help
      
      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Charger les snippets VSCode
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Personnaliser les snippets
      luasnip.config.setup({
        history = true,
        update_insertmode = true,
        enable_autosnippets = true,
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- Fenêtre de complétion
        window = {
          completion = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            zindex = 1001,
          }),
          documentation = cmp.config.window.bordered({
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
            zindex = 1001,
          }),
        },
        -- Keymaps
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Navigation avec <Tab> et <S-Tab>
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        -- Sources et leur ordre de priorité
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 10 },
          { name = "nvim_lsp_signature_help", priority = 8 },
          { name = "luasnip", priority = 7 },
          { name = "buffer", priority = 5 },
          { name = "path", priority = 4 },
        }),
        -- Formatage des items
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, vim_item)
            local kind_icons = {
              Text = "",
              Method = "m",
              Function = "",
              Constructor = "",
              Field = "",
              Variable = "",
              Class = "",
              Interface = "",
              Module = "",
              Property = "",
              Unit = "",
              Value = "",
              Enum = "",
              Keyword = "",
              Snippet = "",
              Color = "",
              File = "",
              Reference = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = "",
              Event = "",
              Operator = "",
              TypeParameter = "",
            }
            
            vim_item.kind = string.format(" %s ", kind_icons[vim_item.kind] or "")
            vim_item.menu = "   (" .. entry.source.name .. ")"
            return vim_item
          end,
        },
      })

      -- Complétion pour la ligne de commande
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- LuaSnip: Moteur de snippets
  -- ═══════════════════════════════════════════════════════════
  -- Permet de créer et d'utiliser des templates de code
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    lazy = true,
  },
}
