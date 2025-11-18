return {
  "Mofiqul/vscode.nvim",
  name="vscode",
  priority=1000,
  lazy=false,
  config = function ()
    require("vscode").setup({
      transparent = true,
      italic_comments = true,
      italic_inlayhints = true,
      underline_links = true,
      disable_nvimtree_bg = true,
    })
  end,
}
