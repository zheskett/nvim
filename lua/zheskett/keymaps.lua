-- Keymaps configuration
local wk = require("which-key")

-- Normal mode mappings
local mappings = {
  -- File operations
  f = {
    name = "Find/File",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep Files" },
    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
  },

  -- File explorer
  e = { "<cmd>NvimTreeToggle<cr>", "Toggle File Explorer" },

  -- Buffer operations
  b = {
    name = "Buffer",
    d = { "<cmd>bd<cr>", "Delete Buffer" },
    n = { "<cmd>bnext<cr>", "Next Buffer" },
    p = { "<cmd>bprevious<cr>", "Previous Buffer" },
    l = { "<cmd>Telescope buffers<cr>", "List Buffers" },
  },

  -- Window operations
  w = {
    name = "Window",
    h = { "<C-w>h", "Move to Left Window" },
    j = { "<C-w>j", "Move to Lower Window" },
    k = { "<C-w>k", "Move to Upper Window" },
    l = { "<C-w>l", "Move to Right Window" },
    s = { "<cmd>split<cr>", "Horizontal Split" },
    v = { "<cmd>vsplit<cr>", "Vertical Split" },
    q = { "<cmd>close<cr>", "Close Window" },
  },

  -- LSP operations (will work when you set up LSP)
  l = {
    name = "LSP",
    d = { vim.lsp.buf.definition, "Go to Definition" },
    r = { vim.lsp.buf.references, "Find References" },
    h = { vim.lsp.buf.hover, "Hover Documentation" },
    i = { vim.lsp.buf.implementation, "Go to Implementation" },
    s = { vim.lsp.buf.signature_help, "Signature Help" },
    n = { vim.lsp.buf.rename, "Rename" },
    a = { vim.lsp.buf.code_action, "Code Action" },
    f = { vim.lsp.buf.format, "Format" },
  },

  -- Diagnostics (LSP warnings/errors)
  d = {
    name = "Diagnostics",
    d = { vim.diagnostic.open_float, "Show Diagnostic" },
    n = { vim.diagnostic.goto_next, "Next Diagnostic" },
    p = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
    l = { vim.diagnostic.setloclist, "Diagnostics to Location List" },
    a = { "<cmd>Telescope diagnostics<cr>", "All Diagnostics" },
  },

  -- Git operations
  g = {
    name = "Git",
    g = { "<cmd>LazyGit<cr>", "LazyGit" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage Buffer" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    b = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
    d = { "<cmd>Gitsigns diffthis<cr>", "Diff This" },
    t = {
      name = "Toggle",
      b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle Blame" },
      d = { "<cmd>Gitsigns toggle_deleted<cr>", "Toggle Deleted" },
    },
  },

  -- Terminal
  ["\\"] = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },

  -- Search/Replace
  s = {
    name = "Search",
    s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search in Buffer" },
    g = { "<cmd>Telescope live_grep<cr>", "Search in Project" },
  },
}

-- Register with leader key
wk.add({
  { "<leader>f", group = "Find/File" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffer" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },

  { "<leader>b", group = "Buffer" },
  { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Buffer" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
  { "<leader>bl", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },

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

  { "<leader>d", group = "Diagnostics" },
  { "<leader>dd", vim.diagnostic.open_float, desc = "Show Diagnostic" },
  { "<leader>dn", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
  { "<leader>dp", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
  { "<leader>dl", vim.diagnostic.setloclist, desc = "Diagnostics to Location List" },
  { "<leader>da", "<cmd>Telescope diagnostics<cr>", desc = "All Diagnostics" },

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

  { "<leader>\\", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },

  { "<leader>s", group = "Search" },
  { "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
  { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search in Project" },
})

-- Some useful normal mode keymaps without leader
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

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

-- ============================================================================
-- Codeium/Windsurf AI completion keybinds (configured in lazy/windsurf.lua)
-- ============================================================================
-- These are plugin configuration options, not vim keymaps
-- <Tab>     - Accept suggestion
-- <M-.>     - Accept line (Alt+.)
-- <C-;>     - Clear suggestion (Ctrl+;)
-- <M-]>     - Next suggestion (Alt+])
-- <M-[>     - Previous suggestion (Alt+[)
