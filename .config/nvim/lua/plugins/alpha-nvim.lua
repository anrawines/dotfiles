return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Plugin Counter
		local stats = require("lazy").stats()
		dashboard.section.footer.val = "󰚰  " .. stats.count .. " plugins loaded"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Import koleksi eksternal
		local ascii = require("config.ascii")

		-- 1. Tambahkan Seed agar benar-benar acak berdasarkan waktu
		math.randomseed(os.clock() * 1000000)
		--vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#1793D1" })

		-- 1. Daftar warna random (Hex Code)
		local colors = {
			"#81A1C1", -- Frost Blue
			"#B48EAD", -- Aurora Purple
			"#A3BE8C", -- Aurora Green
			"#EBCB8B", -- Aurora Yellow
			"#BF616A", -- Aurora Red
			"#5E81AC", -- Deep Blue
			"#88C0D0", -- Cyan
		}

		-- 2. Pilih warna acak
		local random_color = colors[math.random(#colors)]

		-- 3. Terapkan warna ke Highlight Group "AlphaHeader"
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = random_color })

		-- 4. Pilih header secara acak
		dashboard.section.header.val = ascii.headers[math.random(#ascii.headers)]

		-- Terapkan highlight ke header
		dashboard.section.header.opts.hl = "AlphaHeader"

		-- Tambahkan ini di antara header dan buttons
		dashboard.config.layout[3] = { type = "padding", val = 2 }

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
			dashboard.button("n", "  New File", ":ene | startinsert <CR>"),
			dashboard.button("g", "󰱼  Live Grep (Find Text)", ":Telescope live_grep <CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
			dashboard.button("p", "󱏒  Projects / Folders", ":Telescope folders <CR>"), -- Butuh plugin tambahan atau cd
			dashboard.button("c", "  Check Health", ":checkhealth <CR>"),
			dashboard.button("m", "  Mason", ":Mason <CR>"),
			dashboard.button("u", "󰚰  Update Plugins", ":Lazy sync<CR>"),
			dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
		}

		alpha.setup(dashboard.config)
	end,
}
