vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "CodeiumSuggestion", { fg = "#808080" })
  end,
})

vim.cmd.colorscheme("onedark")
vim.opt.clipboard = 'unnamedplus'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.linebreak = true -- Wrap at word boundaries
vim.opt.incsearch = true
vim.opt.termguicolors = true
