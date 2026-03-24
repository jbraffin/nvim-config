-- ╔═══════════════════════════════════════════════════════════╗
-- ║              Neovim Settings & Options                     ║
-- ╚═══════════════════════════════════════════════════════════╝

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- General settings
vim.opt.number = true              -- Afficher les numéros de ligne
vim.opt.relativenumber = true      -- Numéros relatives pour faciliter le mouvement
vim.opt.signcolumn = "yes"         -- Toujours afficher la colonne pour les diagnostics
vim.opt.cursorline = true          -- Mettre en évidence la ligne actuelle
vim.opt.cursorcolumn = false       -- Ne pas mettre en évidence la colonne (trop d'info)

-- Indentation
vim.opt.expandtab = true           -- Utiliser des espaces au lieu des tabs
vim.opt.tabstop = 2                -- Largeur d'une tab (visuelle)
vim.opt.shiftwidth = 2             -- Taille du décalage automatique
vim.opt.softtabstop = 2            -- Espaces quand on appuie sur tab
vim.opt.smartindent = true         -- Indentation intelligente

-- Search
vim.opt.ignorecase = true          -- Pas sensible à la casse par défaut
vim.opt.smartcase = true           -- Mais sensible si on utilise des majuscules
vim.opt.hlsearch = true            -- Mettre en évidence les recherches
vim.opt.incsearch = true           -- Recherche pendant qu'on tape

-- Display
vim.opt.wrap = true                -- Activer le retour à la ligne visuel
vim.opt.scrolloff = 10             -- Garder 10 lignes visibles au-dessus/dessous du curseur
vim.opt.sidescrolloff = 10         -- Garder 10 colonnes visibles à gauche/droite
vim.opt.splitright = true          -- Splits verticaux à droite par défaut
vim.opt.splitbelow = true          -- Splits horizontaux en bas par défaut

-- Performance
vim.opt.updatetime = 250           -- Temps avant mise à jour (utile pour gitsigns)
vim.opt.timeoutlen = 300           -- Temps pour les keymaps en séquence

-- Hidden features
vim.opt.hidden = true              -- Garder les buffers non-sauvegardés en arrière-plan
vim.opt.mouse = "a"                -- Support de la souris
vim.opt.undofile = true            -- Sauvegarder l'historique entre sessions
vim.opt.swapfile = false           -- Ne pas créer de fichiers .swp
vim.opt.backup = false             -- Ne pas créer de fichiers de sauvegarde

-- Wildmenu (command line completion)
vim.opt.wildmenu = true
vim.opt.wildignore = "*.o,*.obj,.git,node_modules,dist,build"

-- Clipboard integration (access system clipboard)
vim.opt.clipboard = "unnamedplus"
