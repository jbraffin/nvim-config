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

-- ─────────────────────────────────────────────────────────────
-- Session management
-- ─────────────────────────────────────────────────────────────

-- Quit Neovim cleanly with confirmation
local function quit_neovim()
  local modified_buffers = 0
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "modified") then
      modified_buffers = modified_buffers + 1
    end
  end

  if modified_buffers > 0 then
    local choice = vim.fn.confirm(
      "You have " .. modified_buffers .. " modified buffer(s). Quit Neovim?",
      "&Yes\n&No",
      2
    )
    if choice == 1 then
      vim.cmd("qa!")
    end
  else
    vim.cmd("qa!")
  end
end

keymap("n", "<leader>q", quit_neovim, { noremap = true, silent = true, desc = "Quit Neovim" })
keymap("n", "<leader>nq", quit_neovim, { noremap = true, silent = true, desc = "Quit Neovim (alias)" })
