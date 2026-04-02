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
        ├── copilot.lua         # GitHub Copilot pour l'IA
        ├── tools.lua           # Telescope, explorer, formatter
        ├── terminal.lua        # Terminal intégré (ToggleTerm)
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

### 🤖 **GitHub Copilot**

- **copilot.vim**: Autocomplétion IA alimentée par GitHub Copilot
  - Suggestions intelligentes basées sur le contexte
  - Support multi-langage
  - Authentification requise (GitHub account)

### 💻 **Terminal Intégré**

- **ToggleTerm**: Terminal flottant/divisé intégré à Neovim
  - Multiple terminaux accessibles
  - Toggle rapide sans quitter l'éditeur
  - Shell natif ou NodeJS REPL
  - Parfait pour lancer des scripts pendant le développement

### 📖 **Utilities**

- **Which-key**: Affiche les keybindings disponibles
  - Désactiver avec <C-c>
  - Explore les préfixes de touches

- **Undotree**: Historique d'édition complet
  ```vim
  <leader>u    - Toggle undotree
  ```
  Permet d'explorer tout l'historique et de revenir à n'importe quel état précédent

## ⚙️ Configuration

### Touche Leader
- **Leader**: Barre d'espace (` `)
- **Local Leader**: Virgule (`,`)

Tous les raccourcis utilisant `<leader>` se font avec la **barre d'espace** suivi des autres touches.

## 🎮 Keybindings Complets par Plugin

### 🔍 **Telescope** (Recherche & Navigation)
```vim
<leader>ff  - Chercher fichiers
<leader>fg  - Chercher par contenu (grep)
<leader>fb  - Lister buffers ouverts
<leader>fh  - Chercher dans l'aide
<leader>fs  - Chercher dans le buffer courant
<leader>fd  - Lister les diagnostics
<leader>fc  - Lister les commits Git
```

### 📁 **Nvim-tree** (Explorateur de fichiers)
```vim
<leader>e   - Toggle l'explorateur de fichiers
```
*Dans l'arborescence: a (nouveau), d (supprimer), r (renommer), x (cut), c (copy), p (paste)*

### 🎨 **Treesitter** (Analyse syntaxique)
```vim
<C-space>   - Sélection incrémentale (augmenter la sélection)
<C-s>       - Sélection scope (sélectionner le bloc courant)
<C-backspace> - Réduire la sélection
```

### 🚀 **LSP** (Serveurs de langage)
```vim
gD          - Aller à la déclaration
gd          - Aller à la définition
gi          - Aller à l'implémentation
K           - Afficher la documentation (hover)
<C-k>       - Signature du paramètre
<leader>rn  - Renommer le symbole
<leader>ca  - Code actions (suggestions de correction)
<leader>f   - Formater le code
[d          - Diagnostic précédent
]d          - Diagnostic suivant
<leader>e   - Voir erreur sous le curseur en popup
<leader>q   - Ajouter diagnostics à quickfix
```

### 🎯 **Autocomplétion** (nvim-cmp)
```vim
<C-Space>   - Ouvrir menu de complétion
<Tab>       - Item suivant / Sauter au placeholder suivant
<S-Tab>     - Item précédent / Sauter au placeholder précédent
<CR>        - Confirmer la suggestion
<C-b>       - Scroll documentation vers le haut
<C-f>       - Scroll documentation vers le bas
<C-e>       - Quitter/Abort complétion
```

### 🤖 **GitHub Copilot** (Complétion IA)
```vim
:Copilot auth       - S'authentifier avec GitHub
:Copilot enable     - Activer Copilot
:Copilot disable    - Désactiver Copilot
<C-g>       - Accepter la suggestion Copilot (mode Insert)
<M-]>       - Suggestion Copilot suivante
<M-[>       - Suggestion Copilot précédente
<M-\>       - Rejeter la suggestion Copilot
```

### 📚 **Git** (Gitsigns & Fugitive)
```vim
]h          - Hunk suivant (changement Git)
[h          - Hunk précédent
<leader>hs  - Stage hunk (valider le changement)
<leader>hr  - Reset hunk (annuler le changement)
<leader>hp  - Preview hunk (voir les changements)
<leader>hb  - Blame line (qui a changé cette ligne)
<leader>hd  - Diff du fichier
<leader>hc  - Toggle blame courant
<leader>hx  - Toggle deleted (montrer les lignes supprimées)
<leader>hS  - Stage tout le buffer
<leader>hu  - Undo stage hunk
<leader>hR  - Reset tout le buffer
<leader>gs  - Git Status (Fugitive)
<leader>gg  - LazyGit (interface TUI complète)
```

