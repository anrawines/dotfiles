return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { 
        "pyright", 
        "marksman", 
        "bashls" 
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Menggunakan cara baru Neovim 0.11+
      -- Ini menghindari pemanggilan require('lspconfig') yang sudah deprecated
      
      -- Konfigurasi Python
      vim.lsp.config('pyright', {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { ".git", "pyproject.toml", "setup.py" },
      })
      vim.lsp.enable('pyright')

      -- Konfigurasi Bash
      vim.lsp.config('bashls', {
        filetypes = { "sh", "bash" },
      })
      vim.lsp.enable('bashls')

      -- Konfigurasi Markdown
      vim.lsp.enable('marksman')
    end,
  },
}
