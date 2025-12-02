return {
  -- Core DAP (Debug Adapter Protocol) plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Beautiful UI for debugging
      "rcarriga/nvim-dap-ui",
      -- Required for dap-ui
      "nvim-neotest/nvim-nio",
      -- Shows variable values as virtual text while debugging
      "theHamsta/nvim-dap-virtual-text",
      -- Integrates Mason with DAP for easy debug adapter installation
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup Mason-DAP to automatically install debug adapters
      require("mason-nvim-dap").setup({
        -- Automatically install these debug adapters
        ensure_installed = { "codelldb", "delve" }, -- codelldb for C/C++/Rust, delve for Go
        automatic_installation = true,
        handlers = {}, -- Use default handlers
      })

      -- Setup DAP UI with default configuration
      dapui.setup()

      -- Setup virtual text to show variable values inline
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = '<module',
      })

      -- Configure codelldb adapter for C/C++ debugging (installed via Mason)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- Configure how to debug C programs
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          -- This will prompt you for the executable path each time
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Attach to process",
          type = "codelldb",
          request = "attach",
          pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = "${workspaceFolder}",
        },
      }

      -- Also use the same configuration for C++
      dap.configurations.cpp = dap.configurations.c

      -- Configure delve adapter for Go debugging (installed via Mason)
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      -- Configure how to debug Go programs
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }

      -- Automatically open/close the DAP UI when debugging starts/ends
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Custom signs for breakpoints in the gutter
      vim.fn.sign_define('DapBreakpoint', {
        text = '🔴',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '🟡',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
      })
      vim.fn.sign_define('DapBreakpointRejected', {
        text = '⚫',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = 'DapBreakpoint'
      })
      vim.fn.sign_define('DapStopped', {
        text = '▶️',
        texthl = 'DapStopped',
        linehl = 'DapStopped',
        numhl = 'DapStopped'
      })
      vim.fn.sign_define('DapLogPoint', {
        text = '📝',
        texthl = 'DapLogPoint',
        linehl = '',
        numhl = 'DapLogPoint'
      })
    end,
  },
}
