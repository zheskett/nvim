return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "DaikyXendo/nvim-material-icon",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        diagnostics = "nvim_lsp",
        style_preset = bufferline.style_preset.default,
        close_command = function(bufnum)
          -- Get list of normal buffers (exclude NvimTree, etc)
          local bufs = vim.tbl_filter(function(b)
            return vim.bo[b].buflisted and vim.api.nvim_buf_is_valid(b)
          end, vim.api.nvim_list_bufs())

          -- If closing the current buffer and there are other buffers, switch first
          if bufnum == vim.api.nvim_get_current_buf() and #bufs > 1 then
            -- Try to switch to previous buffer, or next buffer
            vim.cmd("bprevious")
          end

          -- Delete the buffer
          vim.api.nvim_buf_delete(bufnum, { force = false })
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            highlight = "Directory",
            text_align = "center",
          },
        },
      }
    })
  end,
}
