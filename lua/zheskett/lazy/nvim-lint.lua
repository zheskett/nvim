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
      markdown = { "markdownlint", "codespell" },
      text = { "codespell" },
      gitcommit = { "codespell" },
      go = { "codespell" },
      c = { "codespell" },
      cpp = { "codespell" },
      python = { "codespell" },
      lua = { "codespell" },
    }

    -- Configure codespell to use custom ignore words file
    local codespell_ignore_file = vim.fn.stdpath("config") .. "/codespell-ignore.txt"
    lint.linters.codespell.args = {
      "--ignore-words=" .. codespell_ignore_file,
    }

    -- Function to add word to codespell ignore list
    _G.add_to_codespell_dict = function()
      local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })

      for _, diag in ipairs(diagnostics) do
        if diag.source == "codespell" then
          -- Extract the misspelled word from the diagnostic message
          -- Codespell format is usually: "word ==> suggestion1, suggestion2"
          local word = diag.message:match("^(%S+)")

          if word then
            -- Convert to lowercase
            word = word:lower()

            -- Read existing words
            local file = io.open(codespell_ignore_file, "a+")
            if file then
              file:write(word .. "\n")
              file:close()
              print("Added '" .. word .. "' to codespell dictionary")

              -- Refresh linting
              vim.defer_fn(function()
                lint.try_lint()
              end, 100)
            else
              print("Error: Could not open codespell ignore file")
            end
          end
          return
        end
      end

      print("No codespell diagnostic found at cursor")
    end

    -- Setup mason-nvim-lint
    require("mason-nvim-lint").setup({
      ensure_installed = { "markdownlint", "codespell" },
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
