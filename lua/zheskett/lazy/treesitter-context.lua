return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-context").setup({
      enable = true,
      max_lines = 3, -- How many lines of context to show
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor", -- Line used to calculate context (cursor or topline)
      separator = nil,
      zindex = 20,
    })

    -- Keybind to jump to context (useful!)
    vim.keymap.set("n", "[t", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true, desc = "Jump to Context" })
  end,
}
