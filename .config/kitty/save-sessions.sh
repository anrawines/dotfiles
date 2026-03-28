kitty @ ls > state.json

python3 -c "
import json
data = json.load(open('state.json'))
for tab in data[0]['tabs']:
    print(f'new_tab {tab[\"title\"]}')
    print(f'layout {tab[\"layout\"]}')
    for i, win in enumerate(tab['windows']):
        fg = win.get('foreground_processes', [])
        prog = fg[0]['cmdline'][0] if fg else win['cmdline'][0]
        
        args = ''
        if fg and len(fg[0]['cmdline']) > 1:
            args = ' ' + ' '.join(fg[0]['cmdline'][1:])

        location = '' if i == 0 else '--location=vsplit '
        
        # FIX: Wrap the command so the window stays open after the app closes
        # This tells fish: run the program, then 'exec' a new fish shell
        wrapped_cmd = f'fish -c \"{prog}{args}; exec fish\"'
        
        print(f'launch {location}--cwd {win[\"cwd\"]} {wrapped_cmd}')
" > mysession.session
