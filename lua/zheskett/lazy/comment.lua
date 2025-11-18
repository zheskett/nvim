return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Add comment string for languages
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = "gcc", -- Line-comment toggle keymap
      block = "gbc", -- Block-comment toggle keymap
    },
    opleader = {
      line = "gc", -- Line-comment keymap
      block = "gb", -- Block-comment keymap
    },
    extra = {
      above = "gcO", -- Add comment on the line above
      below = "gco", -- Add comment on the line below
      eol = "gcA", -- Add comment at the end of line
    },
    mappings = {
      basic = true,
      extra = true,
    },
  },
}
