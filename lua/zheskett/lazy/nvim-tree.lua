return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "DaikyXendo/nvim-material-icon",
  },
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
      number = true,
      relativenumber = true,
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- Use single-column hybrid numbers in NvimTree
      vim.wo[0].statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum} "
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
      custom = { ".DS_Store", ".git" }, -- hide macOS system files and git
    },
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
