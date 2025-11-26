-- Keymaps configuration
local wk = require("which-key")

-- Register with leader key
wk.add({
  { "<leader>f", group = "Find/File" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
  { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find Symbols" },
  { "<leader>fw", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", desc = "Find Workspace Symbols" },

  { "<leader>e", group = "Explorer" },
  { "<leader>ee", "<cmd>NvimTreeFocus<cr>", desc = "Focus NvimTree" },
  { "<leader>ec", "<cmd>NvimTreeClose<cr>", desc = "Close NvimTree" },
  { "<leader>eo", function()
      local view = require("nvim-tree.view")
      if not view.is_visible() then
        vim.cmd("NvimTreeOpen")
        -- Return focus to previous window
        vim.cmd("wincmd p")
      end
    end, desc = "Open NvimTree (Keep Focus)" },
  { "<leader>ed", function()
      local path = vim.fn.input("Change directory to: ", "", "dir")
      if path ~= "" then
        -- Expand path (handles ~, ., .., etc)
        path = vim.fn.fnamemodify(path, ":p")
        -- Close NvimTree if open
        vim.cmd("NvimTreeClose")
        -- Change Neovim's working directory
        vim.cmd("cd " .. vim.fn.fnameescape(path))
        -- Open NvimTree at the new path using the API
        require("nvim-tree.api").tree.open({ path = path })
      end
    end, desc = "Change Directory" },

  { "<leader>b", group = "Buffer" },
  { "<leader>bd", function()
      local bufnum = vim.api.nvim_get_current_buf()

      -- Get list of normal buffers (exclude NvimTree, etc)
      local bufs = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted and vim.api.nvim_buf_is_valid(b)
      end, vim.api.nvim_list_bufs())

      -- If there are other buffers, switch to previous first
      if #bufs > 1 then
        vim.cmd("bprevious")
      end

      -- Delete the original buffer by number
      vim.api.nvim_buf_delete(bufnum, { force = false })
    end, desc = "Delete Buffer" },
  { "<leader>bD", function()
      -- Get all listed buffers
      local bufs = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted and vim.api.nvim_buf_is_valid(b)
      end, vim.api.nvim_list_bufs())

      -- Delete all buffers
      for _, bufnr in ipairs(bufs) do
        vim.api.nvim_buf_delete(bufnr, { force = false })
      end

      -- Create a new empty buffer
      vim.cmd("enew")
    end, desc = "Delete All Buffers" },
  { "<leader>bo", function()
      local current = vim.api.nvim_get_current_buf()

      -- Get all listed buffers except current
      local bufs = vim.tbl_filter(function(b)
        return vim.bo[b].buflisted and vim.api.nvim_buf_is_valid(b) and b ~= current
      end, vim.api.nvim_list_bufs())

      -- Delete all other buffers
      for _, bufnr in ipairs(bufs) do
        vim.api.nvim_buf_delete(bufnr, { force = false })
      end
    end, desc = "Delete Other Buffers" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
  { "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
  { "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },

  { "<leader>w", group = "Window" },
  { "<leader>wh", "<C-w>h", desc = "Move to Left Window" },
  { "<leader>wj", "<C-w>j", desc = "Move to Lower Window" },
  { "<leader>wk", "<C-w>k", desc = "Move to Upper Window" },
  { "<leader>wl", "<C-w>l", desc = "Move to Right Window" },
  { "<leader>ws", "<cmd>split<cr>", desc = "Horizontal Split" },
  { "<leader>wv", "<cmd>vsplit<cr>", desc = "Vertical Split" },
  { "<leader>wq", "<cmd>close<cr>", desc = "Close Window" },


  { "<leader>l", group = "LSP" },
  { "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "<leader>lr", vim.lsp.buf.references, desc = "Find References" },
  { "<leader>lh", vim.lsp.buf.hover, desc = "Hover Documentation" },
  { "<leader>li", vim.lsp.buf.implementation, desc = "Go to Implementation" },
  { "<leader>ls", vim.lsp.buf.signature_help, desc = "Signature Help" },
  { "<leader>ln", vim.lsp.buf.rename, desc = "Rename" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
  { "<leader>lf", vim.lsp.buf.format, desc = "Format" },

  { "<leader>x", group = "Diagnostics" },
  { "<leader>xd", vim.diagnostic.open_float, desc = "Show Diagnostic" },
  { "<leader>xn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>xp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { "<leader>xl", vim.diagnostic.setloclist, desc = "Diagnostics to Location List" },
  { "<leader>xa", "<cmd>Telescope diagnostics<cr>", desc = "All Diagnostics" },

  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk" },
  { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
  { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
  { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
  { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
  { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
  { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
  { "<leader>gt", group = "Toggle" },
  { "<leader>gtb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Blame" },
  { "<leader>gtd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle Deleted" },

  { "<leader>t", group = "Terminal" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
  { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal" },
  { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle Vertical Terminal" },

  { "<leader>s", group = "Search" },
  { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
  { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search in Project" },

  { "<leader>z", group = "Fold" },
  { "<leader>zc", "<cmd>%foldclose<cr>", desc = "Close All Folds" },
  { "<leader>zo", "<cmd>%foldopen<cr>", desc = "Open All Folds" },

  { "<leader>_", group = "Black Hole Register" },
  { "<leader>_d", "\"_d", desc = "Delete Without Yank", mode = { "n", "v" } },
  { "<leader>_D", "\"_D", desc = "Delete Line Without Yank", mode = { "n", "v" } },
  { "<leader>_c", "\"_c", desc = "Change Without Yank", mode = { "n", "v" } },
  { "<leader>_C", "\"_C", desc = "Change Line Without Yank", mode = { "n", "v" } },
  { "<leader>_x", "\"_x", desc = "Cut Char Without Yank", mode = { "n", "v" } },

  { "<leader>d", group = "Debug" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
  { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
  { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
  { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
  { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
  { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
  { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
  { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
  { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },

  { "<leader>v", group = "View/Preview" },
  { "<leader>vm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },

  -- Supermaven AI Code Completion
  -- Comment out this section to disable these keybinds
  { "<leader>c", group = "Code AI" },
  { "<leader>ct", "<cmd>SupermavenToggle<cr>", desc = "Toggle AI Suggestions" },
  { "<leader>cs", "<cmd>SupermavenShowLog<cr>", desc = "Show Supermaven Log" },
})

--[[
Supermaven Insert Mode Keybinds (configured in lua/zheskett/lazy/supermaven.lua):
  <Tab>      - Accept suggestion
  <M-.>      - Accept word (Alt+.)
  <C-;>      - Clear suggestion (Ctrl+;)
--]]

-- Some useful normal mode keymaps without leader
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "ZS", "<cmd>up<cr>", { desc = "Save File (if modified)" })


-- Smooth scrolling (3 lines at a time)
vim.keymap.set("n", "<C-e>", "3<C-e>", { desc = "Scroll Down 3 Lines" })
vim.keymap.set("n", "<C-y>", "3<C-y>", { desc = "Scroll Up 3 Lines" })

-- Quick 10-line movement
vim.keymap.set("n", "<C-j>", "10j", { desc = "Move Down 10 Lines" })
vim.keymap.set("n", "<C-k>", "10k", { desc = "Move Up 10 Lines" })

-- Flash (quick jump to any location)
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() require("flash").remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() require("flash").treesitter_search() end, { desc = "Treesitter Search" })

-- Visual mode: Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line Up" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down (Centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up (Centered)" })

-- Better paste (doesn't yank replaced text)
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste Without Yanking" })

-- Quick diagnostic navigation (no leader key needed)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show Diagnostic" })

-- Function keys for debugging (standard across most IDEs)
vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })

-- Window resizing with Ctrl+Shift+Arrow keys
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Fast buffer navigation (Ctrl+Tab style)
vim.keymap.set("n", "<C-Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<C-S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
