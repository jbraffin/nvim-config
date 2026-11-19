-- Keep the existing command as an alias for the Flog graph.
vim.api.nvim_create_user_command("GitGraph", function()
  vim.cmd("botright vertical Flogsplit -all")
end, {
  desc = "View the Git graph for all branches",
})
