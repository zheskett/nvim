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
        -- Select next item
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- Select prev item
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        -- Open/close completion menu
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        -- Tab: If something selected in cmp → accept it
        --      Else if supermaven has suggestion → accept supermaven
        --      Else if cmp visible → accept first option
        --      Else → fallback
        ["<Tab>"] = cmp.mapping(function(fallback)
          local suggestion_state = require("supermaven-nvim.completion_preview")
          if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = false })
          elseif suggestion_state.has_suggestion() then
            fallback() -- Let Supermaven handle it
          elseif cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Shift+Tab: Always accept completion menu item
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Enter: Only confirm if something is manually selected with C-j/C-k
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_selected_entry() then
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
