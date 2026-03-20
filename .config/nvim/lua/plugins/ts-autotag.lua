return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    opts = {
      enable_close = true,           -- Tutup tag otomatis
      enable_rename = true,          -- Rename tag pembuka otomatis ubah tag penutup
      enable_close_on_slash = false, -- Tutup tag saat ketik /
    },
  },
}
