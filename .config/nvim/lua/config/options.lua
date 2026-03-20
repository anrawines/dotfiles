--vim.opt.number = true
--vim.opt.cursorline = true
--vim.opt.relativenumber = true
--vim.opt.shiftwidth = 4

-- ============================================
-- UI & Visual Settings
-- ============================================
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers (from your config)
vim.opt.cursorline = true -- Highlight current line (from your config)

vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.showmode = false -- Don't show mode (modern statuslines show this)
vim.opt.background = "dark"
-- Column indicators
vim.opt.signcolumn = "yes" -- Always show sign column (for git, diagnostics)
vim.opt.colorcolumn = "80" -- Visual line length guide at 80 columns

-- Scrolling behavior
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor when scrolling
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right when horizontal scrolling
vim.opt.smoothscroll = true -- Enable smooth scrolling

-- ============================================
-- Text Editing & Indentation
-- ============================================
vim.opt.shiftwidth = 4 -- Size of an indent level (from your config)
vim.opt.tabstop = 4 -- Number of spaces a <Tab> counts for
vim.opt.softtabstop = 4 -- Number of spaces for <Tab> in insert mode
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.autoindent = true -- Copy indent from current line when starting new line

-- Line wrapping
vim.opt.wrap = false -- Don't wrap lines by default
vim.opt.linebreak = true -- Wrap at word boundaries (when wrap is enabled)
vim.opt.breakindent = true -- Maintain indent when wrapping text

-- ============================================
-- Search & Replace
-- ============================================
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Case sensitive if search contains uppercase
vim.opt.hlsearch = true -- Highlight all search matches
vim.opt.incsearch = true -- Show matches as you type
vim.opt.inccommand = "nosplit" -- Show substitution results as you type

-- ============================================
-- File Management
-- ============================================
-- Undo/Backup settings
vim.opt.undofile = true -- Persistent undo history across sessions
vim.opt.backup = false -- Disable backup files
vim.opt.swapfile = false -- Disable swap files
vim.opt.writebackup = false -- Disable backup before overwriting a file

-- Undo directory (create this directory first: mkdir -p ~/.vim/undodir)
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- File handling
vim.opt.autoread = true -- Automatically reload files changed outside vim
vim.opt.autowrite = true -- Auto save before certain commands
vim.opt.hidden = true -- Allow switching buffers without saving

-- Encoding
vim.opt.fileencoding = "utf-8" -- File encoding
vim.opt.encoding = "utf-8" -- Internal encoding

-- ============================================
-- Window & Buffer Management
-- ============================================
-- Split behavior
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below

-- Window sizing
vim.opt.winminheight = 0 -- Allow windows to be 0 lines high
vim.opt.winminwidth = 5 -- Minimum window width of 5 columns
vim.opt.equalalways = false -- Don't auto-resize windows

-- ============================================
-- Performance & Responsiveness
-- ============================================
vim.opt.lazyredraw = true -- Don't redraw screen while executing macros
vim.opt.updatetime = 50 -- Faster completion (default: 4000ms)
vim.opt.timeoutlen = 300 -- Time to wait for a mapped sequence (ms)
vim.opt.ttimeoutlen = 10 -- Time to wait for key code sequence (ms)

-- ============================================
-- Input & Interaction
-- ============================================
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.clipboard = "unnamedplus" -- Use system clipboard for yank/paste

-- Command line
vim.opt.cmdheight = 1 -- Height of command line
vim.opt.wildmenu = true -- Enhanced command-line completion
vim.opt.wildmode = "longest:full,full" -- Completion mode for command line

-- ============================================
-- Folding
-- ============================================
vim.opt.foldmethod = "indent" -- Fold based on indentation
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldnestmax = 10 -- Maximum nested folds
vim.opt.fillchars = "fold: " -- Character to show for folds

-- ============================================
-- Completion & Suggestions
-- ============================================
vim.opt.completeopt = "menuone,noselect" -- Better completion experience
vim.opt.shortmess = "filnxtToOFc" -- Avoid hit-enter prompts

-- ============================================
-- Miscellaneous
-- ============================================
vim.opt.title = true -- Set terminal title
vim.opt.guicursor = "" -- Use block cursor in all modes
vim.opt.conceallevel = 0 -- Don't conceal text (for markdown, JSON, etc.)
vim.opt.spell = false -- Disable spell checking by default
vim.opt.spelllang = "en" -- English spell checking when enabled

-- Better diff
vim.opt.diffopt = vim.opt.diffopt + "vertical" -- Use vertical splits for diff
vim.opt.diffopt = vim.opt.diffopt + "iwhite" -- Ignore whitespace in diff

-- ============================================
-- Keymaps (Optional - Uncomment if needed)
-- ============================================
-- Set leader key to space
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Example mappings:
-- vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- ============================================
-- Final Notes
-- ============================================
-- Note: Before using this config, create the undo directory:
-- mkdir -p ~/.vim/undodir

-- To enable specific features for certain filetypes, consider using
-- filetype-specific configs in ftplugin/ directory
