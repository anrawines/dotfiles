" --- Startify Configuration ---

" Custom ASCII Header (You can use a site like 'patorjk' to generate your own)
" Center the dashboard (add spaces to the left of your header)
let s:pad = '                '

let g:startify_custom_header = [
    \ s:pad . '██╗   ██╗██╗███╗   ███╗',
    \ s:pad . '██║   ██║██║████╗ ████║',
    \ s:pad . '██║   ██║██║██╔████╔██║',
    \ s:pad . '╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ s:pad . ' ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ s:pad . '  ╚═══╝  ╚═╝╚═╝     ╚═╝',
    \ s:pad . '                       ',
    \ s:pad . '     Time: ' . strftime('%H:%M') . '           ',
    \ s:pad . '________________________________',
    \ ]
" Define the specific shortcuts for the 'commands' section above
let g:startify_commands = [
      \ {'f': ['  Find File (FZF)', 'Files']},
      \ {'r': ['  Recent Files (FZF)', 'History']},
      \ {'b': ['  Buffers (FZF)', 'Buffers']},
      \ {'c': ['  Edit Config', 'edit ~/.config/.vim/vimrc']},
      \ {'u': ['  Update Plugins', 'PlugUpdate']},
      \ {'q': ['󰩈  Quit Vim', 'qa']},
      \ ]

" Limit the recent files so it stays 'Simple'
let g:startify_files_number = 5

" Use the keys we defined (f, r, b, c, etc.) as the shortcuts
" let g:startify_custom_indices = ['f', 'r', 'b', 'c', 'u', 'q']
" Match your Tokyonight theme colors
highlight StartifyHeader  ctermfg=117 guifg=#7aa2f7
highlight StartifySection ctermfg=215 guifg=#ff9e64
highlight StartifyFile    ctermfg=159 guifg=#73daca
highlight StartifyBracket ctermfg=240 guifg=#414868
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
" Turn off the default 'header' for the lists to keep it tight
let g:startify_relative_path = 1
let g:startify_change_to_dir = 1
" 3. CRITICAL: Don't let the 'Recent Files' use the same letters.
" This forces the Recent Files to use numbers [0-9] so they don't 
" conflict with your 'f', 'h', 'b' keys.
let g:startify_update_oldfiles = 1
let g:startify_enable_special = 0
" Force Startify to use your custom indices instead of numbers [1, 2, 3]
" The 'Custom List' - This is where the magic happens
let g:startify_lists = [
      \ { 'type': 'commands',  'header': [s:pad . '  ⚡  QUICK ACTIONS'] },
      \ { 'type': 'files',     'header': [s:pad . '    RECENT FILES (TOP 5)'] },
      \ ]


