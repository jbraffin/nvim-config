-- ╔═══════════════════════════════════════════════════════════╗
-- ║            Custom Git Graph Command Setup                 ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Function to find git repository root
local function get_git_root()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    file_path = vim.fn.getcwd()
  end

  local dir = vim.fn.fnamemodify(file_path, ":h")
  local git_root = vim.fn.systemlist("git -C " .. dir .. " rev-parse --show-toplevel")[1]

  if vim.v.shell_error == 0 and git_root and git_root ~= "" then
    return git_root
  end
  return nil
end

-- Function to open git graph in a terminal split
local function open_git_graph()
  local git_root = get_git_root()

  if not git_root then
    vim.notify("Not in a git repository", vim.log.levels.WARN)
    return
  end

  -- Change to git root directory
  vim.cmd("cd " .. git_root)

  -- Open a new split with git log graph
  vim.cmd("new")
  
  -- Create autocmd to setup keymap when terminal buffer loads
  local augroup = vim.api.nvim_create_augroup("git_graph_term", { clear = true })
  vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    pattern = "term://*git*",
    callback = function(event)
      vim.keymap.set("t", "q", "<C-\\><C-n>:close<CR>", { noremap = true, silent = true, buffer = event.buf })
    end,
  })

  vim.fn.termopen("git log --graph --oneline --all --decorate --simplify-by-decoration", {
    on_exit = function()
      -- Clean up autocmd on exit
      vim.api.nvim_del_augroup_by_name("git_graph_term")
    end,
  })

  -- Set terminal mode options
  vim.cmd("startinsert")

  vim.notify("Git graph opened (press 'q' to quit)", vim.log.levels.INFO)
end

-- Create the custom command
vim.api.nvim_create_user_command("GitGraph", open_git_graph, {
  desc = "View git log graph for current repository",
})

-- Set keybinding
vim.keymap.set("n", "<leader>gg", open_git_graph, {
  noremap = true,
  silent = true,
  desc = "View Git Graph (current project)",
})
