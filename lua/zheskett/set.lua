vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "CodeiumSuggestion", { fg = "#808080" })
    -- Make visual selection more visible in carbonfox
    vim.api.nvim_set_hl(0, "Visual", { bg = "#4a5568", fg = "NONE" })
    -- Grey out git ignored files in nvim-tree
    vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#6b7280" })
  end,
})

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

-- Auto-close NvimTree if it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.bo[vim.api.nvim_win_get_buf(layout[2])].filetype == "NvimTree" and layout[3] == nil then
      vim.cmd("quit")
    end
  end,
})

vim.cmd.colorscheme("carbonfox")
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
