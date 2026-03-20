-- :Mason untuk install formatter
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Jalan otomatis SEBELUM file disimpan
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" }, -- Merapikan import dan baris kode
      sh = { "shfmt" },              -- Merapikan skrip Bash/Shell
      markdown = { "prettierd", "prettier", stop_after_first = true },
    },
    -- Opsi: Format otomatis saat save
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
