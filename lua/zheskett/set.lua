-- Treat .h files as C (not C++)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h",
  callback = function()
    vim.bo.filetype = "c"
  end,
})

-- Auto-format on save for C/C++/Go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp", "*.hpp", "*.go" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Reset statuscolumn when leaving NvimTree
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype ~= "NvimTree" then
      vim.wo.statuscolumn = "%s%=%{v:lnum} %{v:relnum} "
    end
  end,
})

vim.cmd.colorscheme("onedark")
vim.opt.clipboard = 'unnamedplus'
vim.opt.nu = true
vim.opt.relativenumber = true

-- Show both absolute and relative line numbers
vim.opt.statuscolumn = "%s%=%{v:lnum} %{v:relnum} "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.linebreak = true -- Wrap at word boundaries
vim.opt.incsearch = true
vim.opt.termguicolors = true

-- Folding settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false  -- Don't fold by default when opening files
vim.opt.foldlevel = 99       -- High fold level so folds are open by default
vim.opt.foldtext = ""        -- Use treesitter for fold text

-- Diagnostic settings - show inline error messages
vim.diagnostic.config({
  virtual_text = true,  -- Show diagnostic messages inline
  signs = true,
  underline = true,
  update_in_insert = false,  -- Don't show diagnostics while typing
  severity_sort = true,  -- Show errors before warnings
})
