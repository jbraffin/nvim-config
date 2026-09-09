-- ╔═══════════════════════════════════════════════════════════╗
-- ║        File Type Configuration                            ║
-- ╚═══════════════════════════════════════════════════════════╝

-- Configure custom file type associations
vim.filetype.add({
  extension = {
    tfvars = "terraform-vars",
    tf = "terraform",
  },
})
