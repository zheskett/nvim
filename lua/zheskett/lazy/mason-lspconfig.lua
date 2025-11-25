return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "neovim/nvim-lspconfig" },
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "clangd",  -- C/C++ LSP with formatting support
      "gopls",   -- Go LSP with formatting and diagnostics
      "pyright", -- Python LSP with type checking
    },
    handlers = {
      function(server_name)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- Custom handler for pyright to ensure proper venv detection
      ["pyright"] = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig").pyright.setup({
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        })
      end,
    },
  },
}
