# 🌙 Configuration Neovim - IDE Complète

Une configuration Neovim professionnelle avec tous les plugins essentiels pour un IDE moderne.

## 🏗️ Structure de la configuration

```
~/.config/nvim/
├── init.lua                    # Point d'entrée principal
├── lazy-lock.json              # Versions figées des plugins (auto-généré)
└── lua/
    ├── config/
    │   ├── settings.lua        # Options Neovim (nombres, indentation, etc.)
    │   ├── keymaps.lua         # Keybindings globaux
    │   └── lazy.lua            # Configuration de lazy.nvim
    └── plugins/                # Chaque fichier = groupe de plugins
        ├── ui.lua              # Thème, statusline, notifications
        ├── treesitter.lua      # Coloration syntaxique avancée
        ├── lsp.lua             # Serveurs de langage (LSP)
        ├── completion.lua      # Autocomplétion et snippets
        ├── tools.lua           # Telescope, explorer, formatter
        └── git.lua             # Intégration Git
```

## ✨ Plugins et leur utilité

### 🎨 **Interface & Thème**

- **Catppuccin**: Thème élégant et cohérent (les 4 variantes: mocha, macchiato, frappe, latte)
- **Lualine**: Barre de statut affichant le mode, branche git, diagnostics
- **Indent-blankline**: Lignes verticales pour visualiser l'indentation
- **nvim-notify**: Notifications non-intrusive

### 💻 **Syntax & Code Analysis**

- **Treesitter**: Analyse syntaxique avancée par AST (Abstract Syntax Tree)
  - Meilleure coloration que regex
  - Code folding intelligent
  - Sélection incrémentale avec Ctrl+Space
  - Contexte du code toujours visible

### 🚀 **Language Server Protocol (LSP)**

- **nvim-lspconfig**: Configuration des serveurs de langage
- **Mason**: Gestionnaire GUI pour installer LSP/formatters/linters
- **Mason-lspconfig**: Intégration Mason + nvim-lspconfig

**Serveurs pré-configurés:**
- `lua_ls` pour Lua
- `pyright` pour Python
- `ts_ls` pour TypeScript/JavaScript
- `jsonls` pour JSON
- `html`, `cssls` pour HTML/CSS
- `bash-language-server` pour Bash

**Fonctionnalités:**
- Autocomplétion précise
- Diagnostics (erreurs/warnings) en temps réel
- Renommage de symboles
- Aller à définition (`gd`), implémentation (`gi`)
- Affichage du type au survol (`K`)
- Code actions au curseur (`<leader>ca`)
- Formatage du code (`<leader>f`)

### 🎯 **Autocomplétion**

- **nvim-cmp**: Moteur d'autocomplétion intelligent
  - Combine LSP, snippets, buffer, chemins de fichiers
  - Fenêtre bordée avec documentation
  - Navigation avec Tab/Shift+Tab
  - Confirmation avec Entrée

- **LuaSnip**: Moteur de snippets avec support VSCode
  - Paramètres dynamiques dans les snippets
  - Sauts entre placeholders avec Tab
  - Intégré avec friendly-snippets (centaines de snippets prêts)

### 🔍 **Navigation & Recherche**

- **Telescope**: Fuzzy finder puissant
  ```vim
  <leader>ff  - Chercher fichiers
  <leader>fg  - Chercher par contenu (grep)
  <leader>fb  - Lister buffers ouverts
  <leader>fh  - Chercher dans l'aide
  <leader>fs  - Chercher dans le buffer courant
  <leader>fd  - Lister les diagnostics
  <leader>fc  - Lister les commits Git
  ```

- **Nvim-tree**: Explorateur de fichiers
  ```vim
  <leader>e   - Toggle l'explorateur
  ```
  - Icons Git intégrées
  - Renommage, suppression de fichiers
  - Marquage de fichiers importants

### 🔧 **Code Quality**

- **Conform**: Formatage de code
  - Prettier pour JS/HTML/CSS/YAML
  - Black pour Python
  - Stylua pour Lua
  - Auto-format au sauvegarde
  - `<leader>f` - Format manuel

- **Nvim-lint**: Linting en temps réel
  - ESLint pour TypeScript/JavaScript
  - Pylint pour Python
  - Shellcheck pour Bash
  - Lint automatique au sauvegarde et après insertion

### 📚 **Git Integration**

- **Gitsigns**: Voir les changements Git inline
  ```vim
  ]h / [h      - Next/Previous hunk
  <leader>hs   - Stage hunk
  <leader>hr   - Reset hunk
  <leader>hp   - Preview hunk
  <leader>hb   - Afficher blame pour la ligne
  <leader>hd   - Diff du fichier
  ```

- **Fugitive**: Interface Git complète
  ```vim
  <leader>gs   - Git status
  <leader>gg   - Git log
  ```

