return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "neovim/nvim-lspconfig" },
  },
  opts = {
    ensure_installed = {
      "lua_ls",
    },
    handlers = {
      function(server_name)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
    },
  },
}
