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
      "marksman", -- Markdown LSP
    },
    handlers = {
      function(server_name)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- Custom handler for gopls
      ["gopls"] = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig").gopls.setup({
          capabilities = capabilities,
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
          on_attach = function(client, bufnr)
            -- Workaround for gopls not supporting semanticTokensProvider
            -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              if semantic then
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers,
                  },
                  range = true,
                }
              end
            end

            -- Explicitly start semantic tokens
            if client.server_capabilities.semanticTokensProvider then
              vim.lsp.semantic_tokens.start(bufnr, client.id)
            end
          end,
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
