return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled",
        transparent = false,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
      groups = {
        all = {
          PreProc = { fg = "#da70d6" },      -- Bright purple preprocessor directives
          ["@preproc"] = { fg = "#da70d6" }, -- Bright purple Treesitter preprocessor
          Function = { fg = "#ffd787" },     -- Bright yellow functions
          ["@function"] = { fg = "#ffd787" }, -- Bright yellow Treesitter functions
        },
      },
    })
  end,
}
