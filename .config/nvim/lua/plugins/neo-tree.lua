return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    -- Shortcut untuk buka/tutup explorer
    { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Explorer" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- Tampilkan file tersembunyi (dotfiles)
      },
      follow_current_file = { enabled = true }, -- Fokus ke file yang sedang dibuka
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "none", -- Disable space agar tidak konflik dengan leader
      },
    },
  },
}
