return {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
  config = function()
    require("satellite").setup({
      current_only = false,
      winblend = 0,
      zindex = 40,
      excluded_filetypes = {},
      width = 2,
      handlers = {
        cursor = {
          enable = true,
        },
        search = {
          enable = true,
        },
        diagnostic = {
          enable = true,
        },
        gitsigns = {
          enable = true,
        },
        marks = {
          enable = true,
        },
      },
    })
  end,
}