### 💻 **Terminal** (ToggleTerm)
```vim
<C-\>       - Toggle terminal flottant (le plus rapide!)
<leader>tf  - Terminal flottant
<leader>th  - Terminal horizontal (bottom)
<leader>tv  - Terminal vertical (right)
<leader>tn  - Node.js REPL
```
*Dans le terminal: type mode normal (`:`) puis `exit` ou `<C-d>` pour quitter*

### 🛠️ **Mason & Conform** (LSP & Formatters)
```vim
<leader>m   - Ouvrir Mason (GUI des LSP/tools)
```
*Dans Mason: i (install), u (update), x (uninstall)*

### 📖 **Which-Key** (Aide keybindings)
```vim
<leader>    - Appuyer sur leader seul affiche tous les keybindings disponibles
<C-c>       - Fermer which-key
```

### 🔄 **Undo History** (Undotree)
```vim
<leader>u   - Toggle Undotree (voir l'historique arborescent)
```
*Dans UndoTree: <CR> (go to), p (preview), q (quit)*

### 📋 **Lint** (nvim-lint)
```vim
# Linting automatique au sauvegarde et après insertion
# Erreurs visibles dans gutter (colonne de gauche)
```

## ⌨️ Keybindings Globaux (Édition & Navigation)

### Navigation Windows
```vim
<C-h>       - Aller à la window de gauche
<C-j>       - Aller à la window du bas
<C-k>       - Aller à la window du haut
<C-l>       - Aller à la window de droite
```

### Redimensionner Windows
```vim
<C-Up>      - Augmenter hauteur
<C-Down>    - Diminuer hauteur
<C-Left>    - Diminuer largeur
<C-Right>   - Augmenter largeur
```

### Édition
```vim
<Esc>       - Supprimer les highlights de recherche
<C-z>       - Undo
<C-y>       - Redo
<A-j>       - Déplacer ligne vers le bas (normal)
<A-k>       - Déplacer ligne vers le haut (normal)
```

### Indentation (Visual Mode)
```vim
<           - Diminuer indentation + réselectionner
>           - Augmenter indentation + réselectionner
```

## 📚 Guides Complets & Tips

### 🌳 **Nvim-tree Guide Complet**

**Ouvrir/Fermer l'explorateur:**
```vim
<leader>e       - Toggle l'explorateur de fichiers (côté gauche)
```

#### 🎯 **Raccourcis dans nvim-tree:**

| Raccourci | Action |
|-----------|--------|
| `<CR>` | Ouvrir fichier dans le buffer courant / Développer dossier |
| `o` | Ouvrir fichier |
| `<C-t>` | **Ouvrir dans un nouvel onglet (tab)** |
| `<C-v>` | **Ouvrir en split vertical** |
| `<C-x>` | **Ouvrir en split horizontal** |
| `<C-]>` | Ouvrir en split et aller à cette fenêtre |
| `a` | **Créer nouveau fichier ou dossier** |
| `d` | Supprimer fichier / dossier |
| `r` | Renommer | 
| `x` | Couper (cut) |
| `c` | Copier |
| `p` | Coller (paste) |
| `J` | Aller au dernier fichier ouvert |
| `K` | Aller au premier fichier du répertoire |
| `g?` | Afficher l'aide |

#### 💡 **Tips pour créer des fichiers/dossiers:**

**Créer un fichier simple:**
1. Appuyez `a` dans nvim-tree
2. Tapez: `mon-fichier.ts`
3. Validez avec `<Enter>`

**Créer un dossier simple:**
1. Appuyez `a` dans nvim-tree
2. Tapez: `mon-dossier/` (avec le `/` final)
3. Validez avec `<Enter>`

**Créer une structure complète (auto-création des dossiers):**
1. Appuyez `a` dans nvim-tree
2. Tapez: `src/components/Button.tsx`
3. Validez avec `<Enter>` 
4. nvim-tree crée automatiquement `src/` et `components/` ! 🚀

**Créer plusieurs niveaux de dossiers:**
1. Appuyez `a` dans nvim-tree
2. Tapez: `src/pages/admin/settings/`
3. Validez avec `<Enter>`

---

