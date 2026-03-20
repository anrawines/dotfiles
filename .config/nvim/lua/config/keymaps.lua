vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<ESC>")                -- Faster way to exit insert mode

-- Navigasi window dengan Ctrl + h/j/k/l
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })

-- Pindah buffer (tab) lebih cepat
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Prev buffer" })
-- Tutup buffer saat ini
vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Close buffer" })

-- Di Visual Mode, pindahkan baris yang diseleksi ke atas/bawah
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Hilangkan highlight pencarian dengan Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Jaga kursor tetap di tengah saat scroll setengah layar
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Jaga kursor tetap di tengah saat mencari kata (n/N)
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank ke clipboard sistem
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Simpan file dengan Space + w
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
-- Exit
vim.keymap.set('n', '<leader>q', ':q!<CR>', { noremap = true, silent = true })

-- Buka file explorer (Neo-tree yang tadi kita pasang)
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorer" })

--terminal
vim.keymap.set("n", "<leader>st", ":split | terminal<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under cursor" })
