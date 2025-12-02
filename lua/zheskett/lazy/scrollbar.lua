return {
  "lewis6991/satellite.nvim",
  event = "VeryLazy",
  config = function()
    -- Monkey-patch satellite's util to suppress E565 errors
    local satellite_util = require("satellite.util")
    local original_noautocmd = satellite_util.noautocmd
    satellite_util.noautocmd = function(f)
      return function(...)
        local eventignore = vim.o.eventignore
        vim.o.eventignore = 'all'
        local r = { pcall(f, ...) }
        vim.o.eventignore = eventignore
        if not r[1] then
          -- Suppress E565 errors (restricted context during buffer operations)
          if not string.match(tostring(r[2]), "E565") then
            error(r[2])
          end
          return
        end
        return unpack(r, 2, table.maxn(r))
      end
    end

    require("satellite").setup({
      current_only = false,
      winblend = 0,
      zindex = 40,
      excluded_filetypes = {
        "NvimTree",
        "TelescopePrompt",
        "lazy",
        "mason",
        "help",
        "toggleterm",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dap-repl",
      },
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
