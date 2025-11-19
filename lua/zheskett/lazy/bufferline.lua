return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "DaikyXendo/nvim-material-icon",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        diagnostics = "nvim_lsp",
        style_preset = bufferline.style_preset.default,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "center",
          },
        },
      }
    })
  end,
}
