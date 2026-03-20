return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- Ganti build-nya jadi ini:
    build = function() vim.fn["mkdp#util#install"]() end, 
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      -- Paksa gunakan firefox
      vim.g.mkdp_browser = "firefox"
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
        file_types = { "markdown" },
    },
  },
}
