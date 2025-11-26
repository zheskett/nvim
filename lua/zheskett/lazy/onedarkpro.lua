return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,

  config = function()
    local helpers = require("onedarkpro.helpers")
    local colors = require("onedarkpro.helpers").get_colors("onedark")

    require("onedarkpro").setup({
      colors = {
        red = helpers.lighten(colors.red, 10),
        dark_red = helpers.darken(colors.red, 10),
        orange = helpers.darken(colors.orange, 15),
      },
      highlights = {
        Constant = { fg = "${dark_red}" },
        ["@constant"] = { fg = "${dark_red}" },
        ["@constant.builtin"] = { fg = "${dark_red}" },
        ["@variable.builtin"] = { fg = "${dark_red}" },
        ["@lsp.typemod.variable.readonly.c"] = { fg = "${dark_red}" },
        ["@lsp.typemod.parameter.readonly.c"] = { fg = "${dark_red}" },
        ["@constant.go"] = { fg = "${dark_red}" },
        Operator = { fg = "${white}" },
        ["@operator"] = { fg = "${white}" },
        ["@operator.go"] = { fg = "${white}" },
        ["@punctuation.special"] = { fg = "${white}" },
        LineNr = { fg = helpers.brighten(colors.line_number, 20) },
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
