return {
  "Exafunction/windsurf.nvim",
  event = 'InsertEnter',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = "<Tab>",
          accept_line = "<M-.>",
          clear = "<C-;>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    })
  end,
}
