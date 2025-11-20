return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {
    bind = true, -- This is mandatory, otherwise border config won't work
    handler_opts = {
      border = "rounded"
    },
    hint_enable = false, -- Disable virtual text hints (can be distracting)
    floating_window = true, -- Show signature help in floating window
    floating_window_above_cur_line = true, -- Position above current line
    toggle_key = "<M-x>", -- Alt+x to toggle signature help
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end
}
