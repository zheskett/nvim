return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Custom mapping: Ctrl-e to close NvimTree
      vim.keymap.set('n', '<C-e>', api.tree.close, {
        buffer = bufnr,
        desc = 'Close NvimTree'
      })
    end,
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = false, -- show hidden files
    },
    -- Auto close when it's the last window
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
    -- Disable netrw (vim's default file explorer)
    disable_netrw = true,
    hijack_netrw = true,
    -- Update the focused file on BufEnter
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
  },
}
