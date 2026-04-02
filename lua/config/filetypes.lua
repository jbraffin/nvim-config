-- ╔═══════════════════════════════════════════════════════════╗
-- ║        File Type Configuration                            ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Configure custom file type associations
vim.filetype.add({
  extension = {
    tfvars = "terraform",
    tf = "terraform",
  },
})
