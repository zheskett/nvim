return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "DaikyXendo/nvim-material-icon",
  },
  config = function()
    require("nvim-tree").setup({
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
      highlight_git = "name", -- highlight git status in filename
      root_folder_label = ":t", -- show only folder name, not full path
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false, -- don't show git status icons
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
    })

    -- Auto-close Neovim if NvimTree is the last window
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= '' then
            table.insert(floating_wins, w)
          end
        end
        if #wins - #floating_wins - #tree_wins == 1 then
          -- Should quit, so we close all invalid windows
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end
    })
  end,
}
