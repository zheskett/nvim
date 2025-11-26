return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "rshkarin/mason-nvim-lint",
  },
  config = function()
    local lint = require("lint")

    -- Configure linters by filetype
    lint.linters_by_ft = {
      markdown = { "markdownlint" },
    }

    -- Setup mason-nvim-lint
    require("mason-nvim-lint").setup({
      ensure_installed = { "markdownlint" },
      automatic_installation = true,
    })

    -- Create autocommand to run linter
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
