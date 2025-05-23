return {
  "Pocco81/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },

  opts = {
    enabled = true,
    execution_message = {
      message = "",
      dim = 0,
      cleaning_interval = 0,
    },
    debounce_delay = 135,
    condition = function(buf)
      local fn = vim.fn
      local utils = require "auto-save.utils.data"
      return fn.getbufvar(buf, "&modifiable") == 1
        and utils.not_in(fn.getbufvar(buf, "&filetype"), { "gitcommit", "nofile", "toggleterm" })
    end,
  },
}
