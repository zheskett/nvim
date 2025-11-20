return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua', -- optional
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    'mason-org/mason-lspconfig.nvim',
  },
  ft = { "go", "gomod" }, -- only load for Go files
  opts = {
    lsp_cfg = true, -- use go.nvim will setup gopls
    lsp_keymaps = false, -- disable default keymaps to prevent conflicts
    lsp_inlay_hints = { enable = false }, -- disable inlay hints by default
  },
  config = function(_, opts)
    require("go").setup(opts)
    --
    -- format config here
    --
    local gopls_cfg = require('go.lsp').config()
    -- gopls_cfg.filetypes = { 'go', 'gomod'}, -- override settings
    vim.lsp.config.gopls = gopls_cfg
    vim.lsp.enable('gopls')
  end
}