### 📂 **Navigation Multiple Fichiers (Buffers, Splits, Tabs)**

#### **Buffers** (fichiers en mémoire):
```vim
:e {fichier}        - Ouvrir un fichier
:bn                 - Buffer suivant (next)
:bp                 - Buffer précédent (previous)
:b {nom}            - Aller à un buffer spécifique
:ls                 - Lister tous les buffers ouverts
:e#                 - Basculer entre 2 fichiers (alt+alt)
:bd                 - Fermer le buffer courant
```

#### **Splits** (fenêtres divisées):
```vim
:vsplit {fichier}   - Ouvrir fichier en split vertical
:split {fichier}    - Ouvrir fichier en split horizontal
:only               - Garder seulement la window courant
Ctrl+w =            - Égaliser hauteur/largeur de toutes windows
```

**Navigation entre splits:**
```vim
<C-h>               - Aller à la window gauche
<C-j>               - Aller à la window bas
<C-k>               - Aller à la window haut
<C-l>               - Aller à la window droite
```

**Redimensionner splits:**
```vim
<C-Up>              - Augmenter hauteur
<C-Down>            - Diminuer hauteur
<C-Left>            - Diminuer largeur
<C-Right>           - Augmenter largeur
```

#### **Tabs** (onglets):
```vim
:tabnew {fichier}   - Ouvrir fichier dans un nouvel onglet
gt                  - Onglet suivant
gT                  - Onglet précédent
:tabc               - Fermer l'onglet courant
:tabm 2             - Déplacer l'onglet à la position 2
```

#### 🎯 **Workflow typique - Ouvrir plusieurs fichiers:**
```
1. Ouvrez nvim-tree:  <leader>e
2. Naviguez vers un fichier
3. Appuyez:
   - <CR>            → Buffer courant
   - <C-v>           → Split vertical (côte à côte)
   - <C-x>           → Split horizontal (haut/bas)
   - <C-t>           → Nouvel onglet
4. Naviguez avec Ctrl+h/j/k/l entre splits
5. Redimensionnez avec Ctrl+Up/Down/Left/Right
```

---

### ⌨️ **Raccourcis Courants - Édition & Navigation**

#### **Fichiers & Sauvegarde:**
```vim
<C-s>               - Sauvegarder le fichier courant
:w                  - Sauvegarder (commande)
:wa                 - Sauvegarder TOUS les fichiers
:wq                 - Sauvegarder et quitter
:q!                 - Quitter SANS sauvegarder
:e!                 - Recharger le fichier depuis le disque
```

#### **Édition de texte:**
```vim
<C-z>               - Undo (annuler)
<C-y>               - Redo (refaire)
<A-j>               - Déplacer ligne vers le bas (mode normal)
<A-k>               - Déplacer ligne vers le haut (mode normal)
<A-j>               - Déplacer bloc vers le bas (mode visual)
<A-k>               - Déplacer bloc vers le haut (mode visual)
```

#### **Indentation (Mode Visual):**
```vim
<                   - Diminuer indentation + réselectionner
>                   - Augmenter indentation + réselectionner
```

#### **Recherche:**
```vim
<Esc>               - Supprimer highlights de recherche
/mot                - Chercher (mode normal)
n                   - Occurrence suivante
N                   - Occurrence précédente
```

#### **Sélection:**
```vim
v                   - Mode visual (caractère par caractère)
V                   - Mode visual ligne (ligne complète)
<C-v>               - Mode visual bloc (rectangle)
```

---

### 🔍 **Recherche & Fuzzy Find (Telescope)**

**Flux complet:**
```vim
<leader>ff          - Chercher fichiers (fuzzy find)
                      • Double-clic pour ouvrir
                      • <C-x> pour split horizontal
                      • <C-v> pour split vertical
                      • <C-t> pour onglet

<leader>fg          - Chercher par contenu (grep, cherche dans fichiers)
<leader>fb          - Lister les buffers ouverts
<leader>fh          - Chercher dans l'aide Neovim
<leader>fs          - Chercher dans le buffer courant
<leader>fd          - Lister les diagnostics (erreurs/warnings)
<leader>fc          - Lister les commits Git
```

**Dans Telescope:**
```vim
<C-q>               - Ajouter résultats à quickfix list
<C-u>               - Scroll preview vers le haut
<C-d>               - Scroll preview vers le bas
<Esc>               - Quitter Telescope
```

---

### 🚀 **Premiers pas

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
