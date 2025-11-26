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
        completeopt = "menu,menuone,noselect", -- Nothing selected by default
      },
      preselect = cmp.PreselectMode.None, -- Never preselect items
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          max_height = 15,
          max_width = 60,
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          max_height = 12,
          max_width = 60,
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        -- Scroll docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        -- Toggle completion menu
        ["<C-Space>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end),

        -- j/k navigate when menu is visible and something is selected
        ["j"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i" }),

        ["k"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i" }),

        -- Tab: If nothing selected, select first item. If selected, confirm it.
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.confirm({ select = false })
            end
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Shift+Tab: Deselect (go back to no selection)
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Enter: Only accept if something is selected, otherwise normal enter
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.get_selected_entry() then
            cmp.confirm({ select = false })
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "path", priority = 500 },
      }, {
        {
          name = "buffer",
          priority = 250,
          keyword_length = 3, -- Only suggest after typing 3 chars
          option = {
            get_bufnrs = function()
              return { vim.api.nvim_get_current_buf() } -- Only current buffer, not all open buffers
            end,
          },
        },
      }),
    })
  end,
}
