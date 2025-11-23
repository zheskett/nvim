return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,

  config = function()
    local helpers = require("onedarkpro.helpers")

    require("onedarkpro").setup({
      colors = {
        red = helpers.lighten("red", 5, "onedark"),
        dark_red = helpers.darken("red", 10, "onedark"),
        orange = helpers.darken("orange", 15, "onedark"),
      },
      highlights = {
        Constant = { fg = "${dark_red}" },
        ["@constant"] = { fg = "${dark_red}" },
        ["@constant.builtin"] = { fg = "${dark_red}" },
        ["@variable.builtin"] = { fg = "${dark_red}" },
        ["@lsp.typemod.variable.readonly.c"] = { fg = "${dark_red}" },
        ["@lsp.typemod.parameter.readonly.c"] = { fg = "${dark_red}" },
        Operator = { fg = "${white}" },
        ["@operator"] = { fg = "${white}" },
        ["@punctuation.special"] = { fg = "${white}" },
      },
      styles = {
        comments = "italic",
        keywords = "bold",
      },
      options = {
        transparency = true,
      },
    })
  end,
}