- **Rhubarb**: Ouvrir le fichier sur GitHub

### 📖 **Utilities**

- **Which-key**: Affiche les keybindings disponibles
  - Désactiver avec <C-c>
  - Explore les préfixes de touches

- **Undotree**: Historique d'édition complet
  ```vim
  <leader>u    - Toggle undotree
  ```
  Permet d'explorer tout l'historique et de revenir à n'importe quel état précédent

## ⌨️ Keybindings Principaux

### Navigation LSP

```vim
gD      - Aller à la déclaration
gd      - Aller à la définition
gi      - Aller à l'implémentation
K       - Afficher la documentation au survol
<C-k>   - Signature du paramètre
```

### Édition LSP

```vim
<leader>rn  - Renommer le symbole
<leader>ca  - Code actions
<leader>f   - Formater le code
```

### Diagnostics

```vim
[d      - Diagnostic précédent
]d      - Diagnostic suivant
<leader>e - Voir erreur sous le curseur
<leader>q - Ajouter erreurs à quickfix
```

### Navigation Windows

```vim
<C-h/j/k/l> - Naviguer entre les windows
<C-↑/↓/←/→> - Redimensionner les windows
```

### Édition

```vim
<C-s>       - Sauvegarder le fichier
<C-z>       - Undo
<C-y>       - Redo
<A-j/k>     - Déplacer ligne(s)
<Tab>/<S-Tab> - Augmenter/diminuer indentation (visual)
```

## 🚀 Premiers pas

1. **Neovim installé ?** (v0.9+)
   ```bash
   brew install neovim
   ```

2. **Dépendances système** (pour les fonctionnalités optionnelles)
   ```bash
   # Ripgrep (pour Telescope)
   brew install ripgrep
   
   # Node.js (pour TypeScript et other formatters)
   brew install node
   
   # Python (pour Pyright)
   brew install python
   ```

3. **Premier lancement**
   ```bash
   nvim
   ```
   Lazy.nvim téléchargera automatiquement tous les plugins listés.

4. **Installer LSP/Formatters**
   ```vim
   :Mason
   ```
   Interface graphique pour installer les serveurs de langage.

## 📝 Personnalisation

### Ajouter un new LSP

Dans [lua/plugins/lsp.lua](lua/plugins/lsp.lua), ajouter dans `ensure_installed`:
```lua
ensure_installed = {
  "lua_ls",
  "pyright",
  "ts_ls",
  "new_lsp_name",  -- ← ajouter ici
},
```

### Changer le thème

Dans [lua/plugins/ui.lua](lua/plugins/ui.lua):
```lua
flavour = "latte", -- ou frappe, macchiato, mocha
```

### Ajouter un plugin

Créer un nouveau fichier dans `lua/plugins/` ou ajouter à un existant. Exemple dans `lua/plugins/tools.lua`:
```lua
{
  "author/plugin-name",
  dependencies = { "other-plugin" },
  config = function()
    require("plugin-name").setup({...})
  end,
}
```

### Ajouter un keybinding

Dans [lua/config/keymaps.lua](lua/config/keymaps.lua):
```lua
-- Syntax: keymap(mode, key, action, options)
vim.keymap.set("n", "<leader>xx", "<cmd>CommandName<CR>", { noremap = true, silent = true })
```

## 🎓 Concepts clés

- **LSP**: Protocole permettant à l'éditeur de communiquer avec des serveurs spécialisés par langage
- **Treesitter**: Parseur rapide construisant un AST pour meilleure analyse du code
- **Mason**: Gestionnaire centralisant LSP, formatters, linters
- **Lazy loading**: Charger plugins seulement quand nécessaire (performance)
- **Snippets**: Templates de code avec points d'insertion dynamiques

## 💡 Tips & Tricks

1. **Cascade au survol:**
   Utilise `<C-Space>` en mode insertion pour ouvrir l'autocomplétion

2. **Fuzzy find advanced:**
   Dans Telescope, tape `#` pour chercher par types (`#function`, `#class`)

3. **Undo history complex:**
   UndoTree montre l'arborescence complète (pas linéaire) de vos modifications

4. **Performance sur gros fichiers:**
   Treesitter désactive automatiquement la coloration au-delà de 10KB

5. **Git visual:**
   Gitsigns montre exactement ce qui a changé à côté des numéros de ligne

## 🐛 Troubleshooting

**Les plugins ne se chargent pas?**
```vim
:checkhealth lazy
```

**LSP ne fonctionne pas pour un langage?**
```vim
:LspInfo
:Mason
```
Vérifier l'outil est installé et la config est correcte.

**Autocomplétion lente?**
Vérifier que le LSP démarre correctement (`:LspInfo`)

**Telescope ne trouve rien?**
Vérifier que ripgrep est installé:
```bash
brew install ripgrep
```

---

**Enjoy! 🎉**
