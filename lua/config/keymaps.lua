-- ╔═══════════════════════════════════════════════════════════╗
-- ║              Global Keybindings                            ║
-- ╚═══════════════════════════════════════════════════════════╝

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ─────────────────────────────────────────────────────────────
-- Basic Navigation & Editing
-- ─────────────────────────────────────────────────────────────

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrow keys
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Clear search highlighting
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Move lines
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- ─────────────────────────────────────────────────────────────
-- LSP Keybindings (will be enhanced by lspconfig)
-- ─────────────────────────────────────────────────────────────

-- Note: Most LSP keybindings are set by the lspconfig plugin
-- These are global ones

-- ─────────────────────────────────────────────────────────────
-- File operations
-- ─────────────────────────────────────────────────────────────

-- Better indentation in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Undo/Redo with better keys
keymap("n", "<C-z>", "u", opts)
keymap("n", "<C-y>", "<C-r>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)
