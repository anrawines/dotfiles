return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    -- Menggunakan pcall agar jika modul belum terinstall, nvim tidak crash saat startup
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      configs.setup(opts)
    end
  end,
}
