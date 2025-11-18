return {
  "hrsh7th/nvim-cmp",
  main = "cmp",
  version = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "petertriho/cmp-git",
  },
  opts = function()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    return vim.tbl_deep_extend("force", defaults, {
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        -- Scroll docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Select next item
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- Select prev item
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        -- Open/close completion menu
        ["<C-Space>"] = cmp.mapping.complete(), 
        ["<C-e>"] = cmp.mapping.abort(),

        -- Confirm completion
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
