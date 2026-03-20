-- Tambahkan ini di bagian paling atas init.lua
if vim.fn.has("nvim-0.11") == 1 then
  vim.treesitter.language.ft_to_lang = function(ft)
    return vim.treesitter.language.get_lang(ft) or ft
  end
end

require('config.options')
require('config.keymaps')
require('config.lazy')

