return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    enable = true, -- Nyalakan plugin
    max_lines = 3, -- Maksimal baris yang "lengket" di atas
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer', -- Pangkas scope yang terlalu besar
  },
}
