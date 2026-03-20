return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local rainbow = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow.strategy['global'],
      },
      query = {
        [''] = 'rainbow-delimiters',
      },
    }
  end,
}
